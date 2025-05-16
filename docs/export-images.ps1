[CmdletBinding()] param (
    [bool]$UseLib=$false,
    [bool]$UseLibExamples=$false,
    [string]$OutputFolder=$null
)
Set-StrictMode -Version 3.0
$ErrorActionPreference = 'Stop'
$PSNativeCommandUseErrorActionPreference = $true

if ($OutputFolder) {
    $OutputFolder = Join-Path (Get-Location) $OutputFolder
}

Push-Location $PSScriptRoot
try {
    $libPath = @()
    $libPathExamples = @()
    if ($UseLib) {
        $libPath += "../artifacts/package/release/"
    }
    if ($UseLibExamples) {
        $libPathExamples += "../artifacts/package/release/"
    }

    if (Test-Path -Path 'workflows/') {
        .\bonsai-docfx\modules\Export-Image.ps1 -libPath $libPath -workflowPath './workflows' -bootstrapperPath '../.bonsai/Bonsai.exe' -outputFolder $OutputFolder -documentationRoot $PSScriptRoot
    }

    if (Test-Path -Path 'examples/') {
        foreach ($environment in (Get-ChildItem -Path 'examples/' -Filter '.bonsai' -Recurse -FollowSymlink -Directory)) {
            $bootstrapperPath = Join-Path $environment.FullName 'Bonsai.exe'
            .\bonsai-docfx\modules\Export-Image.ps1 -libPath $libPathExamples -workflowPath ($environment.Parent.FullName) -bootstrapperPath $bootstrapperPath -outputFolder $OutputFolder -documentationRoot $PSScriptRoot
        }
    }
} finally {
    Pop-Location
}
