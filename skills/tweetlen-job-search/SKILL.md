---
name: tweetlen-job-search
description: "Search Twitter/X job postings. Find jobs by keyword, location, type, and seniority. Trigger: 找工作, search jobs, X job search, Twitter jobs"
---

## Prerequisites

- Tweetlen API Key required. Get one at [api.tweetlen.com](https://api.tweetlen.com)
- Set env var: `TWEETLEN_API_KEY=twtl_your_key_here`

## Input Parsing

Extract parameters from user input:
- **keyword** (required): Job title, skill, or company name
- **location** (optional): City, state, country, or "remote"
- **type** (optional): `remote`, `onsite`, `hybrid`
- **employment** (optional): `full_time`, `part_time`, `contract`
- **seniority** (optional): `intern`, `entry_level`, `junior`, `mid_level`, `senior`, `lead`, `manager`, `executive`

Examples:
- "search jobs frontend engineer" -> keyword="frontend engineer"
- "找工作 python remote senior" -> keyword="python", type="remote", seniority="senior"
- "X jobs react developer San Francisco" -> keyword="react developer", location="San Francisco"

## Workflow

### Step 1: Suggest Locations (conditional)

Only if user specifies a location. Resolve the location string to a valid location ID.

**API Call**: `GET /v2/jobs/locations/suggest?query={location}`

```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/jobs/locations/suggest?query={location}"
```

**Extract**: Location ID and display name from the first suggestion

### Step 2: Search Jobs

**API Call**: `GET /v2/jobs/search?keyword={keyword}&count=20`

Include optional query parameters if provided:
- `location={locationId}` (from Step 1)
- `employmentType={type}` (remote/onsite/hybrid)
- `kpiType={employment}` (full_time/part_time/contract)
- `seniorityLevel={seniority}`

```bash
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/jobs/search?keyword={keyword}&count=20"

# With all optional filters:
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/jobs/search?keyword={keyword}&count=20&location={locationId}&employmentType={type}&seniorityLevel={seniority}"
```

**Extract**: Job listings with job IDs, titles, companies, locations, posting dates

### Step 3: Get Details for Top 3 Jobs

**API Calls** (make all 3 in parallel):
- `GET /v2/jobs/{jobId1}`
- `GET /v2/jobs/{jobId2}`
- `GET /v2/jobs/{jobId3}`

```bash
# Job 1
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/jobs/{jobId1}"

# Job 2
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/jobs/{jobId2}"

# Job 3
curl -H "Authorization: Bearer $TWEETLEN_API_KEY" \
  "https://api.tweetlen.com/v2/jobs/{jobId3}"
```

**Extract**: Full job description, requirements, salary info, application link, company details

## Analysis Logic

### Job Listing Summary
- Deduplicate listings if any appear multiple times
- Sort by relevance (default API ordering) or posting date
- Extract key info: title, company, location, employment type, seniority

### Detailed Job Cards
For the top 3 results, provide comprehensive information:
- Full job description
- Key requirements and qualifications
- Salary range (if available)
- Company overview
- Application instructions or link

## Output Format

```markdown
# Job Search Results: "{keyword}"

**Filters Applied**: {list active filters or "None"}
**Results Found**: {total count}

## Job Listings

| # | Title | Company | Location | Type | Posted |
|---|-------|---------|----------|------|--------|
| 1 | {title} | {company} | {location} | {type} | {date} |
| 2 | {title} | {company} | {location} | {type} | {date} |
| ... | ... | ... | ... | ... | ... |
| 20 | {title} | {company} | {location} | {type} | {date} |

---

## Top 3 Detailed Listings

### 1. {Job Title} at {Company}

- **Location**: {location}
- **Type**: {employment type}
- **Seniority**: {level}
- **Salary**: {range if available, otherwise "Not specified"}
- **Posted**: {date}

**Description**:
{full job description}

**Requirements**:
{key requirements}

**How to Apply**: {application link or instructions}

---

### 2. {Job Title} at {Company}
{same format as above}

---

### 3. {Job Title} at {Company}
{same format as above}
```

## Error Handling

- If Step 1 fails (location not found): Proceed without location filter; note "Location '{location}' not recognized, showing results without location filter"
- If Step 2 fails (no results): Report "No jobs found for '{keyword}'" with suggestions to broaden search
- If Step 2 returns empty results: Suggest removing filters or trying different keywords
- If Step 3 fails for one job: Show summary info only for that job; note "Detailed info unavailable"
- If all Step 3 calls fail: Show the listing table only without detailed cards
- If keyword is missing: Ask user to provide a job search keyword

## Example Usage

- "找工作 frontend engineer"
- "search jobs python developer remote"
- "X job search machine learning San Francisco senior"
- "Twitter jobs react developer contract"
- "找远程的 golang 工作"
