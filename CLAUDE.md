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

The API key is configured via `~/.claude/settings.json` (Claude Code's native config). This makes `$TWEETLEN_API_KEY` automatically available in all Bash/curl calls — no manual sourcing needed.

```json
{
  "env": {
    "TWEETLEN_API_KEY": "twtl_your_key_here"
  }
}
```

### Pre-flight Check (IMPORTANT)

**Before making ANY Tweetlen API call**, you MUST check if the key is configured:

```bash
[ -z "$TWEETLEN_API_KEY" ] && echo "NOT_SET" || echo "OK"
```

If the key is NOT set (`NOT_SET`), do NOT proceed with the API call. Instead:
1. Tell the user their API key is not configured
2. Ask the user for their API key (they can get one at https://api.tweetlen.com)
3. Once the user provides the key, write it to `~/.claude/settings.json` using this command:
   ```bash
   jq --arg key "THE_KEY" '.env.TWEETLEN_API_KEY = $key' ~/.claude/settings.json > /tmp/claude_settings.tmp && mv /tmp/claude_settings.tmp ~/.claude/settings.json
   ```
   If `~/.claude/settings.json` doesn't exist, create it:
   ```bash
   mkdir -p ~/.claude && echo '{"env":{"TWEETLEN_API_KEY":"THE_KEY"}}' > ~/.claude/settings.json
   ```
4. Tell the user to **restart Claude Code** for the key to take effect (env changes in settings.json require a restart)

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

- All skills use `WebFetch` or `Bash` (curl) to call the Tweetlen API
- Always check for `success: true` in the response before processing data
- Handle errors gracefully and display the error message to the user
- Include relevant metrics and statistics in reports when available
