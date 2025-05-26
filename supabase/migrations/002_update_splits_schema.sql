-- 002_update_player_splits_add_stats.sql

-- Add new columns if they don't exist to the player_splits table
ALTER TABLE public.player_splits ADD COLUMN IF NOT EXISTS player_name TEXT;
ALTER TABLE public.player_splits ADD COLUMN IF NOT EXISTS pa INTEGER;
ALTER TABLE public.player_splits ADD COLUMN IF NOT EXISTS k_percent REAL;
ALTER TABLE public.player_splits ADD COLUMN IF NOT EXISTS bb_percent REAL;
ALTER TABLE public.player_splits ADD COLUMN IF NOT EXISTS ba REAL;
ALTER TABLE public.player_splits ADD COLUMN IF NOT EXISTS obp REAL;
ALTER TABLE public.player_splits ADD COLUMN IF NOT EXISTS slg REAL;
ALTER TABLE public.player_splits ADD COLUMN IF NOT EXISTS woba REAL;
ALTER TABLE public.player_splits ADD COLUMN IF NOT EXISTS barrels_total INTEGER;
ALTER TABLE public.player_splits ADD COLUMN IF NOT EXISTS avg_launch_speed REAL;
ALTER TABLE public.player_splits ADD COLUMN IF NOT EXISTS avg_launch_angle REAL;
ALTER TABLE public.player_splits ADD COLUMN IF NOT EXISTS hard_hit_percent REAL;
ALTER TABLE public.player_splits ADD COLUMN IF NOT EXISTS barrels_per_pa_percent REAL;
ALTER TABLE public.player_splits ADD COLUMN IF NOT EXISTS last_updated TIMESTAMPTZ DEFAULT NOW();

-- If xwoba column exists and is NOT NULL, change it to be nullable.
DO $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_schema = 'public' -- Use 'public' or your specific schema
          AND table_name = 'player_splits'
          AND column_name = 'xwoba'
          AND is_nullable = 'NO'
    ) THEN
        ALTER TABLE public.player_splits ALTER COLUMN xwoba DROP NOT NULL;
        RAISE NOTICE 'Altered player_splits.xwoba to be nullable.';
    ELSE
        RAISE NOTICE 'player_splits.xwoba is already nullable, does not exist, or is not in the public schema.';
    END IF;
END $$;

-- After adding last_updated, if you want to enforce NOT NULL and ensure existing rows have a value:
-- UPDATE public.player_splits SET last_updated = NOW() WHERE last_updated IS NULL;
-- ALTER TABLE public.player_splits ALTER COLUMN last_updated SET NOT NULL;