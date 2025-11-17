# Processo de Release - DisplayConfig

## Como criar uma nova versão

### 1. Atualizar o Release Notes
Edite o arquivo `Release notes.txt` e adicione a nova versão no topo:

```
5.2.1-rc.1:
    Descrição das mudanças realizadas.
```

### 2. Build Release
Execute o comando:
```powershell
dotnet build DisplayConfig.sln --configuration Release
```

Ou use o script:
```powershell
.\BuildModule.ps1
```

### 3. Verificar os arquivos gerados
Os arquivos serão gerados em:
- `Releases\DisplayConfig\{versão}\` - Contém todos os arquivos do módulo prontos para distribuição

### 4. Instalar localmente para testes
Use o script de instalação local:
```powershell
.\InstallLocal.ps1
```

Isso irá:
- Copiar os arquivos da versão Release para `$HOME\Documents\PowerShell\Modules\DisplayConfig\{versão}`
- Importar o módulo
- Executar um teste básico

### 5. Testar o módulo
```powershell
# Verificar versão instalada
Get-Module DisplayConfig -ListAvailable

# Importar e testar
Import-Module DisplayConfig -Force
Get-DisplayInfo

# Testar comandos específicos
Get-DisplayInfo | Select-Object DisplayId, DisplayName, Rotation
```

### 6. Publicar no PowerShell Gallery (quando pronto)
```powershell
# Login no PowerShell Gallery
$ApiKey = Read-Host "Digite sua API Key" -AsSecureString

# Publicar o módulo
Publish-Module -Path ".\Releases\DisplayConfig\5.2.1-rc.1" -NuGetApiKey $ApiKey -Verbose
```

## Estrutura de versionamento

- **Major.Minor.Patch** - Para versões estáveis (ex: 5.2.1)
- **Major.Minor.Patch-rc.N** - Para Release Candidates (ex: 5.2.1-rc.1)
- **Major.Minor.Patch-beta.N** - Para versões beta (ex: 5.3.0-beta.1)

## Arquivos importantes

- `Release notes.txt` - Histórico de versões e mudanças
- `ModuleManifest.psd1` - Template do manifesto (com placeholders)
- `PostBuild.ps1` - Script que processa o template e cria o manifesto final
- `BuildModule.ps1` - Script principal de build
- `InstallLocal.ps1` - Script para instalar localmente para testes

## Requisitos

- .NET SDK 8.0 ou superior
- PowerShell 7+ (pwsh)
- Módulo Microsoft.PowerShell.PlatyPS (instalado automaticamente no primeiro build)

## Troubleshooting

### Erro: "The process cannot access the file"
- Feche todos os terminais PowerShell
- Aguarde alguns segundos
- Tente novamente

### Erro: "Module 'Microsoft.PowerShell.PlatyPS' cannot be found"
```powershell
Install-Module -Name Microsoft.PowerShell.PlatyPS -Scope CurrentUser -Force -AllowPrerelease
```

### Build usando MSBuild antigo
- O script `BuildModule.ps1` foi atualizado para usar `dotnet build`
- Se encontrar problemas, use diretamente: `dotnet build DisplayConfig.sln --configuration Release`

