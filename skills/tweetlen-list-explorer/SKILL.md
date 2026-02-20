---
name: tweetlen-list-explorer
description: "Explore and analyze Twitter/X Lists. Find lists, analyze members, and review list content. Trigger: 探索列表, explore list, list analysis"
---

## Prerequisites

- Tweetlen API Key required. Get one at [api.tweetlen.com](https://api.tweetlen.com)
- Set env var: `TWEETLEN_API_KEY=twtl_your_key_here`

## Workflow

### Step 1: Search or Identify List

Either search for lists by keyword or use a provided list ID directly.

**API Call**: `GET /v2/list/search?query=KEYWORD`

```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/list/search?query=KEYWORD"
```

**Extract**: List IDs, names, descriptions, member counts, follower counts. Select the most relevant list or present options to user. If user provided a list ID directly, skip to Step 2.

### Step 2: Get List Details

**API Call**: `GET /v2/list/:listId`

```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/list/LIST_ID"
```

**Extract**: List name, description, creator profile, member count, follower count, creation date, visibility (public/private).

### Step 3: Get List Members

**API Call**: `GET /v2/list/:listId/members?count=20`

```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/list/LIST_ID/members?count=20"
```

**Extract**: Member profiles including usernames, display names, bios, follower counts, verification status. First 20 members provide a representative sample of the list's curation.

### Step 4: Get List Timeline

**API Call**: `GET /v2/list/:listId/timeline`

```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/list/LIST_ID/timeline"
```

**Extract**: Recent tweets from list members. Analyze content themes, posting frequency, engagement levels across the list's aggregated feed.

### Step 5: Get List Followers

**API Call**: `GET /v2/list/:listId/followers?count=20`

```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/list/LIST_ID/followers?count=20"
```

**Extract**: Profiles of users who follow this list. Understanding the audience reveals the list's perceived value and use case.

## User Parameters

- **List keyword** (option A): Search term to find relevant lists.
- **List ID** (option B): Direct list ID if known.

## Analysis Logic

1. **List Profile**: Combine details into a comprehensive overview including creator credibility (follower count, verification).
2. **Curation Quality**: Assess how well-curated the list is based on member consistency — do members share common themes, industries, or expertise areas?
3. **Member Analysis**: Calculate average/median follower counts, identify notable or verified members, find common bio keywords and themes.
4. **Content Value**: Analyze timeline content for topic diversity, posting frequency, and engagement levels. A valuable list produces a focused, active feed.
5. **Audience Insight**: From list followers, determine who finds this list valuable and why. High follower-to-member ratios suggest strong curation.
6. **Activity Assessment**: Based on timeline data, determine how active the list feed is and whether content is recent and relevant.

## Output Format

Generate a Markdown report with the following sections:

```markdown
# List Explorer Report: [List Name]

**Generated**: [date]
**List ID**: [id]

## List Overview

- **Name**: [name]
- **Description**: [description]
- **Creator**: @[username] ([follower count] followers)
- **Members**: [count]
- **Followers**: [count]
- **Follower-to-Member Ratio**: [ratio]
- **Created**: [date if available]
- **Visibility**: [public/private]

## Member Analysis

**Sample size**: 20 members

### Notable Members
| Member | Followers | Verified | Bio |
|--------|-----------|----------|-----|
| @user1 | X         | Yes/No   | ... |
| @user2 | X         | Yes/No   | ... |

### Member Statistics
- **Average followers**: X
- **Median followers**: X
- **Verified accounts**: X of 20
- **Follower range**: [min] — [max]

### Common Themes
- Theme 1: X members (bio keywords, industry)
- Theme 2: X members
- Theme 3: X members

## Content Analysis

### Recent Timeline Activity
- **Posts in sample**: X
- **Average engagement per post**: X likes, X RTs
- **Most active member**: @user (X posts in sample)

### Popular Topics
- Topic A: X posts
- Topic B: X posts

### Top Posts from Timeline
1. @user: "..." (X likes, X RTs)
2. @user: "..." (X likes, X RTs)

## List Quality Assessment

| Dimension | Rating | Notes |
|-----------|--------|-------|
| Curation Quality | High/Medium/Low | How focused and consistent the member selection is |
| Content Activity | High/Medium/Low | How active the timeline feed is |
| Member Quality | High/Medium/Low | Caliber and relevance of included accounts |
| Engagement Level | High/Medium/Low | Interaction levels in the list feed |

**Overall Assessment**: [Brief qualitative summary]

## Follower Interest

**Sample size**: 20 followers

### Who Follows This List
- **Average follower count of list followers**: X
- **Common interests**: [themes from follower bios]
- **Use case**: Why people follow this list (inferred from follower profiles and list content)

### Notable Followers
| Follower | Followers | Bio |
|----------|-----------|-----|
| @user1   | X         | ... |
| @user2   | X         | ... |

## Similar Lists

[If searched by keyword, list other relevant lists found in Step 1]

## Summary

- Key finding 1
- Key finding 2
- Key finding 3
- Recommendation on whether this list is worth following
```

## Error Handling

- If Step 1 (search) fails: Ask user to provide a list ID directly.
- If Step 2 (details) fails: Report that the list may not exist, may be private, or the ID is invalid. Cannot proceed without basic details.
- If Step 3 (members) fails: Skip member analysis section. Note that member data was unavailable.
- If Step 4 (timeline) fails: Skip content analysis section. Note in report.
- If Step 5 (followers) fails: Skip follower interest section. Note in report.
- If list is private: Report this to the user. Private lists may return limited or no data.
- If no lists found for keyword: Suggest alternative keywords or ask for a direct list ID.

## Example Usage

- "探索列表: AI researchers"
- "explore list machine learning"
- "list analysis for list ID 1234567890"
- "找一下关于加密货币的列表"
- "analyze the best tech journalist lists"
