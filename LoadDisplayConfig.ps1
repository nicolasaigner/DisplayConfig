# Script para importar o módulo DisplayConfig localmente
# Use: . .\LoadDisplayConfig.ps1

$ModulePath = "$PSScriptRoot\Releases\DisplayConfig"

# Encontrar a versão mais recente
$LatestVersion = Get-ChildItem $ModulePath -Directory | 
    Sort-Object Name -Descending | 
    Select-Object -First 1

if ($LatestVersion) {
    $ManifestPath = Join-Path $LatestVersion.FullName "DisplayConfig.psd1"
    if (Test-Path $ManifestPath) {
        Import-Module $ManifestPath -Force
        Write-Host "✓ DisplayConfig $($LatestVersion.Name) carregado!" -ForegroundColor Green
        Write-Host "Use: Get-DisplayInfo" -ForegroundColor Cyan
    } else {
        Write-Error "Manifesto não encontrado: $ManifestPath"
    }
} else {
    Write-Error "Nenhuma versão encontrada em $ModulePath"
}

