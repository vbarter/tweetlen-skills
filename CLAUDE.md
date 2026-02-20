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
Authorization: Bearer $TWEETLEN_API_KEY
```

### API Key Setup

The API key can be configured via (in order of precedence):

1. **Claude Code `settings.json`** (recommended) - Add `TWEETLEN_API_KEY` to your Claude Code environment settings
2. **Project `settings.local.json`** - Add `TWEETLEN_API_KEY` for project-scoped configuration
3. **Shell environment variable** - `export TWEETLEN_API_KEY=twtl_your_key_here`

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
