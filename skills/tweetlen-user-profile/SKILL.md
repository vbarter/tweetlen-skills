---
name: tweetlen-user-profile
description: "Comprehensive Twitter/X user profile analysis. Combines user info, recent tweets, follower analysis, and engagement metrics into a detailed report. Trigger: 分析用户, analyze user, user profile, who is @xxx"
---

## Prerequisites

- Tweetlen API Key required. Get one at [api.tweetlen.com](https://api.tweetlen.com)
- Set env var: `TWEETLEN_API_KEY=twtl_your_key_here`

## Workflow

### Step 1: Resolve Username

**API Call**: `GET /v2/user/by-username/:username`

```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/user/by-username/{username}"
```

**Extract**: `rest_id`, `name`, `screen_name`, `description`, `followers_count`, `friends_count`, `statuses_count`, `profile_image_url`, `verified`

### Step 2: Get Account Info

**API Call**: `GET /v2/user/about/:username`

```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/user/about/{username}"
```

**Extract**: Account creation date, verification status, professional category, highlights info

### Step 3: Get Recent Tweets (20)

**API Call**: `GET /v2/user/:userId/tweets?count=20`

```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/user/{rest_id}/tweets?count=20"
```

**Extract**: Tweet content, timestamps, like_count, retweet_count, reply_count, media types, hashtags

### Step 4: Get Followers Sample (20)

**API Call**: `GET /v2/user/:userId/followers?count=20`

```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/user/{rest_id}/followers?count=20"
```

**Extract**: Follower profiles, their follower counts, verification status, bios

### Step 5: Get Verified Followers (20)

**API Call**: `GET /v2/user/:userId/verified-followers?count=20`

```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/user/{rest_id}/verified-followers?count=20"
```

**Extract**: Notable verified accounts following this user

## Analysis Logic

### Content Analysis
- Calculate posting frequency from tweet timestamps (tweets per day/week)
- Identify common topics by analyzing tweet text for recurring keywords and hashtags
- Categorize media usage: text-only vs image vs video vs link shares
- Identify if tweets are mostly original content, replies, or retweets

### Engagement Metrics
- Calculate average likes, retweets, and replies per tweet
- Compute engagement rate: (avg likes + avg retweets + avg replies) / followers_count * 100
- Identify top-performing tweets by total engagement

### Follower Quality Assessment
- Average follower count of sampled followers
- Percentage of verified followers in sample
- Bio completeness rate (followers with non-empty bios)
- Assess follower authenticity (look for patterns of bot-like profiles)

## Output Format

```markdown
# User Profile Analysis: @{username}

## Basic Profile
| Field | Value |
|-------|-------|
| Name | {name} |
| Bio | {description} |
| Location | {location} |
| Followers | {followers_count} |
| Following | {friends_count} |
| Tweets | {statuses_count} |
| Account Age | {calculated from creation date} |
| Followers/Following Ratio | {ratio} |
| Verified | {yes/no} |

## Content Analysis
- **Posting Frequency**: ~{N} tweets per day/week
- **Content Mix**: {X}% original, {Y}% replies, {Z}% retweets
- **Media Usage**: {X}% text-only, {Y}% with images, {Z}% with video
- **Common Topics**: {topic1}, {topic2}, {topic3}
- **Hashtag Usage**: {hashtag1}, {hashtag2} (if any)

## Engagement Metrics
| Metric | Average | Best |
|--------|---------|------|
| Likes | {avg} | {max} |
| Retweets | {avg} | {max} |
| Replies | {avg} | {max} |
| Engagement Rate | {rate}% | — |

### Top Performing Tweets
1. "{tweet text truncated}" - {likes} likes, {retweets} RTs
2. "{tweet text truncated}" - {likes} likes, {retweets} RTs
3. "{tweet text truncated}" - {likes} likes, {retweets} RTs

## Follower Quality
- **Average Follower Size**: {avg followers of followers}
- **Verified Followers**: {count} notable accounts
- **Notable Followers**: {list of verified/high-profile followers}
- **Follower Authenticity**: {assessment}

## Key Observations & Insights
- {Insight 1: e.g., "High engagement rate suggests authentic audience"}
- {Insight 2: e.g., "Content heavily focused on tech topics"}
- {Insight 3: e.g., "Strong verified follower base in crypto space"}
```

## Error Handling

- If Step 1 fails (user not found): Report "User @{username} not found" and stop
- If Step 2 fails: Continue without account creation date details; note "Account details unavailable"
- If Step 3 fails: Skip content and engagement analysis; note "Tweet data unavailable"
- If Step 4 fails: Skip follower quality assessment; note "Follower data unavailable"
- If Step 5 fails: Skip verified followers section; note "Verified follower data unavailable"
- Always produce a report with whatever data was successfully retrieved

## Example Usage

- "分析用户 @elonmusk"
- "analyze user elonmusk"
- "who is @naval"
- "user profile jack"
