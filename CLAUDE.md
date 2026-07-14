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
   "Pushing without a git token" below instead of blocking on this step.

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

### Pushing without a git token (Claude Code Remote / claude.ai sessions)
Confirmed July 2026: in a Claude Code Remote session, the sandbox env vars `GITHUB_TOKEN`
and `GH_TOKEN` look present but return 403 against the real GitHub API (`GitHub access is
not enabled for this session`) — they cannot be used for `git push`. The GitHub App must
instead be **installed** (not just OAuth-authorized) via `github.com/settings/installations`
→ Authorized GitHub Apps → click the app name (not Revoke) → Install → grant it access to
this repo with Contents: Read/write. Once installed, the `github` MCP server's own tools
(`create_or_update_file`, `delete_file`, `create_branch`, etc.) get real write access —
verify with a throwaway `create_branch` call before relying on it.

**`create_or_update_file`'s `content` parameter genuinely uploading binary was NOT the real
problem** (an earlier version of this note misdiagnosed it as one — corrected here). A
controlled test — generating a random ~4000-character base64-alphabet string locally,
pushing it as `content` verbatim, then downloading it back — came back **byte-for-byte
identical**. The tool round-trips text/base64 content correctly.

**The actual failure: reliably reproducing a large base64 string (tens of thousands of
characters) as a literal tool-call argument is not reliable.** Base64 for even a small
(~5-10KB) JPEG is 7,000-13,000+ characters of unstructured text that has to be read from a
prior tool result and then retyped/regenerated into the next tool call — and at that
length, characters get silently dropped or altered in transit (confirmed twice: two
separate image pushes came back with the wrong byte count and failed an MD5 check against
the source file, while the ~4000-char control string round-tripped fine). This is a
transcription-reliability limit, not an encoding bug, and it means embedding images as
base64 data URIs in article markdown is **not currently a safe technique** in this
environment — don't reach for it again without a way to move the bytes that doesn't require
literally retyping them (e.g. a tool that takes a local file path directly, or a real
working git-push token so the push happens from disk instead of through a chat argument).

**Current fallback: publish the article text-only (no `featured_image`, no inline figure)**
rather than risk a corrupted/unverified image on the live site. If you do attempt an
embedded-image push despite the above, you MUST verify it before considering the article
done: download the raw file back (`curl .../raw.githubusercontent.com/...`), extract the
base64, decode it, and MD5-compare against the source image — do not trust the push
response's reported size/success alone.

If a future session confirms a genuinely working git-push token, prefer real static image
files again (matches the convention of all prior articles) — pushing from a local git clone
never requires retyping binary content through a chat argument, so it doesn't have this
failure mode.

## Autopublish automation
A scheduled task (`appliedam-insights-autopublish`) runs every day and publishes a new
concise (650-800 word) journal-style Insights article every 2 days, following the same
git-via-/tmp-clone approach when a working push token is available. **If not (the common
case in Claude Code Remote sessions), publish the article text-only** — no `featured_image`,
no inline figure — rather than attempting a base64 data-URI embed (see "Pushing without a
git token" above for why that's unreliable). Still back up whatever image assets were
generated (even if they couldn't be published) as a small ZIP to Google Drive under
`My Drive > AppliedAM > bot > <Month Year>`, so a future session with a working push path
can attach them retroactively. See the scheduled task's own prompt for the full spec.
