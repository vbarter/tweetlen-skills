---
name: tweetlen-api-community
description: "Twitter/X Community API - Search communities, topics, details, members, moderators, tweets. Trigger: get community, 查社区"
---

## Prerequisites

- Tweetlen API Key required. Get one at [api.tweetlen.com](https://api.tweetlen.com)
- Set env var: `TWEETLEN_API_KEY=twtl_your_key_here`

## API Base Info

- **Base URL**: `https://api.tweetlen.com/v2`
- **Auth**: `Authorization: Bearer $TWEETLEN_API_KEY`
- **Method**: All endpoints use HTTP GET

## Endpoints

### 1. Search Communities

Search for Twitter/X communities by keyword.

- **Path**: `GET /v2/community/search`
- **Parameters**:
  - `query` (query, required): Search query string
  - `count` (query, optional, default: 20): Number of results to return
  - `cursor` (query, optional): Pagination cursor from previous response
- **Example**:
```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/community/search?query=AI&count=20"
```

### 2. Get Community Topics

Fetch all available community topic categories. No parameters required.

- **Path**: `GET /v2/community/topics`
- **Parameters**: None
- **Example**:
```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/community/topics"
```

### 3. Get Popular Communities

Fetch popular communities for a given topic.

- **Path**: `GET /v2/community/popular`
- **Parameters**:
  - `topicId` (query, required): Topic ID from the topics endpoint
  - `count` (query, optional, default: 20): Number of communities to return
  - `cursor` (query, optional): Pagination cursor from previous response
- **Example**:
```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/community/popular?topicId=12345&count=20"
```

### 4. Get Community Timeline

Fetch the timeline of posts from communities under a specific topic.

- **Path**: `GET /v2/community/timeline`
- **Parameters**:
  - `topicId` (query, required): Topic ID from the topics endpoint
  - `cursor` (query, optional): Pagination cursor from previous response
- **Example**:
```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/community/timeline?topicId=12345"
```

### 5. Get Community Details

Fetch detailed information about a specific community.

- **Path**: `GET /v2/community/:communityId`
- **Parameters**:
  - `communityId` (path, required): The community's numeric ID
- **Example**:
```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/community/1234567890"
```

### 6. Get Community About

Fetch the about/description information for a specific community.

- **Path**: `GET /v2/community/:communityId/about`
- **Parameters**:
  - `communityId` (path, required): The community's numeric ID
- **Example**:
```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/community/1234567890/about"
```

### 7. Get Community Members

Fetch the member list of a specific community.

- **Path**: `GET /v2/community/:communityId/members`
- **Parameters**:
  - `communityId` (path, required): The community's numeric ID
  - `cursor` (query, optional): Pagination cursor from previous response
- **Example**:
```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/community/1234567890/members"
```

### 8. Get Community Members V2

Fetch the member list of a specific community (V2 response format).

- **Path**: `GET /v2/community/:communityId/members/v2`
- **Parameters**:
  - `communityId` (path, required): The community's numeric ID
  - `cursor` (query, optional): Pagination cursor from previous response
- **Example**:
```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/community/1234567890/members/v2"
```

### 9. Get Community Moderators

Fetch the moderator list of a specific community.

- **Path**: `GET /v2/community/:communityId/moderators`
- **Parameters**:
  - `communityId` (path, required): The community's numeric ID
  - `cursor` (query, optional): Pagination cursor from previous response
- **Example**:
```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/community/1234567890/moderators"
```

### 10. Get Community Tweets

Fetch tweets posted in a specific community.

- **Path**: `GET /v2/community/:communityId/tweets`
- **Parameters**:
  - `communityId` (path, required): The community's numeric ID
  - `searchType` (query, optional): Filter by content type - `Default` or `Media`
  - `count` (query, optional, default: 20): Number of tweets to return
  - `cursor` (query, optional): Pagination cursor from previous response
  - `rankingMode` (query, optional): Sorting mode - `Relevance`
- **Example**:
```bash
# Get default tweets
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/community/1234567890/tweets?count=20"

# Get only media tweets
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/community/1234567890/tweets?searchType=Media&count=20"

# Get tweets sorted by relevance
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/community/1234567890/tweets?rankingMode=Relevance&count=20"
```

## Common Patterns

### Discovering Communities

The typical workflow for finding and exploring communities:

```bash
# Step 1: Browse available topics
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/community/topics"

# Step 2: Find popular communities for a topic
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/community/popular?topicId=12345"

# Step 3: Or search directly by keyword
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/community/search?query=machine%20learning"

# Step 4: Get community details
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/community/1234567890"

# Step 5: Browse community tweets
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/community/1234567890/tweets?count=20"
```

### Pagination with Cursor

All list endpoints return a `cursor` value for pagination:

```bash
# First page
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/community/1234567890/tweets?count=20"

# Next page
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/community/1234567890/tweets?count=20&cursor=DAABCgABGPmh..."
```
