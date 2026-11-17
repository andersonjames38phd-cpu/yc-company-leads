"""Y Combinator Company Leads - Python example.

pip install apify-client
export APIFY_TOKEN=your_token
"""
import os

from apify_client import ApifyClient

client = ApifyClient(os.environ["APIFY_TOKEN"])

# Newest batch, B2B only
run = client.actor("Turboextract/yc-company-leads").call(run_input={
    "latestBatches": 1,
    "industries": [
        "B2B"
    ],
    "maxResults": 300
})

# Stream every item
for item in client.dataset(run["defaultDatasetId"]).iterate_items():
    print(item.get("name"), item.get("batch"), item.get("website"), item.get("teamSize"))

# Or fetch one page of items
page = client.dataset(run["defaultDatasetId"]).list_items(limit=100)
print(f"{page.total} items in dataset")
