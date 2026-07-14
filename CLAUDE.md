# AppliedAM — Notes for Claude (Cowork sessions)

## Replacing a generated image with a real photo (hero or figure)

Context: articles are sometimes first published with an AI-generated schematic/diagram
image (hero.jpg / figure1.jpg) as a placeholder, then later swapped for a real photo the
user has. This is the reliable procedure for that swap — do not try the local synced
Desktop folder route, it doesn't work (see "Why not the local folder" below).

### Procedure

1. **User uploads the real photo to Google Drive** (My Drive, any location — e.g. the
   `AppliedAM` folder). They just need to say something like "I've uploaded the new hero
   for <article slug/topic>."

2. **Find it in Drive**: use the Google Drive connector's `search_files`, e.g.
   `title contains '<part of filename>'` or filter by `modifiedTime > '<recent ISO time>'`.
   Confirm the fileId, title, mimeType, fileSize.

3. **Download without blowing up context**: call `download_file_content` with that fileId.
   If the file is large, the tool will refuse to return it inline and instead save the
   full JSON (`{content, id, mimeType, title}`, base64 in `content`) to a local path under
   `.../.claude/projects/.../tool-results/mcp-...-download_file_content-*.txt`. That path
   IS reachable from bash (search with `find / -iname "*download_file_content*" 2>/dev/null`
   if the exact path isn't in view). Decode it directly to a file with Python — never try
   to read/paste the raw base64 through the chat context, it's too large:
   ```
   python3 -c "
   import json, base64
   d = json.load(open('<tool-result-path>'))
   open('/tmp/work/real_photo.jpg','wb').write(base64.b64decode(d['content']))
   "
   ```

4. **Resize/optimize for web** if the source photo is large (phone/camera photos here have
   run 1.3–3MB at 3500px+). Target ~1600px on the long edge, JPEG quality ~80-85:
   ```
   python3 -c "
   from PIL import Image, ImageOps
   im = ImageOps.exif_transpose(Image.open('/tmp/work/real_photo.jpg')).convert('RGB')
   if im.width > 1600:
       im = im.resize((1600, int(im.height*1600/im.width)), Image.LANCZOS)
   im.save('/tmp/work/hero_web.jpg', 'JPEG', quality=82, optimize=True)
   "
   ```

5. **Push via a fresh /tmp clone of this repo** — do NOT do git operations directly in the
   user's connected Desktop folder copy of this repo. That folder is Google-Drive-desktop
   synced and its bash-mount view lags/caches badly (confirmed: edits made there through
   Windows Explorer were not visible to bash even after minutes of waiting, while the
   Read/Write file tools DID see them — the two access paths are not in sync). Always:
   ```
   git clone https://<TOKEN>@github.com/nexoratech101/appliedam.git /tmp/appliedam-work
   cd /tmp/appliedam-work && git checkout master
   ```
   (Token: ask the user if not already known for this session; it's a fine-grained PAT
   scoped to Contents: read/write on this repo only.)

   **If no working git push token is available** (true in Claude Code Remote / claude.ai
   sessions as of July 2026 — the sandbox's `GITHUB_TOKEN`/`GH_TOKEN` env vars do NOT
   authenticate against the real GitHub API, they're session-internal placeholders), see
   "Publishing images without a git token" below — real static image files are NOT
   currently achievable through the MCP tools alone; don't attempt it, publish text-only.

6. **IMPORTANT — cache-busting**: if you are REPLACING an image at a path that has already
   been deployed/live (i.e. this isn't a brand-new article), do NOT just overwrite the same
   filename. Cloudflare's edge cache and users' browsers cache images by URL, so overwriting
   `hero.jpg` in place can leave old bytes showing on the article page (and in search
   results) even though the homepage/other pages that re-fetch may show the new one. Instead:
   - Copy to a new filename, e.g. `hero-v2.jpg` (bump the suffix each time: v3, v4, ...).
   - `git rm` the old filename.
   - Update the `featured_image:` frontmatter field and any inline `![...](...)` reference
     in the article's `.md` file to point at the new filename.
   - Commit and push.

7. **Commit + push**:
   ```
   git add <changed paths>
   git -c user.email="randima005@gmail.com" -c user.name="AppliedAM Autopublish" commit -m "..."
   git push https://<TOKEN>@github.com/nexoratech101/appliedam.git master
   ```
   Branch is `master`, NOT `main` (main is an unused empty default branch).

8. **Courtesy copy**: after a successful push, you can also try writing the same final
   image into the user's connected Desktop folder path via the Write tool (not bash) so
   their local copy matches — but this is optional and not required for the live site to
   be correct.

9. Report the live URL (`https://appliedam.net/insights/<slug>/`) and mention the
   Cloudflare build takes 1-3 minutes, plus that a plain reload (no hard-refresh needed)
   will show the new image once the new filename is live.

### Why not the local synced Desktop folder
The user's connected folder (`C:\Users\Administrator\Desktop\appliedam`) is the same repo,
kept in sync via what looks like Google Drive Desktop (evidence: `.tmp.drivedownload` /
`.tmp.driveupload` staging folders, and an earlier commit "Ignore Google Drive sync staging
folder"). File edits made there (via Explorer, or by asking Claude to overwrite a file with
the Write tool) are visible almost immediately through the Read/Write/Edit file tools, but
the separate bash/shell mount of the same folder can lag arbitrarily (observed: still stale
after 75+ seconds and multiple retries) and even serve wrong bytes under a renamed file. Do
not trust bash reads of that folder for anything binary/important — always work from a
fresh git clone instead.

### Publishing images without a git token (Claude Code Remote / claude.ai sessions)
Confirmed and re-tested July 2026, across multiple sessions — this is the settled finding,
superseding earlier (partially wrong) notes in this file's history:

**1. `GITHUB_TOKEN`/`GH_TOKEN` in the sandbox cannot be used for `git push`.** They return
403 against the real GitHub API. The `github` MCP server's own tools can still get real
write access if the GitHub App is properly **installed** (not just OAuth-authorized) via
`github.com/settings/installations` → Authorized GitHub Apps → click the app name (not
Revoke) → Install → grant Contents: Read/write on this repo. Verify with a throwaway
`create_branch` call before relying on it.

**2. Even with write access, `create_or_update_file`'s `content` parameter cannot produce
real binary files, structurally — not a bug, just how it works.** It stores exactly the
text you pass, with no base64-decode step (unlike Google Drive's `create_file`, whose
`base64Content` parameter IS properly decoded server-side into real binary — confirmed
working by pushing a 9754-byte zip's base64 and downloading it back byte-identical, valid
per `unzip -t`). So pushing base64-encoded image bytes as GitHub's `content` produces a
`.jpg` file containing literal base64 text, not image data — this is unfixable by trying
harder, there is no equivalent binary-aware parameter on the GitHub side.

**3. Embedding base64 as a data URI directly inside the article's markdown text does NOT
work around #2, and has its own separate reliability problem: reproducing a large base64
string as part of a tool-call argument that ALSO contains substantial surrounding text
(the article prose) is not reliable, even at modest sizes and even when the base64 was
just read moments earlier.** Tested extensively: a ~13,000-character blob spliced into
~19KB of total content corrupted; a smaller ~7,000-character blob in ~12KB total corrupted;
even a ~4,200-character blob in ~9.3KB total corrupted by 33 characters — confirmed via
direct `curl` fetch of the live file (bypassing any manual retyping on the verification
side, so the corruption is real and happens at the push step itself, not verification).
By contrast, a large base64 blob as the ENTIRE, ONLY content of a tool call (nothing else
sharing the parameter) transcribes correctly even above 10,000 characters — the zip test
in point 2 proves this. So the failure is specifically about mixing a large opaque blob
with substantial other text in one generated argument, not about size alone.

**Net effect: there is currently no reliable way to get a real, working image onto an
article page through the available MCP tools in a Claude Code Remote session.** Don't
attempt data URIs or binary pushes via `create_or_update_file` for article images — every
attempt so far has produced a corrupted or non-functional result, several rounds of
"looks like it worked" turned out not to on verification. **Publish articles text-only**
(omit `featured_image` and any inline figure) instead.

**What DOES work reliably**: pushing a self-contained asset ZIP to Google Drive via
`create_file`'s `base64Content` parameter (see Autopublish automation below) — because
that's exactly the point-2/point-3 "isolated blob, nothing else in the parameter" case
that's proven reliable. Use this to preserve the generated images for a future session
that has a genuine git-push credential to attach them properly.

If a future session confirms a genuinely working git-push token, prefer real static image
files again (matches the convention of all prior articles) — pushing from a local git clone
never requires retyping binary content through a chat argument at all, so none of the
above failure modes apply.

## Autopublish automation
A scheduled task (`appliedam-insights-autopublish`) runs every day and publishes a new
concise (650-800 word) journal-style Insights article every 2 days, following the same
git-via-/tmp-clone approach when a working push token is available. **If not (the common
case in Claude Code Remote sessions), publish the article text-only** — no `featured_image`,
no inline figure (see "Publishing images without a git token" above — this is a settled,
tested conclusion, not worth re-attempting each run). Still back up whatever image assets
were generated as a ZIP to Google Drive under `My Drive > AppliedAM > bot > <Month Year>`
(filename pattern: `AppliedAM_<ArticleSlugCamelCase>_Assets.zip`, matching prior runs) —
this upload path is reliable (see above) even though the GitHub one isn't, and it lets a
future session with real git access attach the images retroactively. See the scheduled
task's own prompt for the full spec.
