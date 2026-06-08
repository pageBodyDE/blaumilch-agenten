-- =============================================================================
-- AI Chief of Staff — Supabase Schema (A1 Foundation)
-- =============================================================================
-- Paste this into Supabase → SQL Editor and run.
-- Tables: runs (logbook, one row per dispatcher execution),
--         coaching_history (the persistent client memory the Sequel-Skript reads).
-- =============================================================================

create extension if not exists "pgcrypto";

-- -----------------------------------------------------------------------------
-- runs: one row per dispatcher execution.
-- The Dispatcher workflow inserts a row at the start (status='running'),
-- then updates it to 'success' with the output + model, or to 'failed' with
-- the error message. The 'finished_at' column is set on the final update.
-- -----------------------------------------------------------------------------
create table runs (
  id           uuid primary key default gen_random_uuid(),
  tenant_id    text        not null,
  meeting_id   text        not null,
  action       text        not null,
  status       text        not null default 'pending',
  transcript   text,
  output       text,
  model        text,
  error        text,
  finished_at  timestamptz,
  created_at   timestamptz not null default now()
);

create index runs_tenant_created_idx on runs (tenant_id, created_at desc);
create index runs_meeting_idx        on runs (meeting_id);

-- -----------------------------------------------------------------------------
-- coaching_history: the persistent per-tenant coaching memory.
-- The CoachingAdvice sub-workflow reads recent rows for the tenant, writes
-- a new row after each coaching run. This is the moat — every second meeting
-- starts from this table, not from zero.
-- -----------------------------------------------------------------------------
create table coaching_history (
  id          uuid primary key default gen_random_uuid(),
  tenant_id   text        not null,
  run_id      uuid        references runs(id) on delete set null,
  meeting_id  text        not null,
  advice      text        not null,
  created_at  timestamptz not null default now()
);

create index coaching_history_tenant_created_idx on coaching_history (tenant_id, created_at desc);
create index coaching_history_run_idx            on coaching_history (run_id);

-- -----------------------------------------------------------------------------
-- Optional but recommended: Row-Level Security.
-- Foundation is single-tenant so RLS is off here; turn it on when you migrate
-- to multi-tenant (see a later issue in this series).
-- -----------------------------------------------------------------------------
-- alter table runs              enable row level security;
-- alter table coaching_history  enable row level security;
