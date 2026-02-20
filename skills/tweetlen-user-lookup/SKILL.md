---
name: tweetlen-user-lookup
description: "Quick Twitter/X user lookup. Resolves username to rest_id and shows basic profile info. Trigger: 查找用户, lookup user, lookup @xxx, find user"
---

## Prerequisites

- Tweetlen API Key required. Get one at [api.tweetlen.com](https://api.tweetlen.com)
- Set env var: `TWEETLEN_API_KEY=twtl_your_key_here`

## Workflow

### Step 1: Lookup User

**API Call**: `GET /v2/user/by-username/:username`

```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/user/by-username/{username}"
```

**Extract**: `rest_id`, `name`, `screen_name`, `description`, `followers_count`, `friends_count`, `statuses_count`, `verified`, `profile_image_url`, `profile_banner_url`

## Analysis Logic

This is a simple single-step lookup. No complex analysis needed. Just format the response data into a clean user card.

Key data to emphasize:
- `rest_id` - This is the numeric user ID needed for other Tweetlen API endpoints (tweets, followers, etc.)
- Verification status
- Follower/following ratio as a quick credibility indicator

## Output Format

```markdown
# User: {name} (@{screen_name})

| Field | Value |
|-------|-------|
| **REST ID** | `{rest_id}` |
| Name | {name} |
| Username | @{screen_name} |
| Bio | {description} |
| Followers | {followers_count} |
| Following | {friends_count} |
| Tweets | {statuses_count} |
| Verified | {yes/no} |
| Profile Image | {profile_image_url} |

> **Tip**: Use REST ID `{rest_id}` with other Tweetlen API endpoints:
> - Tweets: `GET /v2/user/{rest_id}/tweets`
> - Followers: `GET /v2/user/{rest_id}/followers`
> - Media: `GET /v2/user/{rest_id}/media`
```

## Error Handling

- If user not found: Report "User @{username} not found. Please check the username and try again." and stop
- If API returns an error: Display the error message and suggest verifying the API key

## Example Usage

- "查找用户 @elonmusk"
- "lookup user naval"
- "lookup @jack"
- "find user VitalikButerin"
