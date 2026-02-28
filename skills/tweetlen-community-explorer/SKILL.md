---
name: tweetlen-community-explorer
description: "Deep exploration of Twitter/X Communities. Analyzes community structure, members, moderators, and content. Trigger: 探索社区, explore community, community analysis"
---

## Prerequisites

- Tweetlen API Key required. Get one at [api.tweetlen.com](https://api.tweetlen.com)
- Run `setup.sh` or add `TWEETLEN_API_KEY` to `~/.claude/settings.json` under `env`

## Workflow

There are two entry paths depending on how the user identifies the community.

### Path A: Search by Keyword

#### Step A1: Search Communities

**API Call**: `GET /v2/community/search?query=KEYWORD&count=10`

```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/community/search?query=KEYWORD&count=10"
```

**Extract**: Community IDs, names, descriptions, member counts. Present results to user or automatically select the most relevant match. Then proceed to Step 2.

### Path B: Browse by Topic

#### Step B1: Get Community Topics

**API Call**: `GET /v2/community/topics`

```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/community/topics"
```

**Extract**: Available topic categories and their IDs.

#### Step B2: Get Popular Communities for Topic

**API Call**: `GET /v2/community/popular?topicId=TOPIC_ID&count=10`

```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/community/popular?topicId=TOPIC_ID&count=10"
```

**Extract**: Top communities in the selected topic. Select the most relevant or present options to user. Then proceed to Step 2.

### Path C: Direct Community ID

If the user provides a community ID directly, skip to Step 2.

---

### Step 2: Get Community Details

**API Call**: `GET /v2/community/:communityId`

```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/community/COMMUNITY_ID"
```

**Extract**: Community name, description, member count, creation date, rules, visibility settings.

### Step 3: Get Community About

**API Call**: `GET /v2/community/:communityId/about`

```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/community/COMMUNITY_ID/about"
```

**Extract**: Extended community information, rules, guidelines, and additional metadata not included in the basic details endpoint.

### Step 4: Get Community Members

**API Call**: `GET /v2/community/:communityId/members?cursor=`

```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/community/COMMUNITY_ID/members?cursor="
```

**Extract**: First 20 members with their profiles, follower counts, bios. Provides a representative sample of the community membership.

### Step 5: Get Community Moderators

**API Call**: `GET /v2/community/:communityId/moderators`

```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/community/COMMUNITY_ID/moderators"
```

**Extract**: Moderator usernames, roles, follower counts, bios. Understanding leadership helps assess community quality and direction.

### Step 6: Get Community Tweets

**API Call**: `GET /v2/community/:communityId/tweets?searchType=Default&count=20&rankingMode=Relevance`

```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/community/COMMUNITY_ID/tweets?searchType=Default&count=20&rankingMode=Relevance"
```

**Extract**: Recent community posts with engagement metrics, content themes, media types, posting frequency indicators.

## User Parameters

- **Community keyword** (option A): Search term to find communities.
- **Community ID** (option C): Direct community ID if known.
- **Topic** (option B): Browse communities by topic category.

## Analysis Logic

1. **Community Profile**: Combine details and about info into a comprehensive overview, including rules and guidelines.
2. **Leadership Assessment**: Analyze moderator profiles — their follower counts, activity levels, and areas of expertise indicate community governance quality.
3. **Member Demographics**: From the member sample, calculate average/median follower counts, identify common bio themes, note verified account presence.
4. **Content Analysis**: Categorize community tweets by topic, media type, and engagement level. Calculate average engagement per post.
5. **Activity Assessment**: Based on tweet timestamps, estimate posting frequency. Active communities have multiple posts per day.
6. **Health Indicators**: Combine engagement ratios (likes+RTs per member count), posting frequency, and moderator activity into an overall community health assessment.

## Output Format

Generate a Markdown report with the following sections:

```markdown
# Community Explorer Report: [Community Name]

**Generated**: [date]
**Community ID**: [id]

## Community Overview

- **Name**: [name]
- **Description**: [description]
- **Members**: [count]
- **Created**: [date if available]
- **Visibility**: [public/private]

### Rules & Guidelines
[Community rules listed here]

## Leadership

| Moderator | Role | Followers | Bio |
|-----------|------|-----------|-----|
| @mod1     | Admin | X        | ... |
| @mod2     | Mod   | X        | ... |

Leadership assessment and observations.

## Member Analysis

**Sample size**: 20 members

- **Average followers**: X
- **Median followers**: X
- **Verified accounts**: X of 20
- **Common bio themes**: [themes]

Notable members in the sample.

## Content Analysis

**Posts analyzed**: 20

### Topic Distribution
- Topic A: X posts
- Topic B: X posts

### Engagement Metrics
- **Average likes per post**: X
- **Average retweets per post**: X
- **Average replies per post**: X
- **Most engaged post**: "..." by @user (X likes)

### Content Types
- Text only: X%
- With images: X%
- With links: X%
- With video: X%

## Community Health Indicators

| Indicator | Rating | Notes |
|-----------|--------|-------|
| Activity Level | High/Medium/Low | Based on posting frequency |
| Engagement Ratio | High/Medium/Low | Engagement relative to member count |
| Content Quality | High/Medium/Low | Based on content analysis |
| Moderation | Active/Moderate/Minimal | Based on moderator presence |

## Similar Communities

[If searched by keyword, list other communities found in Step A1]

## Summary

- Key finding 1
- Key finding 2
- Key finding 3
- Recommendation for whether to join/follow this community
```

## Error Handling

- If Step A1/B1/B2 (search/browse) fails: Ask user to provide a community ID directly.
- If Step 2 (details) fails: Report that the community may not exist or is private. Cannot proceed without basic details.
- If Step 3 (about) fails: Continue without extended info. Use details from Step 2 only.
- If Step 4 (members) fails: Skip member analysis section. Note in report.
- If Step 5 (moderators) fails: Skip leadership section. Note in report.
- If Step 6 (tweets) fails: Skip content analysis section. Note in report.
- If community is private or restricted: Report this to the user and note which data was accessible.

## Example Usage

- "探索社区: AI"
- "explore community machine learning"
- "community analysis for community ID 1234567890"
- "按话题浏览社区"
- "分析一下 Web3 相关的社区"
