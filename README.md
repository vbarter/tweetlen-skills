# Tweetlen Skills for Claude Code

> Twitter/X data analysis skills powered by Tweetlen API

> **⚠️ Prerequisite: Get and Configure Your API Key**
>
> Before using these skills, you need to:
>
> **Step 1: Get your key**
> 1. Visit [api.tweetlen.com](https://api.tweetlen.com) and create an account
> 2. Create an API Key in the dashboard (format: `twtl_xxx`)
>
> **Step 2: Configure your key** (choose one)
>
> Recommended — add to Claude Code settings (one-time setup, works everywhere):
> ```bash
> # Edit ~/.claude/settings.json
> {
>   "env": {
>     "TWEETLEN_API_KEY": "twtl_your_key_here"
>   }
> }
> ```
>
> Or — set as environment variable:
> ```bash
> export TWEETLEN_API_KEY=twtl_your_key_here
> ```
>
> Or — add to project-level config (`.claude/settings.local.json`, git-ignored):
> ```json
> {
>   "env": {
>     "TWEETLEN_API_KEY": "twtl_your_key_here"
>   }
> }
> ```
>
> All skills call the Tweetlen API to fetch Twitter/X data.

## Features

Tweetlen Skills is organized into 4 plugin groups:

- **api-skills** - Direct Twitter/X API endpoint wrappers for users, tweets, search, communities, lists, trends, spaces, and jobs
- **analysis-skills** - Multi-step analysis workflows for user profiling, tweet analysis, user comparison, and influence reports
- **research-skills** - Topic research, trend monitoring, community and list exploration workflows
- **utility-skills** - Quick user lookup and job search utilities

## Installation

```bash
# 1. Add the marketplace
/plugin marketplace add vbarter/tweetlen-skills

# 2. Install the plugins you need
/plugin install api-skills@tweetlen-skills
/plugin install analysis-skills@tweetlen-skills
/plugin install research-skills@tweetlen-skills
/plugin install utility-skills@tweetlen-skills
```

## Skills Overview

| Skill | Plugin | Description |
|-------|--------|-------------|
| `tweetlen-api-user` | api-skills | Fetch user profiles, followers, followings, and media |
| `tweetlen-api-tweet` | api-skills | Get tweet details, replies, quotes, retweets, and likes |
| `tweetlen-api-search` | api-skills | Search tweets, users, and content |
| `tweetlen-api-community` | api-skills | Explore community details, members, and timelines |
| `tweetlen-api-list` | api-skills | Browse list details, members, and timelines |
| `tweetlen-api-trends` | api-skills | Get trending topics by location |
| `tweetlen-api-space` | api-skills | Get Twitter Space details |
| `tweetlen-api-jobs` | api-skills | Search and view job listings |
| `tweetlen-user-profile` | analysis-skills | Generate comprehensive user profile analysis |
| `tweetlen-tweet-analysis` | analysis-skills | Analyze tweet engagement and content patterns |
| `tweetlen-user-comparison` | analysis-skills | Compare two or more user accounts side by side |
| `tweetlen-influence-report` | analysis-skills | Generate KOL influence and reach reports |
| `tweetlen-topic-research` | research-skills | Research topics across tweets, users, and communities |
| `tweetlen-trend-monitor` | research-skills | Monitor and analyze trending topics |
| `tweetlen-community-explorer` | research-skills | Deep dive into community structure and activity |
| `tweetlen-list-explorer` | research-skills | Explore curated lists and their members |
| `tweetlen-user-lookup` | utility-skills | Quick user information lookup |
| `tweetlen-job-search` | utility-skills | Search Twitter job listings |

## Usage Examples

**Analyze a user's profile:**

```
/tweetlen-user-profile @elonmusk
```

**Research a topic:**

```
/tweetlen-topic-research "artificial intelligence" --lang en
```

**Compare two accounts:**

```
/tweetlen-user-comparison @openai @anthropic
```

## API Documentation

For full API documentation and to obtain an API key, visit [api.tweetlen.com](https://api.tweetlen.com).

## License

MIT
