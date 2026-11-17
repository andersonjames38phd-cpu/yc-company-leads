// Y Combinator Company Leads - Node.js example
// npm install apify-client
// APIFY_TOKEN=your_token node node.mjs
import { ApifyClient } from 'apify-client';

const client = new ApifyClient({ token: process.env.APIFY_TOKEN });

// Hiring fintech startups from two batches
const run = await client.actor('Turboextract/yc-company-leads').call({
    "batches": [
        "Fall 2026",
        "Summer 2025"
    ],
    "industries": [
        "Fintech"
    ],
    "hiringOnly": true
});

const { items } = await client.dataset(run.defaultDatasetId).listItems();
for (const item of items) {
    console.log(item.name, item.batch, item.website, item.teamSize);
}
