---
name: tweetlen-tweet-analysis
description: "Deep tweet engagement analysis. Analyzes comments, retweets, quotes, and sentiment for a specific tweet. Trigger: 分析推文, analyze tweet, tweet engagement, tweet analysis"
---

## Prerequisites

- Tweetlen API Key required. Get one at [api.tweetlen.com](https://api.tweetlen.com)
- Set env var: `TWEETLEN_API_KEY=twtl_your_key_here`

## Input Parsing

Accept either format:
- **Tweet URL**: `https://x.com/user/status/1234567890` or `https://twitter.com/user/status/1234567890` -- extract the numeric ID from the URL path
- **Tweet ID**: `1234567890` -- use directly

Parse logic: If input contains "status/", extract the number after "status/". Otherwise treat the input as a tweet ID directly.

## Workflow

### Step 1: Get Tweet Details

**API Call**: `GET /v2/tweet/:tweetId/v2`

```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/tweet/{tweetId}/v2"
```

**Extract**: Author info, full tweet text, created_at, like_count, retweet_count, reply_count, quote_count, bookmark_count, view_count, media attachments

### Step 2: Get Comments (20)

**API Call**: `GET /v2/tweet/:tweetId/comments/v2?count=20&rankingMode=Relevance`

```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/tweet/{tweetId}/comments/v2?count=20&rankingMode=Relevance"
```

**Extract**: Comment text, author info, like counts, timestamps

### Step 3: Get Retweets (20)

**API Call**: `GET /v2/tweet/:tweetId/retweets?count=20`

```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/tweet/{tweetId}/retweets?count=20"
```

**Extract**: Retweeter profiles, follower counts, verification status

### Step 4: Get Quotes (20)

**API Call**: `GET /v2/tweet/:tweetId/quotes?count=20`

```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/tweet/{tweetId}/quotes?count=20"
```

**Extract**: Quote tweet text, author info, engagement on quotes

## Analysis Logic

### Engagement Breakdown
- Calculate ratios: likes-to-retweets, replies-to-likes, quotes-to-retweets
- Compare view count to engagement for engagement-per-view rate
- Assess if engagement distribution is healthy (balanced likes/replies/RTs)

### Comment Sentiment Analysis
- Classify comments as positive, negative, or neutral based on content
- Identify common themes and topics in replies
- Find the most-liked comments (community-endorsed perspectives)
- Note any controversial or polarizing discussion threads

### Amplification Analysis
- Total reach of retweeters (sum of their follower counts)
- Average influence of retweeters (avg follower count)
- Percentage of verified retweeters
- Identify most influential retweeters

### Quote Analysis
- Classify quotes as supportive (agreeing/amplifying) vs critical (disagreeing/mocking)
- Identify if quotes are adding context, commentary, or criticism
- Note any quote tweets that went viral on their own

### Viral Potential Assessment
- Engagement velocity (engagement relative to time since posting)
- View-to-engagement conversion rate
- Quality of amplifiers (influential retweeters/quoters)
- Discussion depth (are people having conversations in replies?)

## Output Format

```markdown
# Tweet Analysis: {tweetId}

## Tweet Overview
- **Author**: @{screen_name} ({name})
- **Posted**: {created_at}
- **Content**: {full tweet text}
- **Media**: {description of any attached media}

## Engagement Breakdown
| Metric | Count |
|--------|-------|
| Views | {view_count} |
| Likes | {like_count} |
| Retweets | {retweet_count} |
| Quotes | {quote_count} |
| Replies | {reply_count} |
| Bookmarks | {bookmark_count} |

| Ratio | Value |
|-------|-------|
| Engagement Rate (per view) | {rate}% |
| Like-to-RT Ratio | {ratio} |
| Reply-to-Like Ratio | {ratio} |

## Comment Analysis
- **Sentiment Distribution**: {X}% positive, {Y}% neutral, {Z}% negative
- **Key Themes**: {theme1}, {theme2}, {theme3}

### Top Comments
1. @{user}: "{comment}" ({likes} likes)
2. @{user}: "{comment}" ({likes} likes)
3. @{user}: "{comment}" ({likes} likes)

## Amplification Analysis
- **Total Retweeter Reach**: ~{sum of follower counts}
- **Average Retweeter Influence**: {avg followers}
- **Verified Retweeters**: {count}

### Most Influential Retweeters
1. @{user} ({followers} followers)
2. @{user} ({followers} followers)
3. @{user} ({followers} followers)

## Quote Analysis
- **Supportive Quotes**: {count} ({percentage}%)
- **Critical Quotes**: {count} ({percentage}%)
- **Neutral/Commentary**: {count} ({percentage}%)

### Notable Quotes
1. @{user}: "{quote text}" ({likes} likes)
2. @{user}: "{quote text}" ({likes} likes)

## Viral Potential Assessment
- **Engagement Velocity**: {assessment}
- **View Conversion**: {rate}%
- **Amplifier Quality**: {high/medium/low}
- **Discussion Depth**: {high/medium/low}
- **Overall Viral Score**: {score}/10
```

## Error Handling

- If Step 1 fails (tweet not found): Report "Tweet {tweetId} not found or unavailable" and stop
- If Step 2 fails: Skip comment analysis; note "Comment data unavailable"
- If Step 3 fails: Skip amplification analysis; note "Retweet data unavailable"
- If Step 4 fails: Skip quote analysis; note "Quote data unavailable"
- If tweet URL parsing fails: Ask user to provide the numeric tweet ID directly
- Always produce a report with whatever data was successfully retrieved

## Example Usage

- "分析推文 https://x.com/elonmusk/status/1234567890"
- "analyze tweet 1234567890"
- "tweet engagement https://twitter.com/naval/status/9876543210"
- "这条推文的反响如何 1234567890"
