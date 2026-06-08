# AI Chief of Staff — n8n build kit

A staged, build-it-yourself AI Chief of Staff that runs on n8n and connects to
Fireflies (meeting transcripts), Notion, and Supabase. Each stage adds one
capability on top of the last. Import the workflow templates into your own n8n,
follow the `SETUP_CHECKLIST` in that folder, and run the `schema.sql` once.

Companion read: the [AI Chief of Staff Substack Artikel](https://blaumilch.substack.com/p/7440f499-570f-4f47-9667-a6d0cb0efb9d).

## Build stages

| Folder | Adds | Templates |
|---|---|---|
| **`01-foundation`** | Core dispatcher + first two actions, plus the Supabase schema | `Dispatcher_TEMPLATE.json`, `ProFollowUp_TEMPLATE.json`, `CoachingAdvice_TEMPLATE.json`, `schema.sql` |
| **`02-task-creator`** | Task creation in Notion | `TaskCreator_TEMPLATE.json` |
| **`03-draft-proposal`** | Proposal drafting | `DraftProposal_TEMPLATE.json` |

Start with `01-foundation` (it carries the dispatcher and the database schema
everything else depends on), then layer `02-task-creator` and
`03-draft-proposal` on top. Each folder has its own `SETUP_CHECKLIST.md`.

## Native-first

These templates are built to run on **native n8n nodes** wherever possible, so
the logic is visible on the canvas instead of hidden in Code nodes. Only two
Code nodes remain in the whole kit, each where a native node genuinely could
not do the job (a per-meeting history formatter, and the nested Notion page
body). Every workflow is documented with sticky notes you can read top to
bottom.

## Notes

- The `*_TEMPLATE.json` files are sanitized exports. **Credentials are not
  included**; wire up your own Fireflies, Notion, and Supabase connections in n8n
  after import. The `{{REPLACE_ME_...}}` placeholders mark every value you set.
- This is the deterministic teaching kit. The hosted SaaS app that fires at the
  same dispatcher is a separate product.
