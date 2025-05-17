# xwoba-matchups-infra

This repository contains the infrastructure-as-code and database setup for the **xwOBA Matchups** project. It includes database migrations, seed data, and CI workflows to manage Supabase schema and development workflows.

---

## Project Overview

This repo is responsible for:

* **Database Schema**: SQL migrations that define tables for `player_splits` and `daily_matchups`.
* **Migrations**: Versioned migration scripts in `supabase/migrations/`.
* **Seed Data**: Sample seed scripts in `supabase/seeds/` for development and testing.
* **CI Workflows**: GitHub Actions to apply migrations (`deploy.yml`) and seed data (`seed.yml`).
* **Supabase Configuration**: Local and remote Supabase project linking via `supabase/config.toml` and environment variables.

---

## Getting Started

### Prerequisites

* **Supabase CLI** (>= v1.0)
* **Node.js** (v16 or higher)
* **GitHub Actions** configured with necessary secrets.

### Repository Structure

```
├── supabase/
│   ├── migrations/       # SQL migration files (001_*.sql, etc.)
│   └── seeds/            # Seed SQL scripts for development
├── .github/workflows/
│   ├── deploy.yml        # Migrations CI workflow
│   └── seed.yml          # Manual seed workflow
├── README.md             # This file
└── .gitignore
```

### Environment Variables

In GitHub Actions (**Settings → Secrets and variables → Actions**), define:

| Name                        | Purpose                                               |
| --------------------------- | ----------------------------------------------------- |
| `SUPABASE_URL`              | Supabase project URL (e.g. `https://xyz.supabase.co`) |
| `SUPABASE_SERVICE_ROLE_KEY` | Supabase service-role key (server-side operations)    |
| `SUPABASE_ACCESS_TOKEN`     | Supabase CLI access token (for migrations)            |
| `SUPABASE_DB_URL`           | Full Postgres connection string for seeding           |

For local development, copy `.env.example` to `.env` and set:

```bash
SUPABASE_URL=<your-url>
SUPABASE_KEY=<your-service-role-key>
```

---

## Local Development

1. **Link to Project**

   ```bash
   supabase link --project-ref <your-project-ref>
   ```
2. **Run Migrations**

   ```bash
   supabase db push
   ```
3. **Seed Database**

   ```bash
   psql "$SUPABASE_DB_URL?sslmode=require" -f supabase/seeds/seed.sql
   ```

   Or use the manual GitHub Action: **Actions → Seed Database → Run workflow**.

---

## CI Workflows

### `deploy.yml` (Auto-run on push to `main`)

* **Supabase CLI login** with `SUPABASE_ACCESS_TOKEN`
* **Push migrations** (`supabase db push`)

### `seed.yml` (Manual trigger)

* **Runs** via `workflow_dispatch`
* **Executes** the seed script against your hosted database

---

## Branch Protection

* Protect the `main` branch and require:

  * Passing status checks for **Migrate Supabase** workflow.
  * Code review approvals before merging.

---

## Troubleshooting

* **Migration errors**: Check `.github/workflows/deploy.yml` logs and ensure `SUPABASE_ACCESS_TOKEN` is valid.
* **Seed failures**: Verify `SUPABASE_DB_URL` is correctly formatted and includes `?sslmode=require`.
* **Local vs remote drift**: Use `supabase migration status` to inspect applied migrations.

---

## Next Steps

* Add new migrations for schema changes under `supabase/migrations/`.
* Update seed data in `supabase/seeds/` for expanded testing.
* Refine CI workflows to include linting or status checks as needed.
