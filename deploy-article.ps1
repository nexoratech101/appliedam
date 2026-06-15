# ============================================================
# AppliedAM Article Deploy Script
# Usage: .\deploy-article.ps1 "C:\path\to\submission.zip"
# ============================================================

param(
    [Parameter(Mandatory=$true)]
    [string]$ZipPath
)

$REPO = "C:\Users\Administrator\Desktop\appliedam"
$UTF8NoBOM = New-Object System.Text.UTF8Encoding($false)

function Write-Step($msg) { Write-Host "`n>>> $msg" -ForegroundColor Cyan }
function Write-OK($msg)   { Write-Host "    OK: $msg" -ForegroundColor Green }
function Write-Fail($msg) { Write-Host "    ERROR: $msg" -ForegroundColor Red; exit 1 }

Write-Step "Checking zip file..."
if (-not (Test-Path $ZipPath)) { Write-Fail "Zip file not found: $ZipPath" }
Write-OK "Found: $ZipPath"

Write-Step "Extracting zip..."
$extractDir = Join-Path $env:TEMP ("appliedam_" + [System.IO.Path]::GetFileNameWithoutExtension($ZipPath))
if (Test-Path $extractDir) { Remove-Item $extractDir -Recurse -Force }
Expand-Archive -Path $ZipPath -DestinationPath $extractDir -Force
Write-OK "Extracted to: $extractDir"

Write-Step "Finding markdown file..."
$mdFile = Get-ChildItem $extractDir -Filter "*.md" | Select-Object -First 1
if (-not $mdFile) { Write-Fail "No .md file found in zip" }
Write-OK "Found: $($mdFile.Name)"

Write-Step "Reading and fixing content..."
$raw = [System.IO.File]::ReadAllText($mdFile.FullName, [System.Text.Encoding]::UTF8)

# Fix encoding using char codes - no literal special chars
$raw = $raw -replace [char]0x2014, '-'
$raw = $raw -replace [char]0x2013, '-'
$raw = $raw -replace [char]0x2019, "'"
$raw = $raw -replace [char]0x2018, "'"
$raw = $raw -replace [char]0x201C, '"'
$raw = $raw -replace [char]0x201D, '"'
Write-OK "Encoding fixed"

Write-Step "Parsing frontmatter..."
$section = "case-studies"
if ($raw -match '(?m)^category:\s*"?([^"\r\n]+)"?') {
    $cat = $matches[1].Trim().ToLower()
    if ($cat -eq "research") { $section = "research" }
    elseif ($cat -eq "industry") { $section = "industry" }
    else { $section = "case-studies" }
}
Write-OK "Section: $section"

$slug = [System.IO.Path]::GetFileNameWithoutExtension($ZipPath)
$slug = $slug -replace '-submission$', '' -replace '_', '-'
$slug = $slug.ToLower() -replace '[^a-z0-9-]', ''
Write-OK "Slug: $slug"

$heroFile = Get-ChildItem $extractDir -Filter "hero.*" | Select-Object -First 1
$heroExt = if ($heroFile) { $heroFile.Extension.TrimStart('.') } else { "jpg" }
$featuredImage = "/images/$section/$slug/hero.$heroExt"

$raw = $raw -replace '(?m)^image: ', 'featured_image: '
$raw = $raw -replace '(?m)^summary: ', 'description: '
$raw = $raw -replace "(?i)/images/[^/\s`"]+/[^/\s`"]+/(hero\.[a-z]+)", "/images/$section/$slug/`$1"
$raw = $raw -replace "(?i)/images/[^/\s`"]+/[^/\s`"]+/(image-\d+\.[a-z]+)", "/images/$section/$slug/`$1"

$title       = if ($raw -match '(?m)^title:\s*"([^"]+)"')       { $matches[1] } else { $slug }
$date        = if ($raw -match '(?m)^date:\s*([^\r\n]+)')        { $matches[1].Trim() } else { Get-Date -Format "yyyy-MM-dd" }
$description = if ($raw -match '(?m)^description:\s*"([^"]+)"') { $matches[1] } else { "" }
$tagsLine    = if ($raw -match '(?m)^tags:\s*(\[[^\]]+\])')      { $matches[1] } else { '[]' }
$authorName  = if ($raw -match '(?m)^\s+name:\s*"([^"]+)"')     { $matches[1] } else { "" }
$authorType  = if ($raw -match '(?m)^\s+type:\s*"([^"]+)"')     { $matches[1] } else { "General contributor" }
$authorBio   = if ($raw -match '(?m)^\s+bio:\s*"([^"]+)"')      { $matches[1] } else { "" }
$authorEmail = if ($raw -match '(?m)^\s+email:\s*"([^"]+)"')    { $matches[1] } else { "" }
$emailPublic = if ($raw -match '(?m)^\s+email_public:\s*(true|false)') { $matches[1] } else { "false" }

if ($description -match '^[a-z0-9-]+$') {
    Write-Host "    WARN: Description looks like a placeholder - please update manually" -ForegroundColor Yellow
    $description = ""
}

Write-OK "Title: $title"
Write-OK "Author: $authorName"

$body = $raw -replace '(?s)^---.*?---\s*', ''

Write-Step "Building clean frontmatter..."
$nl = "`n"
$fm  = "---$nl"
$fm += "title: `"$title`"$nl"
$fm += "date: $date$nl"
$fm += "description: `"$description`"$nl"
$fm += "featured_image: `"$featuredImage`"$nl"
$fm += "tags: $tagsLine$nl"
$fm += "author:$nl"
$fm += "  name: `"$authorName`"$nl"
$fm += "  type: `"$authorType`"$nl"
if ($authorBio)   { $fm += "  bio: `"$authorBio`"$nl" }
if ($authorEmail) {
    $fm += "  email: `"$authorEmail`"$nl"
    $fm += "  email_public: $emailPublic$nl"
}
$fm += "---$nl$nl"
Write-OK "Frontmatter built"

Write-Step "Writing markdown file..."
$contentDir = Join-Path $REPO "content\$section"
New-Item -ItemType Directory -Force -Path $contentDir | Out-Null
$mdDest = Join-Path $contentDir "$slug.md"
[System.IO.File]::WriteAllText($mdDest, ($fm + $body.Trim() + $nl), $UTF8NoBOM)
Write-OK "Written: $mdDest"

Write-Step "Copying images..."
$imgDir = Join-Path $REPO "static\images\$section\$slug"
New-Item -ItemType Directory -Force -Path $imgDir | Out-Null
$images = Get-ChildItem $extractDir -Include "*.jpg","*.jpeg","*.png","*.webp" -File
foreach ($img in $images) {
    Copy-Item $img.FullName (Join-Path $imgDir $img.Name) -Force
    Write-OK "Copied: $($img.Name)"
}

Write-Step "Testing Hugo build..."
$hugoOut = & hugo --source $REPO 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host ($hugoOut | Out-String) -ForegroundColor Red
    Write-Fail "Hugo build failed"
}
Write-OK "Hugo build successful"

Write-Step "Committing and pushing..."
Set-Location $REPO
git add .
git commit -m "Add article: $title"
git push origin master

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n============================================" -ForegroundColor Green
    Write-Host " DONE! Article deployed." -ForegroundColor Green
    Write-Host " URL: https://appliedam.net/$section/$slug/" -ForegroundColor Green
    Write-Host "============================================`n" -ForegroundColor Green
} else {
    Write-Fail "Git push failed"
}

Remove-Item $extractDir -Recurse -Force
Write-OK "Temp files cleaned up"
