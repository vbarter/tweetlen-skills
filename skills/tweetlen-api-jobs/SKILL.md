---
name: tweetlen-api-jobs
description: "Twitter/X Jobs API - Search jobs, get details, suggest locations. Trigger: search jobs, 找工作"
---

## Prerequisites

- Tweetlen API Key required. Get one at [api.tweetlen.com](https://api.tweetlen.com)
- Run `setup.sh` or add `TWEETLEN_API_KEY` to `~/.claude/settings.json` under `env`

## API Base Info

- **Base URL**: `https://api.tweetlen.com/v2`
- **Auth**: `Authorization: Bearer $TWEETLEN_API_KEY`
- **Method**: All endpoints use HTTP GET

## Endpoints

### 1. Search Jobs

Search for job postings on Twitter/X with various filters.

- **Path**: `GET /v2/jobs/search`
- **Parameters**:
  - `keyword` (query, required): Job search keyword (e.g. "software engineer")
  - `count` (query, optional, default: 20): Number of results to return
  - `cursor` (query, optional): Pagination cursor from previous response
  - `jobLocationType` (query, optional): Location type filter - one or more of `onsite`, `remote`, `hybrid` (comma-separated)
  - `employmentType` (query, optional): Employment type filter - one or more of `full_time`, `full_time_contract`, `part_time`, `contract_to_hire` (comma-separated)
  - `seniorityLevel` (query, optional): Seniority filter - one or more of `intern`, `entry_level`, `junior`, `mid_level`, `senior`, `lead`, `manager`, `executive` (comma-separated)
  - `jobLocationId` (query, optional): Location ID from the suggest endpoint to filter by specific location
- **Example**:
```bash
# Basic job search
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/jobs/search?keyword=software%20engineer"

# Search for remote senior positions
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/jobs/search?keyword=machine%20learning&jobLocationType=remote&seniorityLevel=senior"

# Search for full-time jobs in a specific location
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/jobs/search?keyword=product%20manager&employmentType=full_time&jobLocationId=12345"

# Combine multiple filters
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/jobs/search?keyword=data%20scientist&jobLocationType=remote,hybrid&seniorityLevel=mid_level,senior&employmentType=full_time"
```

### 2. Get Job Details

Fetch detailed information about a specific job posting.

- **Path**: `GET /v2/jobs/:jobId`
- **Parameters**:
  - `jobId` (path, required): The job's numeric ID
- **Example**:
```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/jobs/1234567890"
```

### 3. Suggest Job Locations

Get location suggestions for filtering job searches. Use the returned IDs with the `jobLocationId` parameter in the search endpoint.

- **Path**: `GET /v2/jobs/locations/suggest`
- **Parameters**:
  - `query` (query, required): Location search text (city, state, country, etc.)
- **Example**:
```bash
# Get location suggestions
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/jobs/locations/suggest?query=San%20Francisco"

# Get suggestions for a country
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/jobs/locations/suggest?query=United%20States"
```

## Common Patterns

### Location-Based Job Search Workflow

To search for jobs in a specific location, first get the location ID, then use it in your search:

```bash
# Step 1: Get location ID for San Francisco
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/jobs/locations/suggest?query=San%20Francisco"
# Response contains location IDs

# Step 2: Use the location ID in job search
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/jobs/search?keyword=engineer&jobLocationId=12345"
```

### Filter Options Reference

#### Job Location Types

| Value | Description |
|-------|-------------|
| `onsite` | In-office/on-site work |
| `remote` | Fully remote position |
| `hybrid` | Mix of remote and on-site |

#### Employment Types

| Value | Description |
|-------|-------------|
| `full_time` | Full-time permanent |
| `full_time_contract` | Full-time contract |
| `part_time` | Part-time |
| `contract_to_hire` | Contract with potential conversion to permanent |

#### Seniority Levels

| Value | Description |
|-------|-------------|
| `intern` | Internship |
| `entry_level` | Entry level / new grad |
| `junior` | Junior level |
| `mid_level` | Mid-level |
| `senior` | Senior level |
| `lead` | Team lead |
| `manager` | Manager |
| `executive` | Executive / C-level |

### Pagination with Cursor

```bash
# First page
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/jobs/search?keyword=engineer&count=20"

# Next page
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/jobs/search?keyword=engineer&count=20&cursor=DAABCgABGPmh..."
```
