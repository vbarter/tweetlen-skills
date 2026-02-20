---
name: tweetlen-topic-research
description: "Topic sentiment research on Twitter/X. Searches for a topic, analyzes sentiment, identifies key voices and themes. Trigger: 话题研究, topic research, what's Twitter saying about, sentiment analysis"
---

## Prerequisites

- Tweetlen API Key required. Get one at [api.tweetlen.com](https://api.tweetlen.com)
- Set env var: `TWEETLEN_API_KEY=twtl_your_key_here`

## Workflow

### Step 1: Search Topic (Latest)

Retrieve recent discussion around the topic to capture the freshest conversation.

**API Call**: `GET /v2/search/v3?query=TOPIC&type=Latest&count=20`

```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/search/v3?query=TOPIC&type=Latest&count=20"
```

**Extract**: Tweet text, author info, engagement metrics (likes, retweets, replies), timestamps. These represent the most recent posts discussing the topic.

### Step 2: Search Topic (Top)

Retrieve the most popular and engaged posts on the topic.

**API Call**: `GET /v2/search/v3?query=TOPIC&type=Top&count=20`

```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/search/v3?query=TOPIC&type=Top&count=20"
```

**Extract**: High-engagement tweets, viral content, key narratives. Compare with Latest results to identify which themes resonate most.

### Step 3: Search Topic (People)

Identify key voices and accounts actively discussing the topic.

**API Call**: `GET /v2/search/v3?query=TOPIC&type=People&count=20`

```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/search/v3?query=TOPIC&type=People&count=20"
```

**Extract**: Account names, bios, follower counts, verification status. These are the most relevant accounts associated with the topic.

### Step 4: Get Comments on Top Tweets

For the top 3 most influential tweets (by engagement), retrieve comment threads to understand deeper conversation dynamics.

**API Call**: `GET /v2/tweet/:tweetId/comments/v2?count=20`

```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/tweet/TWEET_ID/comments/v2?count=20"
```

Repeat for each of the top 3 tweets identified in Step 2.

**Extract**: Reply content, sentiment in replies, counter-arguments, additional context provided by commenters.

## User Parameters

- **Topic/keyword** (required): The subject to research. Passed as the `query` parameter.
- **Language filter** (optional): Append to query, e.g., `"AI regulation lang:en"` to restrict to English tweets.
- **Date range** (optional): Append to query, e.g., `"AI regulation since:2026-01-01 until:2026-02-01"` to restrict timeframe.

## Analysis Logic

1. **Sentiment Classification**: Analyze each tweet's text content and classify as positive, negative, or neutral. Count distribution across all collected tweets.
2. **Theme Clustering**: Group tweets by common subtopics, keywords, or narratives. Identify 3-5 major themes.
3. **Influence Scoring**: Rank accounts by follower count, engagement on their topic-related tweets, and verification status.
4. **Timeline Mapping**: Order tweets chronologically to identify how the conversation evolved (if date range is sufficient).
5. **Engagement Analysis**: Calculate average likes, retweets, and replies. Identify outlier posts with unusually high engagement.

## Output Format

Generate a Markdown report with the following sections:

```markdown
# Topic Research Report: [TOPIC]

**Generated**: [date]
**Query**: [exact search query used]
**Data collected**: [number of tweets analyzed]

## Topic Overview

Brief summary of the topic's presence on Twitter/X. Indicator of discussion volume based on engagement metrics observed.

## Sentiment Distribution

| Sentiment | Count | Percentage | Example |
|-----------|-------|------------|---------|
| Positive  | X     | X%         | "..."   |
| Negative  | X     | X%         | "..."   |
| Neutral   | X     | X%         | "..."   |

Key sentiment observations and any notable patterns.

## Key Themes & Subtopics

### Theme 1: [Name]
- Description and representative tweets
- Sentiment within this theme

### Theme 2: [Name]
...

## Key Voices

| Account | Followers | Stance | Notable Tweet |
|---------|-----------|--------|---------------|
| @user   | X         | ...    | "..."         |

## Timeline Analysis

How the discussion evolved over the observed period. Key moments or shifts in conversation.

## Top Tweets

### 1. @user — [likes] likes, [retweets] RTs
> Tweet content

### 2. ...

## Comment Highlights

Notable replies and discussion threads from the top tweets. Counter-arguments, additional context, and community reactions.

## Summary & Insights

- Key takeaway 1
- Key takeaway 2
- Key takeaway 3
- Recommended follow-up research areas
```

## Error Handling

- If Step 1 (Latest search) fails: Continue with Top and People searches. Note limited recency data in report.
- If Step 2 (Top search) fails: Use Latest results for engagement analysis. Skip comment retrieval or use top tweets from Latest instead.
- If Step 3 (People search) fails: Derive key voices from tweet authors in Steps 1-2.
- If Step 4 (Comments) fails for a tweet: Skip that tweet's comment section, note in report. Continue with remaining tweets.
- If no results found: Report that the topic has limited Twitter/X presence. Suggest alternative keywords or broader queries.

## Example Usage

- "话题研究: AI 监管"
- "topic research: climate change policy"
- "what's Twitter saying about Apple Vision Pro"
- "sentiment analysis on remote work lang:en since:2026-01-01"
- "研究一下大家对 GPT-5 的看法"
