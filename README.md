# xwoba-matchups-infra

This repository contains the infrastructure-as-code and database setup for the xwOBA Matchups project. It includes database migrations, seed data, and configuration for Supabase.

---

## Project Overview

This project manages:
- **Database Schema**: Tables for `player_splits` and `daily_matchups`.
- **Migrations**: SQL scripts to define and update the database schema.
- **Seed Data**: Sample data for testing and development.
- **Supabase Configuration**: Settings for local and remote environments.

---

## Getting Started

### Prerequisites
- [Supabase CLI](https://supabase.com/docs/guides/cli) installed.
- Node.js (v16 or higher).
- Access to the Supabase project (URL and service key).

### Environment Variables
Ensure the following environment variables are set:
- `SUPABASE_URL`: Your Supabase project URL.
- `SUPABASE_KEY`: Your Supabase service role key.

For local development, you can add these to a `.env` file:
```env
SUPABASE_URL=your-supabase-url
SUPABASE_KEY=your-supabase-key
