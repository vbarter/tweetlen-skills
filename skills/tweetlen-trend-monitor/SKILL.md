---
name: tweetlen-trend-monitor
description: "Monitor trending topics on Twitter/X by region. Shows current trends with context. Trigger: 热门趋势, trending topics, what's trending, trend monitor"
---

## Prerequisites

- Tweetlen API Key required. Get one at [api.tweetlen.com](https://api.tweetlen.com)
- Run `setup.sh` or add `TWEETLEN_API_KEY` to `~/.claude/settings.json` under `env`

## Workflow

### Step 1: Get Available Locations (Optional)

Only needed if the user doesn't specify a region. Retrieves all available trend locations with their WOEID codes.

**API Call**: `GET /v2/trends/locations`

```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/trends/locations"
```

**Extract**: Location names and WOEID values. Present options to user if they haven't specified a region.

**Common WOEIDs** (use these directly when user specifies a known region):

| Region | WOEID |
|--------|-------|
| Worldwide | 1 |
| United States | 23424977 |
| United Kingdom | 23424975 |
| Japan | 23424856 |
| India | 23424848 |
| Brazil | 23424768 |
| France | 23424819 |
| Germany | 23424829 |
| Australia | 23424748 |
| Canada | 23424775 |
| Singapore | 23424948 |

### Step 2: Get Trends for Location

Retrieve current trending topics for the selected region.

**API Call**: `GET /v2/trends/by-location/:woeid`

```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/trends/by-location/WOEID"
```

**Extract**: Trend names, tweet volumes (if available), promoted status. Rank by position in the trends list.

### Step 3: Deep Dive on Top 5 Trends

For each of the top 5 trending topics, search for representative tweets to provide context.

**API Call**: `GET /v2/search/v3?query=TREND&type=Top&count=5`

```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/search/v3?query=TREND_NAME&type=Top&count=5"
```

Repeat for each of the top 5 trends.

**Extract**: Sample tweets showing what people are saying, engagement metrics, sentiment indicators. This provides context for why each topic is trending.

## User Parameters

- **Region/Location** (optional): Country or city name, or WOEID directly. Defaults to Worldwide (WOEID 1) if not specified.
- **Number of trends to deep-dive** (optional): Defaults to top 5.

## Analysis Logic

1. **Trend Ranking**: Order trends by their position in the API response (already ranked by Twitter's algorithm). Note tweet volume where available.
2. **Context Extraction**: For each top trend, analyze sample tweets to determine why it's trending (news event, meme, product launch, political event, etc.).
3. **Sentiment Read**: Classify the general sentiment around each top trend based on sample tweets.
4. **Cross-trend Analysis**: Identify relationships between trending topics. Look for overarching themes (e.g., multiple trends related to the same news event).
5. **Category Classification**: Tag each trend with a category (Politics, Entertainment, Sports, Technology, Business, Culture, etc.).

## Output Format

Generate a Markdown report with the following sections:

```markdown
# Trending Topics Report

**Region**: [Location Name]
**WOEID**: [code]
**Timestamp**: [current date/time]

## Trending Topics Overview

| Rank | Topic | Tweet Volume | Category |
|------|-------|-------------|----------|
| 1    | #Topic1 | 125K      | Tech     |
| 2    | #Topic2 | 98K       | Politics |
| ...  | ...     | ...       | ...      |

## Top 5 Trends — Deep Dive

### 1. #Topic1

**Category**: Technology
**Tweet Volume**: 125K
**Sentiment**: Mostly positive

**Why it's trending**: Brief explanation based on sample tweets.

**Sample Tweets**:
- @user1: "..." (X likes, X RTs)
- @user2: "..." (X likes, X RTs)

---

### 2. #Topic2
...

## Cross-trend Analysis

Relationships and overarching themes connecting multiple trends. Common narratives or events driving multiple topics simultaneously.

## Summary

- Key observation 1
- Key observation 2
- Notable patterns or surprises
```

## Error Handling

- If Step 1 (locations) fails: Use default WOEID list provided above. Ask user to pick from common regions.
- If Step 2 (trends) fails: Report API error. Suggest trying a different region or retrying later.
- If Step 3 (search for a trend) fails: Skip that trend's deep dive. Note in report that context was unavailable for that trend. Continue with remaining trends.
- If no trends returned: Report that no trending data is available for the selected region. Suggest trying Worldwide (WOEID 1).

## Example Usage

- "热门趋势"
- "what's trending in the US"
- "trending topics in Japan"
- "trend monitor worldwide"
- "看看新加坡现在什么话题在火"
