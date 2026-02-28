---
name: tweetlen-api-search
description: "Twitter/X Search API - Full-text search (v1/v2/v3) and autocomplete. Trigger: search Twitter, 搜索推特, search tweets"
---

## Prerequisites

- Tweetlen API Key required. Get one at [api.tweetlen.com](https://api.tweetlen.com)
- Run `setup.sh` or add `TWEETLEN_API_KEY` to `~/.claude/settings.json` under `env`

## API Base Info

- **Base URL**: `https://api.tweetlen.com/v2`
- **Auth**: `Authorization: Bearer $TWEETLEN_API_KEY`
- **Method**: All endpoints use HTTP GET

## Endpoints

### 1. Search V1

Search Twitter/X content with full-text queries (V1 response format).

- **Path**: `GET /v2/search/v1`
- **Parameters**:
  - `query` (query, required): Search query string. Supports Twitter advanced search operators
  - `type` (query, optional): Result type filter - one or more of `Top`, `Latest`, `People`, `Media`, `Lists` (comma-separated)
  - `count` (query, optional, default: 20): Number of results to return
  - `cursor` (query, optional): Pagination cursor from previous response
- **Example**:
```bash
# Search for latest tweets about AI
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/search/v1?query=artificial%20intelligence&type=Latest&count=20"
```

### 2. Search V2

Search Twitter/X content with full-text queries (V2 response format).

- **Path**: `GET /v2/search/v2`
- **Parameters**:
  - `query` (query, required): Search query string
  - `type` (query, optional): Result type filter - one or more of `Top`, `Latest`, `People`, `Media`, `Lists` (comma-separated)
  - `count` (query, optional, default: 20): Number of results to return
  - `cursor` (query, optional): Pagination cursor from previous response
- **Example**:
```bash
# Search for top tweets from a specific user
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/search/v2?query=from%3Aelonmusk&type=Top&count=20"
```

### 3. Search V3

Search Twitter/X content with full-text queries (V3 response format). **Recommended for most use cases.**

- **Path**: `GET /v2/search/v3`
- **Parameters**:
  - `query` (query, required): Search query string
  - `type` (query, optional): Result type filter - one or more of `Top`, `Latest`, `People`, `Media`, `Lists` (comma-separated)
  - `count` (query, optional, default: 20): Number of results to return
  - `cursor` (query, optional): Pagination cursor from previous response
- **Example**:
```bash
# Search for media about SpaceX
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/search/v3?query=SpaceX%20launch&type=Media&count=20"

# Search for people matching a query
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/search/v3?query=data%20scientist&type=People&count=20"

# Search multiple types at once
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/search/v3?query=tech%20startup&type=Top,Latest&count=20"
```

### 4. Autocomplete

Get search autocomplete suggestions as the user types.

- **Path**: `GET /v2/search/autocomplete`
- **Parameters**:
  - `value` (query, required): Partial search text to get suggestions for
- **Example**:
```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/search/autocomplete?value=elon"
```

## Common Patterns

### Which Version to Use

- **V3** is recommended for most use cases - provides the most complete response format
- **V2** is useful if you need V2-specific response structure
- **V1** is available for backward compatibility

### Search Type Filters

| Type | Description |
|------|-------------|
| `Top` | Most relevant/popular results |
| `Latest` | Chronological order, newest first |
| `People` | User accounts matching the query |
| `Media` | Tweets containing images or videos |
| `Lists` | Twitter Lists matching the query |

You can combine multiple types with commas: `type=Top,Latest`

### Advanced Search Operators

Twitter search supports powerful operators in the `query` parameter:

| Operator | Example | Description |
|----------|---------|-------------|
| `from:` | `from:elonmusk` | Tweets from a specific user |
| `to:` | `to:elonmusk` | Tweets replying to a user |
| `@` | `@elonmusk` | Tweets mentioning a user |
| `#` | `#AI` | Tweets with a specific hashtag |
| `since:` | `since:2025-01-01` | Tweets after a date |
| `until:` | `until:2025-12-31` | Tweets before a date |
| `min_retweets:` | `min_retweets:100` | Tweets with minimum retweets |
| `min_faves:` | `min_faves:1000` | Tweets with minimum likes |
| `lang:` | `lang:en` | Tweets in a specific language |
| `filter:media` | `filter:media` | Only tweets with media |
| `filter:links` | `filter:links` | Only tweets with links |
| `-` | `-filter:replies` | Exclude replies |

Combine operators for precise searches:

```bash
# Tweets from Elon Musk about AI with at least 1000 likes since 2025
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/search/v3?query=from%3Aelonmusk%20AI%20min_faves%3A1000%20since%3A2025-01-01&type=Top"
```

### Pagination with Cursor

```bash
# First page
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/search/v3?query=AI&type=Latest&count=20"

# Next page (use cursor from previous response)
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/search/v3?query=AI&type=Latest&count=20&cursor=DAABCgABGPmh..."
```
