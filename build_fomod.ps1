# Builds the FOMOD release archive for Toxic Air v2 REDUX.
# Layout inside the zip:
#   fomod\               installer metadata (info.xml, ModuleConfig.xml)
#   00_core\gamedata\    the base mod (always installed)
#   10_gamma_economy\    optional DLTX price patch for GAMMA
#   20_fdda_patch\       optional FDDA Redone animations patch
$ErrorActionPreference = "Stop"

$root    = $PSScriptRoot
$staging = Join-Path $root "_fomod_staging"
$outZip  = Join-Path $root "Toxic Air v2 REDUX FOMOD - by Priler.zip"

if (Test-Path $staging) { Remove-Item -Recurse -Force $staging }
New-Item -ItemType Directory -Force $staging | Out-Null

Copy-Item -Recurse (Join-Path $root "fomod") (Join-Path $staging "fomod")

New-Item -ItemType Directory -Force (Join-Path $staging "00_core") | Out-Null
Copy-Item -Recurse (Join-Path $root "gamedata") (Join-Path $staging "00_core\gamedata")

Copy-Item -Recurse (Join-Path $root "fomod_options\10_gamma_economy") (Join-Path $staging "10_gamma_economy")

Copy-Item -Recurse (Join-Path $root "fomod_options\20_fdda_patch") (Join-Path $staging "20_fdda_patch")

if (Test-Path $outZip) { Remove-Item -Force $outZip }
Compress-Archive -Path (Join-Path $staging "*") -DestinationPath $outZip

Remove-Item -Recurse -Force $staging
Write-Host "Built: $outZip"
