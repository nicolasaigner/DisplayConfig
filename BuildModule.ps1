param(
    [Parameter()]
    [ValidateSet('Debug', 'Release')]
    [string]$Configuration = 'Release',
    
    [Parameter()]
    [switch]$Install
)

Write-Host "Building DisplayConfig ($Configuration)..." -ForegroundColor Cyan

[ValidateNotNull()]
$SolutionFile = Get-ChildItem -Path $PSScriptRoot -Filter *.sln -File | Select-Object -First 1

& dotnet build $SolutionFile.FullName --configuration $Configuration

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n✓ Build concluído com sucesso!" -ForegroundColor Green
    
    if ($Install) {
        Write-Host "`nInstalando localmente..." -ForegroundColor Cyan
        & "$PSScriptRoot\InstallLocal.ps1" -Configuration $Configuration
    }
} else {
    Write-Error "Build falhou com código de saída: $LASTEXITCODE"
}
