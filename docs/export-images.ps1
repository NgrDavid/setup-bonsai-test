Push-Location $PSScriptRoot
foreach ($environment in (Get-ChildItem -Path 'examples/' -Filter '.bonsai' -Recurse -Directory))
{
    .\bonsai\modules\Export-Image.ps1 -workflowPath ($environment.Parent.FullName) -bootstrapperPath (Join-Path $environment.FullName 'Bonsai.exe')
}
Pop-Location
