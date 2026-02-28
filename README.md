<div align="center">

# Tweetlen Skills

**Twitter/X Data Analysis Skills for Claude Code**

[![Version](https://img.shields.io/badge/version-0.1.0-blue.svg)](https://github.com/vbarter/tweetlen-skills)
[![Skills](https://img.shields.io/badge/skills-18-green.svg)](#skills-overview)
[![License](https://img.shields.io/badge/license-MIT-brightgreen.svg)](LICENSE)

Turn Claude Code into a powerful Twitter/X analytics assistant.
Query users, analyze tweets, research topics, and monitor trends — all through natural language.

[**English**](README.md) | [**中文**](README.zh.md) | [**日本語**](README.ja.md)

</div>

---

## Installation

```bash
# 1. Add the marketplace
/plugin marketplace add vbarter/tweetlen-skills

# 2. Install the plugins you need
/plugin install api-skills@tweetlen-skills
/plugin install analysis-skills@tweetlen-skills
/plugin install research-skills@tweetlen-skills
/plugin install utility-skills@tweetlen-skills

# 3. Configure your API key (interactive)
bash ~/.claude/plugins/tweetlen-skills/setup.sh
```

## API Key Setup

> [!IMPORTANT]
> **You need a Tweetlen API Key to use these skills.**
>
> 1. Sign up at **[api.tweetlen.com](https://api.tweetlen.com)**
> 2. Create an API Key in the dashboard (format: `twtl_xxx`)
> 3. Configure the key using **one** of the methods below:

### Quick Setup (Recommended)

Run the setup script — it writes the key to `~/.claude/settings.json` automatically:

```bash
bash ~/.claude/plugins/tweetlen-skills/setup.sh
```

> Restart Claude Code after setup for the key to take effect.

### Manual Setup

<details open>
<summary><b>Option 1: Claude Code Settings (Recommended)</b></summary>

Add `TWEETLEN_API_KEY` to the `env` field in `~/.claude/settings.json`:

```json
{
  "env": {
    "TWEETLEN_API_KEY": "twtl_your_key_here"
  }
}
```

This is a one-time setup. The key is automatically available in all projects and all Bash/curl calls.

</details>

<details>
<summary><b>Option 2: Project-Level Config</b></summary>

Create `.claude/settings.local.json` in your project root (git-ignored):

```json
{
  "env": {
    "TWEETLEN_API_KEY": "twtl_your_key_here"
  }
}
```

</details>

<details>
<summary><b>Option 3: Shell Environment Variable</b></summary>

```bash
export TWEETLEN_API_KEY=twtl_your_key_here
```

> Note: This requires the variable to be exported in your shell profile (`.zshrc` / `.bashrc`).

</details>

## Quick Start

```
You: Analyze the Twitter account @elonmusk
You: What's Twitter saying about "Claude AI"?
You: Compare @openai and @anthropic
You: What's trending worldwide right now?
You: Look up user @naval
```

Claude Code will automatically select and execute the appropriate skill.

## Skills Overview

### API Skills — Direct Endpoint Wrappers

Low-level building blocks. Each skill wraps a category of Twitter/X API endpoints with parameter docs and examples.

| Skill | Endpoints | What It Does |
|-------|:---------:|-------------|
| `tweetlen-api-user` | 16 | User profiles, followers, following, tweets, replies, media, highlights |
| `tweetlen-api-tweet` | 7 | Tweet details, comments, retweets, quotes |
| `tweetlen-api-search` | 4 | Full-text search (v1/v2/v3), autocomplete |
| `tweetlen-api-community` | 10 | Community search, topics, members, moderators, tweets |
| `tweetlen-api-list` | 5 | List search, details, members, followers, timeline |
| `tweetlen-api-trends` | 2 | Available locations, trending topics by region |
| `tweetlen-api-space` | 1 | Space/audio room details |
| `tweetlen-api-jobs` | 3 | Job search, details, location suggestions |

### Analysis Skills — Multi-Step Workflows

Combine multiple API calls with analysis logic to produce structured reports.

| Skill | What It Does |
|-------|-------------|
| `tweetlen-user-profile` | Comprehensive user analysis: profile + tweets + followers + engagement metrics |
| `tweetlen-tweet-analysis` | Deep tweet analysis: comments + retweets + quotes + sentiment |
| `tweetlen-user-comparison` | Side-by-side comparison of two accounts |
| `tweetlen-influence-report` | KOL influence assessment with tier classification |

### Research Skills — Discovery Workflows

Multi-step research workflows for trend and topic analysis.

| Skill | What It Does |
|-------|-------------|
| `tweetlen-topic-research` | Topic sentiment research: search + key voices + comment analysis |
| `tweetlen-trend-monitor` | Regional trend monitoring with context for top trends |
| `tweetlen-community-explorer` | Community deep dive: structure, members, moderators, content |
| `tweetlen-list-explorer` | List exploration: members, timeline, follower analysis |

### Utility Skills — Quick Tools

| Skill | What It Does |
|-------|-------------|
| `tweetlen-user-lookup` | Quick username → rest_id resolution with basic profile info |
| `tweetlen-job-search` | Search Twitter/X job postings with filters |

## Usage Examples

### Analyze a User

```
You: 分析用户 @naval
You: Who is @pmarca? Give me a full profile analysis.
You: @elonmusk のプロフィールを分析して
```

### Research a Topic

```
You: What's Twitter saying about "AI regulation"?
You: 研究一下大家对 GPT-5 的看法
You: 「量子コンピュータ」についてのツイートを調べて
```

### Monitor Trends

```
You: What's trending in Japan right now?
You: 看看美国现在什么话题最火
You: 世界のトレンドを教えて
```

### Compare Accounts

```
You: Compare @openai and @anthropic
You: 对比 @Google 和 @Microsoft
```

### Explore Communities

```
You: Explore the "Generative AI" community on Twitter
You: 探索 AI 相关的 Twitter 社区
```

## Architecture

```
┌─────────────────────────────────────────────┐
│              Claude Code + Skills            │
├──────────┬──────────┬───────────┬────────────┤
│ Analysis │ Research │  Utility  │  API       │
│ Skills   │ Skills   │  Skills   │  Skills    │
├──────────┴──────────┴───────────┴────────────┤
│           Tweetlen API (api.tweetlen.com)     │
│              Authorization: Bearer twtl_xxx   │
├──────────────────────────────────────────────┤
│              Twitter/X Platform               │
└──────────────────────────────────────────────┘
```

## API Reference

| Base URL | Auth | Method | Pagination |
|----------|------|--------|------------|
| `https://api.tweetlen.com/v2` | `Bearer twtl_xxx` | GET | Cursor-based |

For full API documentation, visit **[api.tweetlen.com](https://api.tweetlen.com)**.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request.

## License

[MIT](LICENSE)
