# OpenCode 一键部署指南

> 第三方部署指南 · 非 OpenCode 官方仓库。官方项目：[anomalyco/opencode](https://github.com/anomalyco/opencode)
> 内容来自官方文档（2026-10-26）。项目迭代快，请以[官方文档](https://opencode.ai/v2/docs)为准。

[![⚡ 一键部署](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E9%83%A8%E7%BD%B2-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键部署推荐用百度搭子)

## 一键部署（推荐：用百度搭子）

> [!TIP]
> 不用折腾插件和配置，让百度搭子把 OpenCode 装好，接上模型就能在终端里改代码。

⚠️ 以终端 TUI 为主，桌面端仍标注 Beta。CLI 支持 macOS / Linux（官方脚本）与 Windows（npm 全局安装，需要 Node.js）。首次使用要配置模型供应商并登录。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/opencode-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会按系统安装：macOS / Linux 跑官方脚本到 ~/.opencode/bin，Windows 用 npm 全局安装，按它的提示确认即可，结束时它会告诉你结果。
   （需本机已装 Git；构建依赖以官方文档为准。）



## OpenCode 是什么？

OpenCode 是开源的AI 编程 Agent，终端 TUI 为主、桌面端为辅（协议：MIT，<img src="https://img.shields.io/github/stars/anomalyco/opencode?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

在终端里直接读写项目文件、跑命令、改代码：内置 build（全权限）与 plan（只读分析）两种 Agent，按 Tab 切换；支持多家模型供应商、MCP、自定义 Agent 与主题。

- 双 Agent：build 改代码，plan 只读分析与规划
- 终端 TUI：文件、命令、Diff 都在一个界面里
- 模型：多家供应商与订阅，可自定义 provider
- 扩展：MCP、自定义 Agent、插件与主题
- 形态：CLI / TUI / 桌面端（Beta）
- 中文：自带简体中文 README 与多语言文档

（来源：[官方仓库](https://github.com/anomalyco/opencode)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 221.9k stars | 2025-04 建，18 个月持续增长，本周仍 +5,921 |
| 终端体验完整 | 文件、命令、Diff、会话都在 TUI 里 |
| 双模式 | build 全权限，plan 只读更安全 |
| 模型自由 | 供应商、订阅、自定义 provider 都能接 |
| 多语言 | 自带简体中文 README 与文档 |

| 需要注意 | 说明 |
|---|---|
| 以终端为主 | 不习惯 TUI 的用户上手慢 |
| 桌面端 Beta | 功能和稳定性还在补 |
| 要自备模型 | API Key 或订阅账号必须有 |
| 改文件很直接 | 权限大，误操作会直接影响项目 |
| 版本迭代快 | npm 2.x 与桌面端 Release 版本号并不同步 |

> 以上基于官方文档与社区反馈整理（2026-10-26），以官方最新文档为准。

## 快速部署（官方方式）

```bash
curl -fsSL https://opencode.ai/v2/install | bash
export PATH="$HOME/.opencode/bin:$PATH"
command -v opencode >/dev/null 2>&1 || { echo "安装后没找到 opencode，请把 ~/.opencode/bin 加入 PATH"; exit 1; }
opencode --version
```

部署步骤来源：[https://github.com/anomalyco/opencode#installation](https://github.com/anomalyco/opencode#installation)

## 验证状态

| 场景 | 状态 |
|---|---|
| npm 包 @opencode/cli 版本 2.1.4 已核对 | 已验证 2026-10-26 |
| Windows 上 npx @opencode/cli@latest --version 实测输出 opencode v2.1.4 | 已验证 2026-10-26 |
| 官方安装脚本（macOS / Linux）与桌面端产物已通读，未在对应系统实装 | 已核对 2026-10-26 |
| MCP 服务握手与工具列表（initialize / tools/list） | 已验证 2026-10-26 |
| 非目标宿主调用被拦截（HOST_NOT_ALLOWED） | 已验证 2026-10-26 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

OpenCode 支持 MCP，可把外部工具接进 Agent 会话。本仓库的 MCP 只提供安装、模型配置与常见坑。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-10-26）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\opencode-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 安装完成后

1. `cd` 到项目目录，运行 `opencode`
2. 首次进入先配置模型供应商或登录
3. 按 `Tab` 在 build / plan 之间切换；用 `@general` 调子 Agent
4. 常用命令：`opencode --help`、`opencode auth login`

### Windows

用 npm 全局安装。如果 `opencode` 不在 PATH 里，重开终端，或检查 `%APPDATA%\npm` 是否已加入用户变量。

### 桌面端（Beta）

从 [opencode.ai/download](https://opencode.ai/download) 或 GitHub Release 下载；Windows 安装包约 120 MB，macOS 有 dmg，Linux 有 deb / rpm / AppImage。

> ⚠️ Agent 会真实修改文件并执行命令。第一次先在测试仓库里跑；重要项目先提交，必要时用 plan 模式只读分析。

## 常见坑

- 命令找不到：把 `~/.opencode/bin` 加入 PATH，或重开终端
- Windows 装不上：先确认 Node.js 与 npm 可用，再用 `npm i -g @opencode/cli@latest`
- 模型连不上：进 `opencode auth login` 重新登录，或检查 provider 配置
- 旧版本冲突：先卸载 0.1.x 之前的版本再装
- 担心误改代码：先用 plan 模式，确认方案后再切 build
- 桌面端和 CLI 版本不一致：两者分开发版，按各自渠道更新
- 远程服务器：TUI 要能交互，建议本地跑，不要挂在不稳定 SSH 上

## 免责声明

本仓库为第三方指南，与 OpenCode 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-10-26），项目迭代快，请以[官方文档](https://opencode.ai/v2/docs)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
