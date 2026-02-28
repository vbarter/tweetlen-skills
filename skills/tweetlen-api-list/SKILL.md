---
name: tweetlen-api-list
description: "Twitter/X List API - Search lists, get details, members, followers, timeline. Trigger: get list, 查列表"
---

## Prerequisites

- Tweetlen API Key required. Get one at [api.tweetlen.com](https://api.tweetlen.com)
- Run `setup.sh` or add `TWEETLEN_API_KEY` to `~/.claude/settings.json` under `env`

## API Base Info

- **Base URL**: `https://api.tweetlen.com/v2`
- **Auth**: `Authorization: Bearer $TWEETLEN_API_KEY`
- **Method**: All endpoints use HTTP GET

## Endpoints

### 1. Search Lists

Search for Twitter/X lists by keyword.

- **Path**: `GET /v2/list/search`
- **Parameters**:
  - `query` (query, required): Search query string
- **Example**:
```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/list/search?query=AI%20researchers"
```

### 2. Get List Details

Fetch detailed information about a specific list.

- **Path**: `GET /v2/list/:listId`
- **Parameters**:
  - `listId` (path, required): The list's numeric ID
- **Example**:
```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/list/1234567890"
```

### 3. Get List Members

Fetch the members of a specific list.

- **Path**: `GET /v2/list/:listId/members`
- **Parameters**:
  - `listId` (path, required): The list's numeric ID
  - `count` (query, optional, default: 20): Number of members to return
  - `cursor` (query, optional): Pagination cursor from previous response
- **Example**:
```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/list/1234567890/members?count=20"
```

### 4. Get List Followers

Fetch users who follow a specific list.

- **Path**: `GET /v2/list/:listId/followers`
- **Parameters**:
  - `listId` (path, required): The list's numeric ID
  - `count` (query, optional, default: 20): Number of followers to return
  - `cursor` (query, optional): Pagination cursor from previous response
- **Example**:
```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/list/1234567890/followers?count=20"
```

### 5. Get List Timeline

Fetch tweets from a specific list's timeline.

- **Path**: `GET /v2/list/:listId/timeline`
- **Parameters**:
  - `listId` (path, required): The list's numeric ID
  - `cursor` (query, optional): Pagination cursor from previous response
- **Example**:
```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/list/1234567890/timeline"
```

## Common Patterns

### Discovering and Using Lists

Lists are curated collections of Twitter/X accounts. The typical workflow:

```bash
# Step 1: Search for lists on a topic
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/list/search?query=tech%20founders"

# Step 2: Get details about a specific list
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/list/1234567890"

# Step 3: See who is on the list
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/list/1234567890/members?count=20"

# Step 4: Read the list's tweet timeline
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/list/1234567890/timeline"
```

### Pagination with Cursor

All list endpoints (except search and details) return a `cursor` value for pagination:

```bash
# First page of members
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/list/1234567890/members?count=20"

# Next page
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/list/1234567890/members?count=20&cursor=DAABCgABGPmh..."
```
