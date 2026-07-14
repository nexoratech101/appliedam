# AppliedAM — Notes for Claude (Cowork sessions)

## Replacing a generated image with a real photo (hero or figure)

Context: articles are sometimes first published with an AI-generated schematic/diagram
image (hero.jpg / figure1.jpg) as a placeholder, then later swapped for a real photo the
user has (or a real figure from a paper/site they cite). This is the reliable procedure.

### Procedure

1. **User uploads the real photo to Google Drive** (My Drive, any location — e.g. the
   `AppliedAM` folder), or uploads it directly into the chat as an attachment. Either way,
   confirm you know the source (fileId in Drive, or local upload path) before proceeding.

2. **If it's in Drive**: use the Google Drive connector's `search_files`, e.g.
   `title contains '<part of filename>'` or filter by `modifiedTime > '<recent ISO time>'`.
   Confirm the fileId, title, mimeType, fileSize. Then call `download_file_content` with
   that fileId. If the file is large, the tool saves the full JSON
   (`{content, id, mimeType, title}`, base64 in `content`) to a local path under
   `.../tool-results/mcp-...-download_file_content-*.txt` instead of returning it inline.
   Decode it directly to a file with Python — **never** read/paste the raw base64 through
   the chat context, and never manually retype a large base64 blob into another tool call
   (see "The base64/data-URI dead end" below for why that specifically fails):
   ```
   python3 -c "
   import json, base64
   d = json.load(open('<tool-result-path>'))
   open('/tmp/work/real_photo.jpg','wb').write(base64.b64decode(d['content']))
   "
   ```
   If it's a chat attachment instead, it's already a plain file on local disk (check
   `/root/.claude/uploads/<session>/...`) — just read/process it directly, no decode step.

3. **Resize/optimize for web** if the source is large. Target ~1600px on the long edge for
   photos, JPEG quality ~80-85 (a smaller/lower-quality target is fine for a reused figure
   that's already low-res, e.g. from a paper):
   ```
   python3 -c "
   from PIL import Image, ImageOps
   im = ImageOps.exif_transpose(Image.open('/tmp/work/real_photo.jpg')).convert('RGB')
   if im.width > 1600:
       im = im.resize((1600, int(im.height*1600/im.width)), Image.LANCZOS)
   im.save('/tmp/work/hero_web.jpg', 'JPEG', quality=82, optimize=True)
   "
   ```

4. **Clone and push using the default `origin` remote — do NOT inject any token into the
   URL yourself.** This is the single most important correction in this file (see "Git push
   actually works" below for the full story of why earlier notes said otherwise):
   ```
   git clone https://github.com/nexoratech101/appliedam.git /tmp/appliedam-work
   cd /tmp/appliedam-work && git checkout master
   # ...make your changes...
   git add <changed paths>
   git -c user.email="randima005@gmail.com" -c user.name="AppliedAM Autopublish" commit -m "..."
   git push origin master
   ```
   Branch is `master`, NOT `main` (main is an unused empty default branch). Do not do git
   operations in the user's connected Desktop folder copy of this repo — that folder is
   Google-Drive-Desktop-synced and its bash-mount view lags/caches badly for binary files
   (confirmed separately from the token issue below). Always use a fresh `/tmp` clone.

5. **Cache-busting**: if you are REPLACING an image at a path that has already been
   deployed/live (not a brand-new article), do NOT just overwrite the same filename.
   Cloudflare's edge cache and browsers cache images by URL. Instead:
   - Copy to a new filename, e.g. `hero-v2.jpg` (bump the suffix each time: v3, v4, ...).
   - `git rm` the old filename.
   - Update `featured_image:` frontmatter and any inline `![...](...)` reference to match.
   - Commit and push.

6. Report the live URL (`https://appliedam.net/insights/<slug>/`) and mention the
   Cloudflare build takes 1-3 minutes.

### Git push actually works — use the default `origin` remote, not a manually-supplied token
Corrected July 2026, after a long detour caused by testing the wrong thing. The sandbox's
`GITHUB_TOKEN`/`GH_TOKEN` env vars are real, but **read-only** (confirmed:
`curl -H "Authorization: Bearer $GITHUB_TOKEN" https://api.github.com/repos/.../appliedam`
returns 200 with `"permissions": {"push": false, ...}`). Manually building a push URL with
that token (`git push https://x-access-token:$GITHUB_TOKEN@github.com/...`) fails with
"Invalid username or token" — this led an earlier version of this file to wrongly conclude
"no working git-push token exists in this environment" and build increasingly elaborate
(and unreliable) base64/data-URI workarounds instead. **That conclusion was wrong.**

The actual fix: a plain `git clone https://github.com/nexoratech101/appliedam.git` (no
token in the URL at all) picks up a pre-configured `url.insteadOf`-style git config
(`GIT_CONFIG_KEY_*`/`GIT_CONFIG_VALUE_*` env vars set on the sandbox) that transparently
rewrites `origin` to route through a local authenticated proxy
(`http://local_proxy@127.0.0.1:<port>/git/nexoratech101/appliedam.git`). That proxy — not
the raw `GITHUB_TOKEN` — is what has real write access. Confirmed by pushing a real test
branch and a real commit with two binary JPEGs to `master`; both succeeded, and the pushed
images verified byte-identical via `curl .../raw.githubusercontent.com/...` + `md5sum`
against the source files. (One caveat: the proxy could push new branches/commits but
returned 403 on `git push origin --delete <branch>` — branch deletion isn't permitted, so
don't rely on being able to clean up a mistakenly-pushed branch; be careful about what you
push in the first place, and prefer fixing forward with a new commit over trying to delete.)

**Bottom line: always just `git clone`/`git push` normally with no token substitution.** If
that fails in some future session, THEN investigate — don't assume a manual token workaround
is the fix; test the plain default-remote path first, since that's what actually works.

### The base64/data-URI dead end (historical — do not repeat this)
Earlier sessions (before the fix above was found) spent a lot of effort on this and it
never worked reliably. Recorded here only so a future session doesn't re-attempt it:
`create_or_update_file`'s `content` parameter has no base64-decode step (unlike Google
Drive's `create_file`, whose `base64Content` IS decoded server-side into real binary) — so
pushing base64 image bytes as GitHub file `content` produces a text file containing literal
base64, not an image. Separately, embedding base64 as a data URI directly in article
markdown was ALSO unreliable: reproducing a large base64 blob as part of a tool-call
argument that also contains substantial surrounding prose corrupted the data almost every
time (confirmed via direct `curl` verification, so real corruption, not a checking
artifact) — even at modest sizes like ~4,200 characters in a ~9.3KB total file. An isolated
blob as a tool call's ENTIRE content (e.g. a zip pushed to Drive) transcribed fine even
above 10,000 characters, which is what led to the (correct, but incomplete) conclusion that
Drive backups were reliable while GitHub image pushes weren't. All of this is now moot with
a working git remote — don't reinvent it.

## Autopublish automation
A scheduled task (`appliedam-insights-autopublish`) runs every day and publishes a new
concise (650-800 word) journal-style Insights article every 2 days (cadence tracked in
`.autopublish/state.json`, not the cron schedule). Use the real git push path above for
images (hero + one figure), generating them via matplotlib with varied style each run,
*unless* a real figure/photo has been provided by the user for that article (then use that
instead, with a citation — see procedure above). Also back up the article's image assets as
a ZIP to Google Drive under `My Drive > AppliedAM > bot > <Month Year>` (filename pattern:
`AppliedAM_<ArticleSlugCamelCase>_Assets.zip`) for redundancy — this has always worked
reliably. See the scheduled task's own prompt for the full spec.
