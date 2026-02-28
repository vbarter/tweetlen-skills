<div align="center">

# Tweetlen Skills

**面向 Claude Code 的 Twitter/X 数据分析技能集**

[![Version](https://img.shields.io/badge/version-0.1.0-blue.svg)](https://github.com/vbarter/tweetlen-skills)
[![Skills](https://img.shields.io/badge/skills-18-green.svg)](#技能一览)
[![License](https://img.shields.io/badge/license-MIT-brightgreen.svg)](LICENSE)

让 Claude Code 变身 Twitter/X 数据分析助手。
查询用户、分析推文、研究话题、监控趋势——全程自然语言交互。

[**English**](README.md) | [**中文**](README.zh.md) | [**日本語**](README.ja.md)

</div>

---

## 安装

```bash
# 1. 添加 marketplace
/plugin marketplace add vbarter/tweetlen-skills

# 2. 安装需要的插件
/plugin install api-skills@tweetlen-skills
/plugin install analysis-skills@tweetlen-skills
/plugin install research-skills@tweetlen-skills
/plugin install utility-skills@tweetlen-skills

# 3. 配置 API Key（交互式）
bash ~/.claude/plugins/tweetlen-skills/setup.sh
```

## API Key 配置

> [!IMPORTANT]
> **使用本 Skills 需要 Tweetlen API Key**
>
> 1. 访问 **[api.tweetlen.com](https://api.tweetlen.com)** 注册账号
> 2. 在控制台创建 API Key（格式：`twtl_xxx`）
> 3. 按以下任一方式配置 Key：

### 一键配置（推荐）

运行安装脚本，自动将 Key 写入 `~/.claude/settings.json`：

```bash
bash ~/.claude/plugins/tweetlen-skills/setup.sh
```

> 配置完成后需重启 Claude Code 生效。

### 手动配置

<details open>
<summary><b>方式一：写入 Claude Code 配置（推荐）</b></summary>

编辑 `~/.claude/settings.json`，在 `env` 字段中添加 `TWEETLEN_API_KEY`：

```json
{
  "env": {
    "TWEETLEN_API_KEY": "twtl_your_key_here"
  }
}
```

一次配置，所有项目通用，Bash/curl 调用时自动注入环境变量。

</details>

<details>
<summary><b>方式二：项目级配置</b></summary>

在项目根目录创建 `.claude/settings.local.json`（不会被 git 提交）：

```json
{
  "env": {
    "TWEETLEN_API_KEY": "twtl_your_key_here"
  }
}
```

</details>

<details>
<summary><b>方式三：Shell 环境变量</b></summary>

```bash
export TWEETLEN_API_KEY=twtl_your_key_here
```

> 注意：需在 Shell 配置文件（`.zshrc` / `.bashrc`）中 export 才能持久生效。

</details>

## 快速上手

```
你: 分析一下 @elonmusk 这个账号
你: 大家在推特上怎么讨论 "Claude AI"？
你: 对比 @openai 和 @anthropic
你: 现在全球什么话题最热？
你: 帮我查一下 @naval
```

Claude Code 会自动选择并执行合适的 skill。

## 技能一览

### API Skills — 端点封装

底层构建块。每个 skill 封装一类 Twitter/X API 端点，提供参数说明和调用示例。

| 技能 | 端点数 | 功能 |
|------|:------:|------|
| `tweetlen-api-user` | 16 | 用户资料、粉丝、关注、推文、回复、媒体、高光 |
| `tweetlen-api-tweet` | 7 | 推文详情、评论、转推、引用 |
| `tweetlen-api-search` | 4 | 全文搜索（v1/v2/v3）、自动补全 |
| `tweetlen-api-community` | 10 | 社区搜索、话题、成员、版主、推文 |
| `tweetlen-api-list` | 5 | 列表搜索、详情、成员、粉丝、时间线 |
| `tweetlen-api-trends` | 2 | 可用地区、按地区查趋势 |
| `tweetlen-api-space` | 1 | Space 音频房间详情 |
| `tweetlen-api-jobs` | 3 | 职位搜索、详情、地区建议 |

### Analysis Skills — 分析工作流

组合多个 API 调用 + 分析逻辑，生成结构化报告。

| 技能 | 功能 |
|------|------|
| `tweetlen-user-profile` | 综合用户画像：资料 + 推文 + 粉丝 + 互动指标 |
| `tweetlen-tweet-analysis` | 推文深度分析：评论 + 转推 + 引用 + 情感倾向 |
| `tweetlen-user-comparison` | 双账号横向对比分析 |
| `tweetlen-influence-report` | KOL 影响力评估 + 等级分类 |

### Research Skills — 研究工作流

多步骤研究工作流，用于趋势和话题分析。

| 技能 | 功能 |
|------|------|
| `tweetlen-topic-research` | 话题舆情研究：搜索 + 关键声音 + 评论分析 |
| `tweetlen-trend-monitor` | 按地区监控热点趋势 + 热门推文上下文 |
| `tweetlen-community-explorer` | 社区深度探索：结构、成员、版主、内容 |
| `tweetlen-list-explorer` | 列表探索：成员、时间线、粉丝分析 |

### Utility Skills — 快捷工具

| 技能 | 功能 |
|------|------|
| `tweetlen-user-lookup` | 快速查找用户：用户名 → rest_id + 基本信息 |
| `tweetlen-job-search` | 搜索 Twitter/X 职位，支持多条件筛选 |

## 使用示例

### 分析用户

```
你: 分析用户 @naval
你: Who is @pmarca? Give me a full profile analysis.
你: @elonmusk のプロフィールを分析して
```

### 话题研究

```
你: 推特上大家怎么看 "AI 监管"？
你: What's Twitter saying about "AI regulation"?
你: 研究一下大家对 GPT-5 的看法
```

### 趋势监控

```
你: 日本现在什么话题最火？
你: 看看美国现在的热门趋势
你: What's trending worldwide?
```

### 账号对比

```
你: 对比 @openai 和 @anthropic
你: Compare @Google and @Microsoft
```

### 社区探索

```
你: 探索 AI 相关的 Twitter 社区
你: Explore the "Generative AI" community
```

## 架构

```
┌──────────────────────────────────────────────┐
│              Claude Code + Skills             │
├──────────┬──────────┬───────────┬─────────────┤
│ Analysis │ Research │  Utility  │    API      │
│ Skills   │ Skills   │  Skills   │   Skills    │
├──────────┴──────────┴───────────┴─────────────┤
│           Tweetlen API (api.tweetlen.com)      │
│              Authorization: Bearer twtl_xxx    │
├──────────────────────────────────────────────-┤
│              Twitter/X 平台                    │
└───────────────────────────────────────────────┘
```

## API 参考

| 基础 URL | 认证方式 | 请求方法 | 分页方式 |
|----------|---------|---------|---------|
| `https://api.tweetlen.com/v2` | `Bearer twtl_xxx` | GET | 基于 cursor |

完整 API 文档请访问 **[api.tweetlen.com](https://api.tweetlen.com)**。

## 贡献

欢迎提 Issue 或提交 Pull Request！

## 许可证

[MIT](LICENSE)
