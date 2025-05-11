[CmdletBinding()] param ()
Set-StrictMode -Version 3.0
$ErrorActionPreference = 'Stop'
$PSNativeCommandUseErrorActionPreference = $true

Push-Location $PSScriptRoot

$monoPrefix = ''
if (!$IsWindows) {
    $monoPrefix = 'mono '
}

.\bonsai\modules\Export-Image.ps1 -workflowPath './workflows' -bootstrapperPath ($monoPrefix + '../.bonsai/Bonsai.exe')
foreach ($environment in (Get-ChildItem -Path 'examples/' -Filter '.bonsai' -Recurse -Directory))
{
    .\bonsai\modules\Export-Image.ps1 -workflowPath ($environment.Parent.FullName) -bootstrapperPath ($monoPrefix + (Join-Path $environment.FullName 'Bonsai.exe'))
}

Pop-Location
