---
name: tweetlen-user-comparison
description: "Compare two Twitter/X users side by side. Analyzes profiles, content, engagement, and audience. Trigger: 对比用户, compare users, compare @A and @B"
---

## Prerequisites

- Tweetlen API Key required. Get one at [api.tweetlen.com](https://api.tweetlen.com)
- Set env var: `TWEETLEN_API_KEY=twtl_your_key_here`

## Input Parsing

Accept two usernames in any format:
- "compare @userA and @userB"
- "compare userA userB"
- "对比用户 @userA @userB"

Strip `@` prefix if present.

## Workflow

### Step 1: Resolve Both Usernames (parallel)

**API Calls** (make both in parallel):
- `GET /v2/user/by-username/{usernameA}`
- `GET /v2/user/by-username/{usernameB}`

```bash
# User A
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/user/by-username/{usernameA}"

# User B
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/user/by-username/{usernameB}"
```

**Extract**: `rest_id`, `name`, `screen_name`, `description`, `followers_count`, `friends_count`, `statuses_count`, `verified` for both users

### Step 2: Get Both Account Info (parallel)

**API Calls** (make both in parallel):
- `GET /v2/user/about/{usernameA}`
- `GET /v2/user/about/{usernameB}`

```bash
# User A
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/user/about/{usernameA}"

# User B
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/user/about/{usernameB}"
```

**Extract**: Account creation dates, verification status, professional category

### Step 3: Get Both Users' Recent Tweets (parallel, 20 each)

**API Calls** (make both in parallel):
- `GET /v2/user/{restIdA}/tweets?count=20`
- `GET /v2/user/{restIdB}/tweets?count=20`

```bash
# User A tweets
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/user/{restIdA}/tweets?count=20"

# User B tweets
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/user/{restIdB}/tweets?count=20"
```

**Extract**: Tweet content, timestamps, engagement metrics for both users

### Step 4: Get Both Follower Samples (parallel, 20 each)

**API Calls** (make both in parallel):
- `GET /v2/user/{restIdA}/followers?count=20`
- `GET /v2/user/{restIdB}/followers?count=20`

```bash
# User A followers
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/user/{restIdA}/followers?count=20"

# User B followers
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/user/{restIdB}/followers?count=20"
```

**Extract**: Follower profiles, follower counts, verification status

## Analysis Logic

### Profile Comparison
- Side-by-side comparison of all basic metrics
- Calculate followers/following ratio for both
- Compare account ages and growth trajectory

### Content Strategy Comparison
- Compare posting frequency (tweets per day/week)
- Compare content types (original vs replies vs retweets)
- Compare media usage patterns
- Identify overlapping vs distinct topics/hashtags
- Compare tweet length and style

### Engagement Comparison
- Calculate avg likes, retweets, replies per tweet for both
- Calculate engagement rate for both: (avg engagement / followers) * 100
- Compare engagement-per-follower efficiency
- Identify which user gets more proportional engagement

### Audience Comparison
- Compare average follower quality (follower counts of their followers)
- Compare verified follower percentages
- Look for any shared followers in the samples
- Assess audience authenticity for both

## Output Format

```markdown
# User Comparison: @{usernameA} vs @{usernameB}

## Profile Overview

| Metric | @{usernameA} | @{usernameB} | Winner |
|--------|-------------|-------------|--------|
| Followers | {count} | {count} | {who} |
| Following | {count} | {count} | — |
| Tweets | {count} | {count} | — |
| F/F Ratio | {ratio} | {ratio} | {who} |
| Account Age | {age} | {age} | — |
| Verified | {yes/no} | {yes/no} | — |

## Content Strategy

| Aspect | @{usernameA} | @{usernameB} |
|--------|-------------|-------------|
| Posts/Week | {freq} | {freq} |
| Original Content % | {pct} | {pct} |
| Replies % | {pct} | {pct} |
| Media Usage % | {pct} | {pct} |
| Top Topics | {topics} | {topics} |

## Engagement

| Metric | @{usernameA} | @{usernameB} | Winner |
|--------|-------------|-------------|--------|
| Avg Likes | {avg} | {avg} | {who} |
| Avg Retweets | {avg} | {avg} | {who} |
| Avg Replies | {avg} | {avg} | {who} |
| Engagement Rate | {rate}% | {rate}% | {who} |

## Audience Quality

| Metric | @{usernameA} | @{usernameB} |
|--------|-------------|-------------|
| Avg Follower Size | {avg} | {avg} |
| Verified Followers % | {pct} | {pct} |
| Bio Completeness % | {pct} | {pct} |
| Audience Authenticity | {score} | {score} |

## Shared Followers
{list any followers found in both samples, or "No overlap detected in sample"}

## Summary & Key Differences
- {Difference 1: e.g., "@A has 10x more followers but @B has higher engagement rate"}
- {Difference 2: e.g., "@A focuses on tech content while @B covers finance"}
- {Difference 3: e.g., "@B has better follower quality despite smaller audience"}
- **Overall**: {summary assessment}
```

## Error Handling

- If either user is not found in Step 1: Report "User @{username} not found" and stop entirely
- If Step 2 fails for one user: Continue without that user's account details
- If Step 3 fails for one user: Skip content/engagement comparison; note which user's data is missing
- If Step 4 fails for one user: Skip audience comparison for that user
- If both Step 3 calls fail: Report basic profile comparison only
- Always produce a comparison with whatever data was successfully retrieved for both users

## Example Usage

- "对比用户 @elonmusk @BillGates"
- "compare @naval and @paulg"
- "compare users jack dorsey"
- "who is more influential, @sama or @elonmusk"
