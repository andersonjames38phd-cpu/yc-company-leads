#!/usr/bin/env bash
# Y Combinator Company Leads - curl examples
# Replace YOUR_TOKEN with an Apify API token (https://console.apify.com/account/integrations).

set -euo pipefail

ACTOR="Turboextract~yc-company-leads"
TOKEN="${APIFY_TOKEN:-YOUR_TOKEN}"

# 1. Newest batch, B2B only (start a run)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "latestBatches": 1,
    "industries": [
      "B2B"
    ],
    "maxResults": 300
  }'

# 2. Hiring fintech startups from two batches (start a run)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "batches": [
      "Fall 2026",
      "Summer 2025"
    ],
    "industries": [
      "Fintech"
    ],
    "hiringOnly": true
  }'

# 3. Every active YC company in London, no founders (fast) (wait and get the dataset items in one call)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/run-sync-get-dataset-items?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "locations": [
      "London"
    ],
    "includeFounders": false,
    "maxResults": 1000
  }'
