[CmdletBinding()] param (
    [bool]$UseLib=$false,
    [bool]$UseLibExamples=$false
)
Set-StrictMode -Version 3.0
$ErrorActionPreference = 'Stop'
$PSNativeCommandUseErrorActionPreference = $true

Push-Location $PSScriptRoot

$libPath = @()
$libPathExamples = @()
if ($UseLib) {
    $libPath += "../artifacts/package/release/"
}
if ($UseLibExamples) {
    $libPathExamples += "../artifacts/package/release/"
}

if (Test-Path -Path 'workflows/') {
    .\bonsai-docfx\modules\Export-Image.ps1 -libPath $libPath -workflowPath './workflows' -bootstrapperPath '../.bonsai/Bonsai.exe'
}

if (Test-Path -Path 'examples/') {
    foreach ($environment in (Get-ChildItem -Path 'examples/' -Filter '.bonsai' -Recurse -FollowSymlink -Directory)) {
        .\bonsai\modules\Export-Image.ps1 -libPath $libPathExamples -workflowPath ($environment.Parent.FullName) -bootstrapperPath (Join-Path $environment.FullName 'Bonsai.exe')
    }
}

Pop-Location
