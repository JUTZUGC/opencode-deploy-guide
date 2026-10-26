# OpenCode 一键部署脚本（第三方指南）——按官方文档封装
# 官方文档：https://opencode.ai/v2/docs
# 更新日期：2026-10-26
# 类型：script
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw '需要先安装 Git' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

if (-not (Get-Command npm.cmd -ErrorAction SilentlyContinue)) { throw '需要先安装 Node.js（含 npm）' }
npm.cmd i -g @opencode/cli@latest
$env:Path = "$env:APPDATA\npm;$env:Path" ; opencode --version

Write-Host ''

Write-Host '安装完成：进入项目目录运行 opencode，先登录或配置模型供应商，再开始对话'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://opencode.ai/v2/docs'
