---
name: tweetlen-api-tweet
description: "Twitter/X Tweet API - Get tweet details, batch fetch, comments, retweets, and quotes. Trigger: get tweet, 查推文, get comments, 查评论"
---

## Prerequisites

- Tweetlen API Key required. Get one at [api.tweetlen.com](https://api.tweetlen.com)
- Set env var: `TWEETLEN_API_KEY=twtl_your_key_here`

## API Base Info

- **Base URL**: `https://api.tweetlen.com/v2`
- **Auth**: `Authorization: Bearer $TWEETLEN_API_KEY`
- **Method**: All endpoints use HTTP GET

## Endpoints

### 1. Get Tweet Detail V2

Fetch full details for a single tweet including text, media, engagement metrics, and author info.

- **Path**: `GET /v2/tweet/:tweetId/v2`
- **Parameters**:
  - `tweetId` (path, required): The tweet's numeric ID
- **Example**:
```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/tweet/1234567890123456789/v2"
```

### 2. Get Tweets by IDs

Batch fetch multiple tweets by their IDs in a single request.

- **Path**: `GET /v2/tweet/by-ids`
- **Parameters**:
  - `ids` (query, required): Comma-separated list of tweet IDs
- **Example**:
```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/tweet/by-ids?ids=1234567890123456789,9876543210987654321"
```

### 3. Get Tweets by IDs V2

Batch fetch multiple tweets by their IDs (V2 response format).

- **Path**: `GET /v2/tweet/by-ids/v2`
- **Parameters**:
  - `ids` (query, required): Comma-separated list of tweet IDs
- **Example**:
```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/tweet/by-ids/v2?ids=1234567890123456789,9876543210987654321"
```

### 4. Get Tweet Comments

Fetch replies/comments on a specific tweet.

- **Path**: `GET /v2/tweet/:tweetId/comments`
- **Parameters**:
  - `tweetId` (path, required): The tweet's numeric ID
  - `count` (query, optional, default: 40): Number of comments to return
  - `cursor` (query, optional): Pagination cursor from previous response
- **Example**:
```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/tweet/1234567890123456789/comments?count=40"
```

### 5. Get Tweet Comments V2

Fetch replies/comments on a specific tweet with ranking options (V2 response format).

- **Path**: `GET /v2/tweet/:tweetId/comments/v2`
- **Parameters**:
  - `tweetId` (path, required): The tweet's numeric ID
  - `count` (query, optional, default: 20): Number of comments to return
  - `cursor` (query, optional): Pagination cursor from previous response
  - `rankingMode` (query, optional): Sorting mode - one of `Relevance`, `Recency`, or `Likes`
- **Example**:
```bash
# Get most relevant comments
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/tweet/1234567890123456789/comments/v2?count=20&rankingMode=Relevance"

# Get newest comments first
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/tweet/1234567890123456789/comments/v2?count=20&rankingMode=Recency"

# Get most liked comments
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/tweet/1234567890123456789/comments/v2?count=20&rankingMode=Likes"
```

### 6. Get Tweet Retweets

Fetch users who retweeted a specific tweet.

- **Path**: `GET /v2/tweet/:tweetId/retweets`
- **Parameters**:
  - `tweetId` (path, required): The tweet's numeric ID
  - `count` (query, optional, default: 40): Number of retweets to return
  - `cursor` (query, optional): Pagination cursor from previous response
- **Example**:
```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/tweet/1234567890123456789/retweets?count=40"
```

### 7. Get Tweet Quotes

Fetch quote tweets of a specific tweet.

- **Path**: `GET /v2/tweet/:tweetId/quotes`
- **Parameters**:
  - `tweetId` (path, required): The tweet's numeric ID
  - `count` (query, optional, default: 40): Number of quotes to return
  - `cursor` (query, optional): Pagination cursor from previous response
- **Example**:
```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/tweet/1234567890123456789/quotes?count=40"
```

## Common Patterns

### Extracting Tweet ID from URL

Tweet IDs can be extracted from Twitter/X URLs. The numeric ID is the last segment of the status URL:

```
https://x.com/elonmusk/status/1234567890123456789
                                └── tweetId = 1234567890123456789

https://twitter.com/elonmusk/status/1234567890123456789
                                     └── tweetId = 1234567890123456789
```

### Comments Ranking Modes

The V2 comments endpoint supports three ranking modes:

| Mode | Description |
|------|-------------|
| `Relevance` | Default. Shows most relevant comments based on engagement and author |
| `Recency` | Shows newest comments first (chronological) |
| `Likes` | Shows most liked comments first |

### Pagination with Cursor

All list endpoints return a `cursor` value for pagination:

```bash
# First page
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/tweet/1234567890123456789/comments?count=40"

# Next page (use cursor from previous response)
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/tweet/1234567890123456789/comments?count=40&cursor=DAABCgABGPmh..."
```

### Batch Fetching

When you need details for multiple tweets, use the batch endpoints (`by-ids` or `by-ids/v2`) instead of making individual requests. This is more efficient and consumes less API quota:

```bash
# Efficient: one request for 5 tweets
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/tweet/by-ids?ids=111,222,333,444,555"
```
