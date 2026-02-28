# Tweetlen Skills - Project Conventions

## Overview

This is a Claude Code Skills repository for Twitter/X data analysis, powered by the Tweetlen API.

## API Configuration

### Base URL

All API calls go through:

```
https://api.tweetlen.com/v2/*
```

### Authentication

Every request must include the API key in the `Authorization` header:

```
Authorization: Bearer <api_key>
```

### API Key Setup

The API key is stored in `~/.claude/settings.json`:

```json
{
  "env": {
    "TWEETLEN_API_KEY": "twtl_your_key_here"
  }
}
```

### Making API Calls (IMPORTANT)

**Do NOT rely on `$TWEETLEN_API_KEY` environment variable** — it may not be loaded depending on shell initialization. Instead, always read the key from the config file inline:

```bash
curl -s -H "Authorization: Bearer $(jq -r '.env.TWEETLEN_API_KEY' ~/.claude/settings.json)" \
  "https://api.tweetlen.com/v2/..."
```

### Pre-flight Check

**Before making ANY Tweetlen API call**, check if the key is configured:

```bash
jq -r '.env.TWEETLEN_API_KEY // empty' ~/.claude/settings.json 2>/dev/null
```

If the output is empty, do NOT proceed with the API call. Instead:
1. Tell the user their API key is not configured
2. Ask the user for their API key (they can get one at https://api.tweetlen.com)
3. Once the user provides the key, write it to `~/.claude/settings.json`:
   ```bash
   jq --arg key "THE_KEY" '.env.TWEETLEN_API_KEY = $key' ~/.claude/settings.json > /tmp/claude_settings.tmp && mv /tmp/claude_settings.tmp ~/.claude/settings.json
   ```
   If `~/.claude/settings.json` doesn't exist, create it:
   ```bash
   mkdir -p ~/.claude && echo '{"env":{"TWEETLEN_API_KEY":"THE_KEY"}}' > ~/.claude/settings.json
   ```
4. After writing, the key is immediately available via `jq` reads — no restart needed

## Response Format

### Success

```json
{
  "success": true,
  "data": T,
  "meta": {}
}
```

### Error

```json
{
  "success": false,
  "error": {
    "message": "Human-readable error description",
    "code": "ERROR_CODE"
  }
}
```

## Pagination

- Cursor-based pagination using the `cursor` query parameter
- Default sample size: **20 items per request**
- Do NOT paginate by default; only paginate when the user explicitly requests more data or a complete dataset

## Output Format

- All skill outputs should be formatted as **Markdown reports**
- Use tables, headers, and lists for structured data presentation

## Language Support

- Skills support both **Chinese** and **English**
- Respond in the same language the user uses

## Conventions

- All skills use `Bash` (curl) to call the Tweetlen API
- **Always read the key from config file inline**: `$(jq -r '.env.TWEETLEN_API_KEY' ~/.claude/settings.json)` — never rely on `$TWEETLEN_API_KEY` env var
- Always check for `success: true` in the response before processing data
- Handle errors gracefully and display the error message to the user
- Include relevant metrics and statistics in reports when available
