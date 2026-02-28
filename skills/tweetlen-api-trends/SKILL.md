---
name: tweetlen-api-trends
description: "Twitter/X Trends API - Get available trend locations and trending topics by region. Trigger: get trends, 查趋势"
---

## Prerequisites

- Tweetlen API Key required. Get one at [api.tweetlen.com](https://api.tweetlen.com)
- Run `setup.sh` or add `TWEETLEN_API_KEY` to `~/.claude/settings.json` under `env`

## API Base Info

- **Base URL**: `https://api.tweetlen.com/v2`
- **Auth**: `Authorization: Bearer $TWEETLEN_API_KEY`
- **Method**: All endpoints use HTTP GET

## Endpoints

### 1. Get Trend Locations

Fetch all available locations (WOEIDs) for which trending topics are available.

- **Path**: `GET /v2/trends/locations`
- **Parameters**: None
- **Example**:
```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/trends/locations"
```

### 2. Get Trends by Location

Fetch currently trending topics for a specific location identified by WOEID.

- **Path**: `GET /v2/trends/by-location/:woeid`
- **Parameters**:
  - `woeid` (path, required): Where On Earth Identifier (WOEID) for the location
  - `exclude` (query, optional): Set to `hashtags` to exclude hashtag trends
- **Example**:
```bash
# Get worldwide trends
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/trends/by-location/1"

# Get US trends
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/trends/by-location/23424977"

# Get trends excluding hashtags
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/trends/by-location/1?exclude=hashtags"
```

## Common Patterns

### Common WOEIDs

| Location | WOEID |
|----------|-------|
| Worldwide | `1` |
| United States | `23424977` |
| United Kingdom | `23424975` |
| Japan | `23424856` |
| India | `23424848` |
| Brazil | `23424768` |
| France | `23424819` |
| Germany | `23424829` |
| Canada | `23424775` |
| Australia | `23424748` |
| Hong Kong | `24865698` |
| Singapore | `23424948` |

### Typical Workflow

```bash
# Step 1: Get all available trend locations
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/trends/locations"

# Step 2: Use a WOEID to get trends for that location
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/trends/by-location/23424977"
```

### Monitoring Trends

To track trending topics, periodically call the trends endpoint for your target locations. Trends update frequently, so check every few minutes for the most current data.
