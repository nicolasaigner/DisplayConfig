# Como Usar o DisplayConfig v5.2.1-rc.1

## ✅ Solução Rápida - Importar Diretamente

Você **NÃO precisa** de repositório local. Basta importar o módulo pelo caminho completo:

### No Terminal PowerShell:
```powershell
# Importar o módulo
Import-Module 'C:\Users\Nicolas\Documents\PowerShell\Modules\DisplayConfig\5.2.1-rc.1\DisplayConfig.psd1'

# Testar
Get-DisplayInfo
```

### Ou use o script de atalho:
```powershell
cd C:\Users\Nicolas\SSD_1TB\PROJETOS\DisplayConfig
. .\LoadDisplayConfig.ps1
Get-DisplayInfo
```

## 🔧 Solução Permanente - Adicionar ao Perfil

Para carregar automaticamente em toda sessão PowerShell:

1. Abra seu perfil do PowerShell:
```powershell
notepad $PROFILE
```

2. Adicione esta linha no final do arquivo:
```powershell
Import-Module 'C:\Users\Nicolas\Documents\PowerShell\Modules\DisplayConfig\5.2.1-rc.1\DisplayConfig.psd1' -ErrorAction SilentlyContinue
```

3. Salve e feche. Na próxima vez que abrir o PowerShell, o módulo estará disponível automaticamente.

## 🚀 Comandos Disponíveis

```powershell
# Ver informações dos displays (incluindo Rotation!)
Get-DisplayInfo

# Ver apenas DisplayId, Nome e Rotação
Get-DisplayInfo | Select-Object DisplayId, DisplayName, Rotation

# Mudar resolução
Set-DisplayResolution -DisplayId 1 -Width 2560 -Height 1440

# Mudar taxa de atualização
Set-DisplayRefreshRate -DisplayId 1 -RefreshRate 165

# Mudar rotação
Set-DisplayRotation -DisplayId 1 -Rotation Rotate90

# Ver todas as opções
Get-Command -Module DisplayConfig
```

## ❓ Por que não funciona com `Import-Module DisplayConfig`?

O PowerShell procura módulos apenas nos diretórios listados em `$env:PSModulePath`. 
O caminho `C:\Users\Nicolas\Documents\PowerShell\Modules` foi adicionado ao ambiente do usuário,
mas precisa de uma nova sessão para pegar a mudança.

**Teste em um NOVO terminal PowerShell:**
```powershell
# Feche o terminal atual e abra um novo
# Depois tente:
Import-Module DisplayConfig
Get-DisplayInfo
```

Se ainda não funcionar, use o caminho completo como mostrado acima.

## 📦 Publicar no PowerShell Gallery (Futuro)

Quando quiser publicar oficialmente:
```powershell
Publish-Module -Path "C:\Users\Nicolas\SSD_1TB\PROJETOS\DisplayConfig\Releases\DisplayConfig\5.2.1-rc.1" -NuGetApiKey $ApiKey
```

Depois da publicação, qualquer um poderá instalar com:
```powershell
Install-Module DisplayConfig -AllowPrerelease
```

