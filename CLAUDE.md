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

**However, `create_or_update_file`'s `content` parameter is text-only and does NOT
correctly upload binary files.** Passing base64-encoded image bytes as `content` does not
get decoded server-side the way the raw GitHub Contents API does — it gets stored verbatim
as a text file (i.e. you get a `.jpg` that is literally the base64 string, not a real
image). Confirmed by pushing then re-downloading via `raw.githubusercontent.com` and
checking with `file` — it came back as `ASCII text`, not image data. There is no working
binary-upload path via the available MCP tools in this environment.

**Workaround: skip `static/images/insights/<slug>/` entirely and embed the images as
inline base64 data URIs directly in the article markdown** — both in the `featured_image:`
frontmatter value and the inline `![...](...)` figure reference:
```
featured_image: "data:image/jpeg;base64,<b64string>"
...
![alt text](data:image/jpeg;base64,<b64string>)
```
This works because the `.md` file itself is plain text, so `create_or_update_file` handles
it correctly, and both Hugo's template (`background-image:url(...)`) and browsers render
data URIs identically to a file path. To keep this from blowing up the chat context when
reading the base64 back to construct the tool call, compress images hard first — JPEG,
~600-800px on the long edge, quality ~40-55 — targeting under ~10KB raw (so the base64
comfortably fits one `Read` call without truncation; the tokenizer is very inefficient on
base64, roughly 2 tokens per character). Two images at that size add ~20-30KB of text to
the article file, which is fine.

If a future session confirms it has a genuinely working git-push token or a fixed
binary-upload path, prefer real static image files again (matches the convention of all
prior articles) — this workaround exists only because of the current environment's tooling
gap, not because it's the better long-term approach.

## Autopublish automation
A scheduled task (`appliedam-insights-autopublish`) runs every day and publishes a new
concise (650-800 word) journal-style Insights article every 2 days, following the same
git-via-/tmp-clone approach (or the data-URI workaround above if no push token is
available), generating its own hero/figure diagrams via matplotlib (varied style each
run), and backing up a small asset ZIP to Google Drive under
`My Drive > AppliedAM > bot > <Month Year>`. See the scheduled task's own prompt for the
full spec.
