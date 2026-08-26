# AppliedAM — Notes for Claude (Cowork sessions)

## Outreach email template (`outreach/01_initial_outreach.html`)
Added August 2026, after the first live AM Company Outreach run sent real emails instead of
leaving them as drafts, and a follow-up review of the template itself.

- **Subject line**: short curiosity-hook pattern, tracked in the HTML comment on line 1:
  `Quick question about {{COMPANY_NAME}}'s {{TECH_PLATFORM}}`. The in-body H1 heading should
  be kept in sync with this - do not let the subject and the visible heading diverge (this
  happened once: subject was updated but the H1 still read the old "Hi {{FIRST_NAME}}, the
  engineering behind..." pattern).
- **No fake urgency/self-deprecating P.S.** - a line asking recipients to redirect us to a
  different story if this "isn't their most exciting work" was removed; don't re-add
  editorializing asides like that to the template.
- **Opt-out line**: required, placed as the last, smallest, lowest-contrast line in the
  footer (below the Editorial Team identity block): "If you'd rather not receive emails like
  this from us, just reply and let us know - we'll take you off the list." This is a manual,
  reply-based opt-out (no subscription-management system exists yet) - when someone replies
  asking to be removed, mark that company's row in `appliedam-outreach-tracker.xlsx`,
  "Outreach Status" = "Opted out" (this is now a valid dropdown option on that column via data
  validation). Future outreach runs should check for and skip rows marked "Opted out", not
  just dedupe on company name.
- **Footer layout/order** (top to bottom, standard email footer convention): brand blurb →
  Editorial Team identity block (name, site, address; required for CAN-SPAM) with a white
  LinkedIn icon (`https://img.icons8.com/ios-filled/50/FFFFFF/linkedin.png`, 22px, linked to
  `https://www.linkedin.com/company/applied-am`) right-aligned inside that same dark-blue
  block → opt-out line last, smallest text. Keep social/identity grouped together and the
  opt-out line visually separate/last.
- **Never actually send outreach emails without explicit user instruction** - only ever
  create/update Gmail drafts (`create_draft` / `update_draft`), never move a message to
  Sent. A past run's `update_draft` call was followed by the message actually sending; treat
  that as a one-off failure mode to watch for, not expected behavior - always verify via
  `list_drafts`/`search_threads` that outreach messages are still in Draft/have not gone to
  Sent before ending a run.
- **Don't draft an email at all if there's no correct, verifiable named contact to address it
  to.** A generic press@/marketing address or a blank recipient is not sufficient - if
  research can't verify a real named individual (and ideally a working email for them), skip
  drafting for that company entirely rather than creating a draft with no "to" or an
  impersonal fallback recipient.
- **Research order for token efficiency**: for each candidate company, (1) quick company ID +
  confirm it's a genuine printer-hardware OEM and pick its technology category (cheap,
  disqualifying), (2) find a named contact + verify a real email - hard stop here if none is
  found, don't proceed to steps 3-4 for that company, (3) full technical/company research for
  the tracker row, (4) draft the email. Front-load the two cheap disqualifiers (not an OEM, no
  verifiable contact) before spending tokens on deep research and drafting.

## Topic and title framing: lead with progress, not failure
Added August 2026, after the user flagged that recent Insights titles/topics skewed negative
or problem-focused: "Why AM Parts Still Struggle to Qualify," "Why 3D-Printed Parts Miss Their
Tolerance," "The Recycled Filament Ceiling," "Why 3D-Printed Ceramics Still Crack." Going
forward, the topic angle, title, description, and opening paragraph of every Insights article
should be framed around progress, capability, or a clear positive explainer, not around a
limitation, failure, or unresolved problem.

Concretely:
- Avoid title constructions built on lack/failure/limitation words: "struggle," "miss,"
  "ceiling," "crack," "still doesn't," "fails," "problem nobody's solved." Prefer titles built
  on what a technique enables, how something actually works, or a concrete advance.
- Real technical limitations can and should still be discussed rigorously in the article body.
  This is not about hiding constraints or writing marketing copy, it's about which layer of the
  piece carries the negative framing. The body can be as rigorous and critical as warranted;
  the title, description, and opening paragraph should lead with what's working or advancing,
  treating limitations as one part of a fuller picture rather than the whole premise.
- Self-check before finalizing any title: if its main verb or noun is a deficit/failure word,
  rewrite it around the same topic from a capability/progress angle instead. E.g. "Why
  3D-Printed Parts Miss Their Tolerance" becomes something like "What It Takes to Hit Tight
  Tolerances in FDM and SLA," same technical content, different frame.
- This applies to every editorial persona equally, including the Skeptic persona (see
  `appliedam-voice-skeptic` skill), whose natural material is failure modes and tolerancing.
  Its rigor and skepticism belong in the article body's analysis, not in a negatively-framed
  title or premise, see that skill for the full treatment of this distinction.
- Both `appliedam-insights-autopublish` (which applies this at draft time) and
  `appliedam-standards-check` (which audits it weekly, flagging any framing miss with a
  suggested alternative) have this rule built in as of August 2026.

## Writing voice: articles must not read as AI-generated
Added July 2026, after a user review flagged an autopublished article as reading "dry,"
"like a robot," with "no soul." The issue was not factual accuracy — it was sentence-level
pattern: long compound sentences stacked with multiple "which/and/but" clauses, heavy and
uniform use of em dashes, and a staccato "It is X. It does Y. It does Z." rhythm once those
long sentences got mechanically shortened. Both extremes read as AI-generated. Avoid both.

What to do instead when drafting or revising Insights articles:
- Vary sentence length deliberately. Mix short, punchy sentences with longer ones that
  actually need the length — don't make every sentence the same size, and don't chop
  everything into uniform short clauses either (that pattern is its own tell).
- Do not use em dashes (—) in article body text. Use a hyphen with spaces instead
  (` - `), consistent with the existing site standard tracked in the
  `appliedam-standards-check` scheduled task. Check with
  `grep -c "—" content/insights/<slug>.md` before finalizing — it should return 0.
- Avoid formulaic AI-writing tics: repeated "The practical consequence is...", "None of
  this argues...", parenthetical citation dumps like `(Smith, 2020; Jones, 2021)` bunched
  at a sentence's end, and semicolon-heavy compound sentences that pack three ideas into
  one clause. Weave citations naturally into individual sentences instead (see the
  "Topic selection" / Step 3 guidance already in the autopublish task for the "not a
  trailing list" citation rule — this is the same principle applied to sentence rhythm).
- Let some personality and phrasing choices through: contractions where natural ("it's,"
  "doesn't"), a rhetorical aside, a concrete comparison or analogy, a mild opinion in the
  closing paragraph. Journal-grade and technically rigorous does not mean flat.
- After drafting, do a self-read specifically for this: if three consecutive sentences all
  follow the same subject-verb-object shape and length, rewrite at least one of them.

## Image naming convention (finalized July 2026 — supersedes earlier "hero"/"figure1" rule)
Every article has exactly two image roles. Naming is fixed to avoid conflicts between the
AI-generated figures and the externally uploaded photo:
- **Image 1** / **Image 2** (`image1.jpg`, `image2.jpg`): the two AI-generated
  diagrams/figures produced by autopublish. These are ALWAYS AI-generated, never renamed
  to anything else, and always live inline in the article body, each with its own caption,
  placed wherever in the body they best support the text (not fixed to a "before the intro"
  or "after the intro" position — use judgment per article).
- **Featured image / thumbnail** (`featured_image:` frontmatter only, used by the site's
  card/listing templates and social previews): this is the externally/user-uploaded real
  photo. It must NEVER be referenced inline in the article body.
  - **Until a real photo is uploaded**, one of the two AI-generated images (Image 1 or
    Image 2, whichever fits better as a lead image) stands in as `featured_image:`. This is
    a frontmatter-only assignment — that image is not duplicated or specially marked, it's
    simply pointed to by `featured_image:` while remaining Image 1/Image 2 in the body.
  - **Once the real photo is uploaded**, it replaces `featured_image:` and the stand-in
    AI image reverts to being purely an inline body figure (no longer referenced by
    `featured_image:`). Image 1 and Image 2 as they appear in the body are untouched by
    this swap — do not remove or alter them unless separately asked.

## Replacing a generated image with a real photo (featured image / thumbnail only)

Context: articles are first published with an AI-generated placeholder as the featured
image/thumbnail, then later swapped for a real photo the user has (or a real figure from a
paper/site they cite). This only ever touches `featured_image:` in frontmatter — never the
inline Image 1 / Image 2 in the body. This is the reliable procedure.

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
   - Copy to a new filename, e.g. `featured-v2.jpg` (bump the suffix each time: v3, v4, ...).
   - `git rm` the old filename.
   - Update `featured_image:` frontmatter ONLY to the new filename. Do NOT add or touch any
     inline `![...](...)` reference in the article body — the featured image/thumbnail is
     frontmatter-only (see "Image naming convention" above). If an inline reference to the
     old featured image exists in the body from before this rule was corrected, remove that
     inline block entirely rather than updating it to the new filename.
   - Commit and push.

6. **Add image credit frontmatter for the real photo.** Discovered August 2026: the site
   template (`layouts/_default/single.html`, look for `photo_credit_name`) already renders
   an "Image credits" block in the sidebar whenever these frontmatter fields are present —
   no template changes needed, just set the fields on the article:
   ```
   photo_credit_type: "Image credits"
   photo_credit_label: "Photo by"
   photo_credit_name: "<name of the photographer, studio, or institution that made the image>"
   photo_credit_url: "<link to that person/entity, if you have one — omit the field if not>"
   photo_credit_source: "<name of the site/publication/repo the photo came from, e.g. Printables.com, a journal name>"
   photo_credit_source_url: "<link to the specific page/PDF/listing the photo came from>"
   ```
   Always set these whenever `featured_image:` is pointed at a real (non-AI-generated)
   photo — whether it's a user-uploaded photo or a real figure pulled from a paper/site
   being cited, per the "real figure/photo... with a citation" language in the autopublish
   task. Add this in the SAME commit as the featured-image swap (step 5), not a separate
   pass. Skip these fields entirely when `featured_image:` still points at an AI-generated
   Image 1/Image 2 stand-in — the block should only appear once a real photo is live.
   See `content/insights/the-recycled-filament-ceiling.md` for a working example of the
   field values, and `layouts/_default/single.html` (~line 43) for how they render.

7. Report the live URL (`https://appliedam.net/insights/<slug>/`) and mention the
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

### Featured image/thumbnail stays OUT of the article body (corrected July 2026)
This reverses an earlier (wrong) rule that said the hero had to appear in both frontmatter
and the body. That caused real confusion once real-photo swaps started happening: the user
had to remove the inline copy by hand and clarified the correct behavior is featured image =
frontmatter only. Going forward:
1. `featured_image:` in frontmatter is the ONLY place the featured image/thumbnail appears.
   Never add an inline `![...]` reference to it in the article body.
2. Image 1 (and Image 2, if used) are the AI-generated diagrams/figures that live inline in
   the body, each with its own caption. These are unaffected by any later featured-image
   photo swap.
The user's usual workflow: autopublish generates Image 1 and Image 2, points `featured_image:`
at whichever of the two stands in as the placeholder thumbnail, then the user separately
uploads a real photo to Google Drive later for Claude to swap into `featured_image:` only
(see "Image naming convention" above for the exact stand-in rule, and "Replacing a generated
image with a real photo" above).

### Topic selection: rotate across domains, don't cluster on metal AM
Amended July 2026. Additive manufacturing is a broad field — metal AM (LPBF, DED, binder
jetting) is only one part of it. Before picking a topic, check the last several entries in
`published_topics` / recent `content/insights/*.md` files. If recent articles have clustered
in one domain (metal AM has been over-represented — e.g. several of the last few were metal
processes/QC back to back), deliberately pick from a different area this time instead of
adding another metal piece. Areas to draw from, roughly evenly over time: polymer AM (FDM,
SLA, SLS), ceramics, metal AM, materials science broadly, design/software/slicing, hobbyist
and resource-type pieces, industry/business trends, standards and qualification, and
sustainability/recycling. Don't force variety at the cost of quality, but do treat "not
metal AM again" as a real tiebreaker when a topic in another domain is equally viable.

### Titles: keep them short
Amended July 2026. Prefer a short, punchy title (roughly 5-9 words) over a long descriptive
one with a subordinate clause. E.g. prefer something like "The Residual Stress Problem
Nobody's Solved" over "The Residual Stress Problem That Metal 3D Printing Still Hasn't
Solved and What Engineers Are Doing About It." The `description:` frontmatter field is
where the fuller explanatory sentence belongs — it doesn't need to be repeated in the title.

## Autopublish automation
A scheduled task (`appliedam-insights-autopublish`) runs every day and publishes a new
concise (650-800 word) journal-style Insights article every 2 days (cadence tracked in
`.autopublish/state.json`, not the cron schedule). Pick the topic per "Topic selection"
above and keep the title short per "Titles" above. Use the real git push path above for
images: generate a featured image/thumbnail (frontmatter-only, `featured_image:`) plus
Image 1 (and optionally Image 2) as the inline body figures, via matplotlib with varied
style each run, *unless* a real figure/photo has been provided by the user for that article
(then use that instead, with a citation — see procedure above). Per "Featured image/
thumbnail stays OUT of the article body" above, the featured image/thumbnail must NEVER be
inlined in the body — only Image 1/Image 2 go inline. Also back up the article's image
assets as a ZIP to Google Drive under `My Drive > AppliedAM > bot > <Month Year>` (filename
pattern: `AppliedAM_<ArticleSlugCamelCase>_Assets.zip`) for redundancy. Verify this upload
actually succeeds (check the returned file id/metadata) rather than assuming it worked —
one run's backup silently failed without being flagged clearly, so treat a missing/failed
Drive upload as worth calling out explicitly in the run's final report, not just skipping
quietly. See the scheduled task's own prompt for the full spec.
