# Script para instalar a versão compilada localmente
param(
    [Parameter()]
    [ValidateSet('Debug', 'Release')]
    [string]$Configuration = 'Release',
    
    [Parameter()]
    [string]$InstallPath = "$HOME\Documents\PowerShell\Modules\DisplayConfig"
)

Write-Host "Instalando DisplayConfig localmente..." -ForegroundColor Cyan

# Garantir que o diretório de módulos do usuário existe
$UserModulesPath = Split-Path $InstallPath -Parent
if (-not (Test-Path $UserModulesPath)) {
    $null = New-Item -Path $UserModulesPath -ItemType Directory -Force
    Write-Host "Criado diretório: $UserModulesPath" -ForegroundColor Gray
}

# Verificar e configurar PSModulePath permanentemente se necessário
$CurrentUserPath = [Environment]::GetEnvironmentVariable('PSModulePath', 'User')
if ([string]::IsNullOrEmpty($CurrentUserPath) -or $CurrentUserPath -notlike "*$UserModulesPath*") {
    [Environment]::SetEnvironmentVariable('PSModulePath', $UserModulesPath, 'User')
    Write-Host "✓ PSModulePath do usuário configurado" -ForegroundColor Green
    Write-Host "  (Efetivo em novos terminais)" -ForegroundColor Gray
}

# Adicionar ao PSModulePath da sessão atual
if ($env:PSModulePath -notlike "*$UserModulesPath*") {
    $env:PSModulePath = "$UserModulesPath;$env:PSModulePath"
}

# Obter a versão do Release notes
$ReleaseNotes = Get-Content -LiteralPath "$PSScriptRoot\Release notes.txt" -Raw
$VersionString = $ReleaseNotes.Split(':')[0].Trim()

# Extrair apenas a versão numérica (sem prerelease) para o nome da pasta
# O PowerShell só reconhece módulos em pastas com versão numérica
$Version = $VersionString
if ($VersionString -match '^(\d+\.\d+\.\d+)') {
    $Version = $Matches[1]
}

Write-Host "Versão: $Version" -ForegroundColor Yellow

# Determinar o caminho de origem baseado na configuração
if ($Configuration -eq 'Release') {
    $SourcePath = "$PSScriptRoot\Releases\DisplayConfig\$Version"
} else {
    $SourcePath = "$PSScriptRoot\src\DisplayConfig\bin\$Configuration\netstandard2.0"
}

# Verificar se o caminho de origem existe
if (-not (Test-Path $SourcePath)) {
    Write-Error "Caminho de origem não encontrado: $SourcePath"
    Write-Host "Execute o build primeiro: dotnet build DisplayConfig.sln --configuration $Configuration" -ForegroundColor Yellow
    exit 1
}

# Criar o diretório de destino se não existir
$DestinationPath = Join-Path $InstallPath $Version
if (-not (Test-Path $DestinationPath)) {
    $null = New-Item -Path $DestinationPath -ItemType Directory -Force
    Write-Host "Criado diretório: $DestinationPath" -ForegroundColor Green
}

# Remover o módulo da memória
Remove-Module DisplayConfig -Force -ErrorAction SilentlyContinue
Write-Host "Módulo removido da memória" -ForegroundColor Gray

# Aguardar um pouco para liberar os arquivos
Start-Sleep -Seconds 1

# Copiar arquivos
try {
    Copy-Item -Path "$SourcePath\*" -Destination $DestinationPath -Recurse -Force
    Write-Host "Arquivos copiados com sucesso!" -ForegroundColor Green
    
    # Importar e testar
    $ManifestPath = Join-Path $DestinationPath "DisplayConfig.psd1"
    if (Test-Path $ManifestPath) {
        Import-Module -Name $ManifestPath -Force -ErrorAction Stop
    } else {
        $DllPath = Join-Path $DestinationPath "DisplayConfig.dll"
        Import-Module -Name $DllPath -Force -ErrorAction Stop
    }
    
    $Module = Get-Module DisplayConfig
    
    if ($Module) {
        Write-Host "`nMódulo instalado:" -ForegroundColor Cyan
        Write-Host "  Nome: $($Module.Name)" -ForegroundColor White
        Write-Host "  Versão: $($Module.Version)" -ForegroundColor White
        Write-Host "  Caminho: $($Module.Path)" -ForegroundColor White
        
        Write-Host "`nTestando comando Get-DisplayInfo:" -ForegroundColor Cyan
        Get-DisplayInfo | Select-Object DisplayId, DisplayName, Active, Rotation | Format-Table -AutoSize
    } else {
        Write-Warning "Módulo copiado mas não foi possível importar"
    }
    
} catch {
    Write-Error "Erro durante a instalação: $_"
    Write-Host "Tente fechar todos os terminais PowerShell e executar novamente" -ForegroundColor Yellow
    exit 1
}

Write-Host "`n✓ Instalação concluída com sucesso!" -ForegroundColor Green

