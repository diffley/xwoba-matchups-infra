-- 001_create_tables.sql

-- Table: player_splits
-- Defines the target structure. If the table doesn't exist, it's created like this.
-- If it exists with an older structure, subsequent ALTER TABLE statements will update it.
CREATE TABLE IF NOT EXISTS player_splits (
  player_id               BIGINT    NOT NULL,  -- MLBAM player ID
  season                  SMALLINT  NOT NULL,  -- Season year (e.g. 2023)
  player_type             TEXT      NOT NULL,  -- 'batter' or 'pitcher'
  vs_handedness           TEXT      NOT NULL,  -- 'L' or 'R' (vs_opponent_handedness from Savant script)
  player_name             TEXT,                -- Player's name
  pa                      INTEGER,             -- Plate Appearances
  k_percent               REAL,                -- Strikeout Percentage
  bb_percent              REAL,                -- Walk Percentage
  ba                      REAL,                -- Batting Average
  obp                     REAL,                -- On-Base Percentage
  slg                     REAL,                -- Slugging Percentage
  woba                    REAL,                -- Weighted On-Base Average
  xwoba                   REAL,                -- Expected Weighted On-Base Average (now nullable)
  barrels_total           INTEGER,             -- Total Barrels
  avg_launch_speed        REAL,                -- Average Launch Speed (Exit Velocity)
  avg_launch_angle        REAL,                -- Average Launch Angle
  hard_hit_percent        REAL,                -- Hard Hit Percentage
  barrels_per_pa_percent  REAL,                -- Barrels per Plate Appearance Percentage
  last_updated            TIMESTAMPTZ DEFAULT NOW() NOT NULL, -- Timestamp of the last update
  PRIMARY KEY (player_id, season, player_type, vs_handedness)
);

-- Add new columns if they don't exist (for when player_splits already exists from a previous version)
ALTER TABLE player_splits ADD COLUMN IF NOT EXISTS player_name TEXT;
ALTER TABLE player_splits ADD COLUMN IF NOT EXISTS pa INTEGER;
ALTER TABLE player_splits ADD COLUMN IF NOT EXISTS k_percent REAL;
ALTER TABLE player_splits ADD COLUMN IF NOT EXISTS bb_percent REAL;
ALTER TABLE player_splits ADD COLUMN IF NOT EXISTS ba REAL;
ALTER TABLE player_splits ADD COLUMN IF NOT EXISTS obp REAL;
ALTER TABLE player_splits ADD COLUMN IF NOT EXISTS slg REAL;
ALTER TABLE player_splits ADD COLUMN IF NOT EXISTS woba REAL;
-- Note: xwoba column already exists from the original definition. Its nullability is handled below.
ALTER TABLE player_splits ADD COLUMN IF NOT EXISTS barrels_total INTEGER;
ALTER TABLE player_splits ADD COLUMN IF NOT EXISTS avg_launch_speed REAL;
ALTER TABLE player_splits ADD COLUMN IF NOT EXISTS avg_launch_angle REAL;
ALTER TABLE player_splits ADD COLUMN IF NOT EXISTS hard_hit_percent REAL;
ALTER TABLE player_splits ADD COLUMN IF NOT EXISTS barrels_per_pa_percent REAL;
ALTER TABLE player_splits ADD COLUMN IF NOT EXISTS last_updated TIMESTAMPTZ DEFAULT NOW() NOT NULL;

-- If xwoba column exists and is NOT NULL, change it to be nullable.
-- This is necessary because the CREATE TABLE IF NOT EXISTS statement won't alter an existing column's constraints.
DO $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_name = 'player_splits'
          AND column_name = 'xwoba'
          AND table_schema = current_schema() -- Ensures we're checking the table in the current schema
          AND is_nullable = 'NO'
    ) THEN
        ALTER TABLE player_splits ALTER COLUMN xwoba DROP NOT NULL;
    END IF;
END $$;

-- Indexes on player_splits for faster lookups
CREATE INDEX IF NOT EXISTS idx_splits_player
  ON player_splits(player_id);

CREATE INDEX IF NOT EXISTS idx_splits_type_hand
  ON player_splits(player_type, vs_handedness);


-- Table: daily_matchups
CREATE TABLE IF NOT EXISTS daily_matchups (
  game_date     DATE     NOT NULL,  -- Date of the games
  batter_id     BIGINT   NOT NULL,  -- MLBAM ID for batter
  pitcher_id    BIGINT   NOT NULL,  -- MLBAM ID for pitcher
  avg_xwoba     REAL     NOT NULL,  -- Average of the two xwOBA values
  batter_name   TEXT,               -- Optional for display
  pitcher_name  TEXT,               -- Optional for display
  PRIMARY KEY (game_date, batter_id, pitcher_id)
);

-- Indexes on daily_matchups to speed up queries by date or score
CREATE INDEX IF NOT EXISTS idx_matchups_date
  ON daily_matchups(game_date);

CREATE INDEX IF NOT EXISTS idx_matchups_score_desc
  ON daily_matchups(avg_xwoba DESC);
