---
name: tweetlen-api-space
description: "Twitter/X Space API - Get Space/audio room details. Trigger: get space, 查Space"
---

## Prerequisites

- Tweetlen API Key required. Get one at [api.tweetlen.com](https://api.tweetlen.com)
- Run `setup.sh` or add `TWEETLEN_API_KEY` to `~/.claude/settings.json` under `env`

## API Base Info

- **Base URL**: `https://api.tweetlen.com/v2`
- **Auth**: `Authorization: Bearer $TWEETLEN_API_KEY`
- **Method**: All endpoints use HTTP GET

## Endpoints

### 1. Get Space Details

Fetch detailed information about a Twitter/X Space (audio room), including the host, title, state, participant count, and scheduling info.

- **Path**: `GET /v2/space/:spaceId`
- **Parameters**:
  - `spaceId` (path, required): The Space's alphanumeric ID (e.g. `1eaKbrPAqbwKX`)
- **Example**:
```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/space/1eaKbrPAqbwKX"
```

## Common Patterns

### Extracting Space ID from URL

Space IDs can be extracted from Twitter/X Space URLs:

```
https://x.com/i/spaces/1eaKbrPAqbwKX
                        └── spaceId = 1eaKbrPAqbwKX

https://twitter.com/i/spaces/1eaKbrPAqbwKX
                              └── spaceId = 1eaKbrPAqbwKX
```

### Space States

A Space can be in one of several states:

| State | Description |
|-------|-------------|
| `live` | Currently broadcasting |
| `scheduled` | Scheduled for a future time |
| `ended` | Broadcast has ended |

### Usage Example

```bash
# Get details for a Space
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/space/1eaKbrPAqbwKX"

# The response includes:
# - title: Space title
# - state: live, scheduled, or ended
# - host: Host user information
# - participant_count: Number of listeners
# - scheduled_start: When the Space is/was scheduled (if applicable)
```
