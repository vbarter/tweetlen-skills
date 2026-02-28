---
name: tweetlen-influence-report
description: "KOL influence assessment report. Evaluates a user's influence through followers, engagement, and content reach. Trigger: 影响力报告, influence report, KOL analysis"
---

## Prerequisites

- Tweetlen API Key required. Get one at [api.tweetlen.com](https://api.tweetlen.com)
- Run `setup.sh` or add `TWEETLEN_API_KEY` to `~/.claude/settings.json` under `env`

## Workflow

### Step 1: Resolve Username

**API Call**: `GET /v2/user/by-username/:username`

```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/user/by-username/{username}"
```

**Extract**: `rest_id`, `name`, `screen_name`, `description`, `followers_count`, `friends_count`, `statuses_count`, `verified`

### Step 2: Get Account Info

**API Call**: `GET /v2/user/about/:username`

```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/user/about/{username}"
```

**Extract**: Account creation date, verification status, professional category, description

### Step 3: Get Recent Tweets (20)

**API Call**: `GET /v2/user/:userId/tweets?count=20`

```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/user/{rest_id}/tweets?count=20"
```

**Extract**: Tweet content, timestamps, like_count, retweet_count, reply_count, view_count

### Step 4: Get Verified Followers (20)

**API Call**: `GET /v2/user/:userId/verified-followers?count=20`

```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/user/{rest_id}/verified-followers?count=20"
```

**Extract**: Verified follower profiles, their follower counts, categories

### Step 5: Get Followers Sample (20)

**API Call**: `GET /v2/user/:userId/followers?count=20`

```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/user/{rest_id}/followers?count=20"
```

**Extract**: Follower profiles, follower counts, bio content, verification status

### Step 6: Get Highlights (20)

**API Call**: `GET /v2/user/:userId/highlights?count=20`

```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/user/{rest_id}/highlights?count=20"
```

**Extract**: Highlighted/pinned content, engagement on top posts

## Analysis Logic

### Influence Score Calculation (0-100)

Weighted scoring across multiple dimensions:

- **Reach Score** (30% weight): Based on followers count
  - < 1K: 10, 1K-10K: 25, 10K-100K: 50, 100K-1M: 75, 1M+: 90, 10M+: 100
- **Engagement Score** (30% weight): Based on engagement rate
  - Engagement rate = (avg likes + avg RTs + avg replies) / followers * 100
  - < 0.5%: 20, 0.5-1%: 40, 1-3%: 60, 3-6%: 80, 6%+: 100
- **Network Score** (20% weight): Based on verified followers and follower quality
  - Factors: count of verified followers, avg follower size of followers
- **Content Score** (20% weight): Based on posting consistency and content quality
  - Factors: posting frequency, engagement variance, highlight quality

Final Score = Reach * 0.3 + Engagement * 0.3 + Network * 0.2 + Content * 0.2

### Influence Tier Classification

| Tier | Followers | Typical Score |
|------|-----------|---------------|
| Nano | < 10K | 10-25 |
| Micro | 10K - 100K | 25-45 |
| Mid-tier | 100K - 500K | 45-65 |
| Macro | 500K - 1M | 65-80 |
| Mega | 1M+ | 80-100 |

Note: Tier is primarily based on followers but adjusted by engagement quality. A micro influencer with exceptional engagement may score higher than a macro influencer with low engagement.

### Reach Assessment
- Direct reach: followers count
- Estimated impressions per tweet: avg view_count from recent tweets
- Amplification potential: avg retweets * avg retweeter follower count (estimated)

### Engagement Quality
- Engagement rate compared to tier benchmarks
- Reply-to-like ratio (higher ratio = more discussion-generating)
- Consistency of engagement across tweets (low variance = reliable influence)

### Network Analysis
- Notable verified followers and their domains
- Average influence of followers (are followers themselves influential?)
- Network density indicators

## Output Format

```markdown
# Influence Report: @{username}

## Influence Score: {score}/100 | Tier: {tier}

### Score Breakdown
| Dimension | Score | Weight | Weighted |
|-----------|-------|--------|----------|
| Reach | {score}/100 | 30% | {weighted} |
| Engagement | {score}/100 | 30% | {weighted} |
| Network | {score}/100 | 20% | {weighted} |
| Content | {score}/100 | 20% | {weighted} |
| **Total** | | | **{total}/100** |

## Profile Summary
- **Name**: {name} (@{screen_name})
- **Bio**: {description}
- **Followers**: {followers_count}
- **Account Age**: {age}
- **Verified**: {yes/no}
- **Category**: {professional category if available}

## Reach Assessment
- **Direct Reach**: {followers_count} followers
- **Avg Impressions/Tweet**: ~{avg_views}
- **Impression Rate**: {views/followers}% of followers see each tweet
- **Estimated Monthly Reach**: ~{monthly impressions estimate}

## Engagement Quality
| Metric | Value | Tier Benchmark |
|--------|-------|----------------|
| Engagement Rate | {rate}% | {benchmark}% |
| Avg Likes | {avg} | — |
| Avg Retweets | {avg} | — |
| Avg Replies | {avg} | — |
| Engagement Consistency | {high/medium/low} | — |

### Top Performing Content
1. "{tweet text}" - {total engagement} total engagements
2. "{tweet text}" - {total engagement} total engagements
3. "{tweet text}" - {total engagement} total engagements

## Network Analysis
- **Verified Followers**: {count}
- **Avg Follower Influence**: {avg follower count of followers}

### Notable Connections
1. @{verified_user} ({followers} followers) - {bio snippet}
2. @{verified_user} ({followers} followers) - {bio snippet}
3. @{verified_user} ({followers} followers) - {bio snippet}

## Content Impact
- **Posting Frequency**: ~{freq} tweets/week
- **Primary Topics**: {topic1}, {topic2}, {topic3}
- **Content Style**: {original/curator/conversational}
- **Best Performing Topics**: {topics that get most engagement}

## Influence Tier: {tier}

{Description of what this tier means}

### Tier Comparison
| Metric | @{username} | {tier} Average |
|--------|-------------|----------------|
| Followers | {count} | {tier avg} |
| Engagement Rate | {rate}% | {tier avg}% |
| Verified Followers | {count} | {tier avg} |

## Recommendations
- {Rec 1: e.g., "Engagement rate is above tier average - leverage for brand partnerships"}
- {Rec 2: e.g., "Post more consistently to improve content score"}
- {Rec 3: e.g., "Strong in tech niche - consider cross-domain content to expand reach"}
```

## Error Handling

- If Step 1 fails (user not found): Report "User @{username} not found" and stop
- If Step 2 fails: Continue without detailed account info; estimate account age from earliest tweet
- If Step 3 fails: Cannot calculate engagement metrics; report reach-only score with disclaimer
- If Step 4 fails: Set network score to estimated value based on follower count; note "Verified follower data unavailable"
- If Step 5 fails: Skip follower quality analysis; note "Follower sample unavailable"
- If Step 6 fails: Skip highlights analysis; note "Highlights data unavailable"
- Always produce a report with whatever data was successfully retrieved; adjust influence score weights to exclude missing dimensions

## Example Usage

- "影响力报告 @elonmusk"
- "influence report naval"
- "KOL analysis @VitalikButerin"
- "评估 @sama 的影响力"
