---
name: tweetlen-api-user
description: "Twitter/X User API - Look up users, get followers/following, tweets, replies, media, highlights, and org affiliates. Trigger: get user, 查用户, get followers, 查粉丝"
---

## Prerequisites

- Tweetlen API Key required. Get one at [api.tweetlen.com](https://api.tweetlen.com)
- Run `setup.sh` or add `TWEETLEN_API_KEY` to `~/.claude/settings.json` under `env`

## API Base Info

- **Base URL**: `https://api.tweetlen.com/v2`
- **Auth**: `Authorization: Bearer $TWEETLEN_API_KEY`
- **Method**: All endpoints use HTTP GET

## Endpoints

### 1. Get User by Username

Look up a user profile by their Twitter/X username. Returns the user's `rest_id` which is needed for most other endpoints.

- **Path**: `GET /v2/user/by-username/:username`
- **Parameters**:
  - `username` (path, required): Twitter/X username without the @ symbol
- **Example**:
```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/user/by-username/elonmusk"
```

### 2. Get Users by IDs

Batch fetch multiple user profiles by their rest_ids.

- **Path**: `GET /v2/user/by-ids`
- **Parameters**:
  - `ids` (query, required): Comma-separated list of user rest_ids
- **Example**:
```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/user/by-ids?ids=44196397,783214"
```

### 3. Get Users by IDs V2

Batch fetch multiple user profiles by their rest_ids (V2 response format).

- **Path**: `GET /v2/user/by-ids/v2`
- **Parameters**:
  - `ids` (query, required): Comma-separated list of user rest_ids
- **Example**:
```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/user/by-ids/v2?ids=44196397,783214"
```

### 4. Get User Tweets

Fetch tweets posted by a specific user.

- **Path**: `GET /v2/user/:userId/tweets`
- **Parameters**:
  - `userId` (path, required): User's rest_id (e.g. 44196397 for @elonmusk)
  - `count` (query, optional, default: 20): Number of tweets to return
  - `cursor` (query, optional): Pagination cursor from previous response
- **Example**:
```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/user/44196397/tweets?count=20"
```

### 5. Get User Replies

Fetch replies posted by a specific user.

- **Path**: `GET /v2/user/:userId/replies`
- **Parameters**:
  - `userId` (path, required): User's rest_id
  - `count` (query, optional, default: 20): Number of replies to return
  - `cursor` (query, optional): Pagination cursor from previous response
- **Example**:
```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/user/44196397/replies?count=20"
```

### 6. Get User Replies V2

Fetch replies posted by a specific user (V2 response format).

- **Path**: `GET /v2/user/:userId/replies/v2`
- **Parameters**:
  - `userId` (path, required): User's rest_id
  - `count` (query, optional, default: 20): Number of replies to return
  - `cursor` (query, optional): Pagination cursor from previous response
- **Example**:
```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/user/44196397/replies/v2?count=20"
```

### 7. Get User Media

Fetch media (images, videos) posted by a specific user.

- **Path**: `GET /v2/user/:userId/media`
- **Parameters**:
  - `userId` (path, required): User's rest_id
  - `count` (query, optional, default: 20): Number of media items to return
  - `cursor` (query, optional): Pagination cursor from previous response
- **Example**:
```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/user/44196397/media?count=20"
```

### 8. Get User Followers

Fetch the followers of a specific user.

- **Path**: `GET /v2/user/:userId/followers`
- **Parameters**:
  - `userId` (path, required): User's rest_id
  - `count` (query, optional, default: 20): Number of followers to return
  - `cursor` (query, optional): Pagination cursor from previous response
- **Example**:
```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/user/44196397/followers?count=20"
```

### 9. Get Follower IDs by Username

Fetch follower IDs for a user by their username. Returns only IDs, useful for large-scale analysis.

- **Path**: `GET /v2/user/followers-ids/:username`
- **Parameters**:
  - `username` (path, required): Twitter/X username without @
  - `count` (query, optional, default: 500, max: 5000): Number of follower IDs to return
  - `cursor` (query, optional): Pagination cursor from previous response
- **Example**:
```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/user/followers-ids/elonmusk?count=1000"
```

### 10. Get User Following

Fetch accounts that a specific user follows.

- **Path**: `GET /v2/user/:userId/following`
- **Parameters**:
  - `userId` (path, required): User's rest_id
  - `count` (query, optional, default: 20): Number of following to return
  - `cursor` (query, optional): Pagination cursor from previous response
- **Example**:
```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/user/44196397/following?count=20"
```

### 11. Get Following IDs by Username

Fetch IDs of accounts that a user follows, by their username. Returns only IDs.

- **Path**: `GET /v2/user/following-ids/:username`
- **Parameters**:
  - `username` (path, required): Twitter/X username without @
  - `count` (query, optional, default: 500, max: 5000): Number of following IDs to return
  - `cursor` (query, optional): Pagination cursor from previous response
- **Example**:
```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/user/following-ids/elonmusk?count=1000"
```

### 12. Get Verified Followers

Fetch verified (blue check) followers of a specific user.

- **Path**: `GET /v2/user/:userId/verified-followers`
- **Parameters**:
  - `userId` (path, required): User's rest_id
  - `count` (query, optional, default: 20): Number of verified followers to return
  - `cursor` (query, optional): Pagination cursor from previous response
- **Example**:
```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/user/44196397/verified-followers?count=20"
```

### 13. Get User Highlights

Fetch highlighted tweets (pinned or featured) from a user's profile.

- **Path**: `GET /v2/user/:userId/highlights`
- **Parameters**:
  - `userId` (path, required): User's rest_id
  - `count` (query, optional, default: 20): Number of highlights to return
  - `cursor` (query, optional): Pagination cursor from previous response
- **Example**:
```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/user/44196397/highlights?count=20"
```

### 14. Get User Account Info

Get detailed account information for a user by username, including creation date, account stats, and more.

- **Path**: `GET /v2/user/about/:username`
- **Parameters**:
  - `username` (path, required): Twitter/X username without @
- **Example**:
```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/user/about/elonmusk"
```

### 15. Get User Likes (Deprecated)

Fetch tweets liked by a specific user. **Note: This endpoint is deprecated and may be removed in the future.**

- **Path**: `GET /v2/user/:userId/likes`
- **Parameters**:
  - `userId` (path, required): User's rest_id
  - `count` (query, optional, default: 20): Number of liked tweets to return
  - `cursor` (query, optional): Pagination cursor from previous response
- **Example**:
```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/user/44196397/likes?count=20"
```

### 16. Get Organization Affiliates

Fetch users affiliated with the same organization as a specific user.

- **Path**: `GET /v2/user/:userId/org-affiliates`
- **Parameters**:
  - `userId` (path, required): User's rest_id
  - `count` (query, optional, default: 20): Number of affiliates to return
  - `cursor` (query, optional): Pagination cursor from previous response
- **Example**:
```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/user/44196397/org-affiliates?count=20"
```

## Common Patterns

### Username to rest_id Workflow

Most endpoints require a user's `rest_id` (numeric ID). Always start by looking up the username:

```bash
# Step 1: Get rest_id from username
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/user/by-username/elonmusk"
# Response contains rest_id: "44196397"

# Step 2: Use rest_id for subsequent calls
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/user/44196397/tweets"
```

### Pagination with Cursor

Paginated endpoints return a `cursor` value in the response. Pass it as a query parameter to fetch the next page:

```bash
# First page
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/user/44196397/tweets?count=20"

# Next page (use cursor from previous response)
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/user/44196397/tweets?count=20&cursor=DAABCgABGPmh..."
```

### Default Sampling

Most list endpoints default to `count=20`. Adjust as needed, but keep in mind that larger counts consume more API quota. The followers-ids and following-ids endpoints support up to `count=5000` for efficient bulk retrieval.
