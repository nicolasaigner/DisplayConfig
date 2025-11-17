# Atalho para carregar o DisplayConfig rapidamente
# Salve isso como: LoadModule.ps1
# Use: . .\LoadModule.ps1

Import-Module DisplayConfig -Force
$Module = Get-Module DisplayConfig
Write-Host "✓ DisplayConfig $($Module.Version) carregado!" -ForegroundColor Green
Write-Host "`nComandos disponíveis:" -ForegroundColor Cyan
Write-Host "  Get-DisplayInfo              - Ver info dos displays (com Rotation!)" -ForegroundColor White
Write-Host "  Set-DisplayResolution        - Mudar resolução" -ForegroundColor White
Write-Host "  Set-DisplayRefreshRate       - Mudar taxa de atualização" -ForegroundColor White
Write-Host "  Set-DisplayRotation          - Mudar rotação" -ForegroundColor White
Write-Host "  Get-Command -Module DisplayConfig - Ver todos os comandos" -ForegroundColor White
Write-Host ""

