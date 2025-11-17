# 🚀 Guia de Instalação e Uso - DisplayConfig v5.2.1

## ✅ INSTALAÇÃO CONCLUÍDA!

Seu módulo DisplayConfig (versão 5.2.1 com suporte a Rotation) está instalado e configurado!

## 📦 Como Usar

### Em QUALQUER terminal PowerShell novo:

```powershell
# Simplesmente importe o módulo
Import-Module DisplayConfig

# Use os comandos
Get-DisplayInfo
Get-DisplayInfo | Select-Object DisplayId, DisplayName, Rotation
```

**Pronto! Não precisa mais do caminho completo!** 🎉

## 🔧 O que foi configurado

1. ✅ Módulo instalado em: `C:\Users\Nicolas\Documents\PowerShell\Modules\DisplayConfig\5.2.1\`
2. ✅ PSModulePath do usuário configurado permanentemente
3. ✅ Versão local (5.2.1) tem prioridade sobre a do PSGallery

## 💡 Comandos Principais

```powershell
# Ver informações dos displays (COM ROTATION!)
Get-DisplayInfo

# Ver apenas alguns campos
Get-DisplayInfo | Select-Object DisplayId, DisplayName, Active, Rotation

# Mudar resolução
Set-DisplayResolution -DisplayId 1 -Width 2560 -Height 1440

# Mudar taxa de atualização
Set-DisplayRefreshRate -DisplayId 1 -RefreshRate 165

# Mudar rotação do display
Set-DisplayRotation -DisplayId 1 -Rotation Rotate90

# Ver todos os comandos disponíveis
Get-Command -Module DisplayConfig

# Ver ajuda de um comando
Get-Help Get-DisplayInfo -Full
```

## 🔄 Atualizando o Módulo

Quando fizer alterações no código e quiser atualizar:

```powershell
cd C:\Users\Nicolas\SSD_1TB\PROJETOS\DisplayConfig

# Build e instala automaticamente
.\BuildModule.ps1 -Configuration Release -Install

# OU separadamente:
dotnet build DisplayConfig.sln --configuration Release
.\InstallLocal.ps1
```

Depois basta recarregar o módulo em qualquer terminal:
```powershell
Import-Module DisplayConfig -Force
```

## ⚠️ Importante sobre Versões

- **Sua versão local:** 5.2.1 (com Rotation)
- **Versão do PSGallery:** 5.2.1 (oficial, SEM Rotation)

Sua versão local tem **prioridade** porque está no PSModulePath do usuário.

Se quiser garantir que está usando a versão correta:
```powershell
Get-Module DisplayConfig | Select-Object Name, Version, Path
# Deve mostrar: C:\Users\Nicolas\Documents\PowerShell\Modules\DisplayConfig\5.2.1\...
```

## 🎯 Diferença da Versão Oficial

Sua versão 5.2.1 local inclui:
- ✅ Propriedade `Rotation` no `Get-DisplayInfo`
- ✅ Mostra: None, Rotate90, Rotate180, Rotate270

A versão oficial 5.2.1 do PSGallery NÃO tem essa feature.

## 🚫 NUNCA faça Install-Module DisplayConfig

Se você executar `Install-Module DisplayConfig`, ele vai baixar a versão 5.2.1 oficial do PSGallery e sobrescrever sua versão customizada!

Para prevenir isso, você pode:
```powershell
# Sempre use -Force para manter sua versão
Import-Module DisplayConfig -Force
```

## 📝 Carregar Automaticamente

Se quiser que o módulo seja carregado automaticamente em todo terminal:

1. Edite seu perfil:
```powershell
notepad $PROFILE
```

2. Adicione no final:
```powershell
Import-Module DisplayConfig -ErrorAction SilentlyContinue
```

3. Salve e feche. Pronto!

---

## ✨ Tudo Funcionando!

Agora você pode:
- ✅ Usar `Import-Module DisplayConfig` em qualquer terminal
- ✅ Não precisa mais do caminho completo
- ✅ Sua versão com Rotation funciona perfeitamente
- ✅ Não vai baixar a versão do PSGallery por acidente

