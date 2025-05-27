-- 002_add_lineup_info_to_matchup.sql

-- Table: daily_matchups
CREATE TABLE IF NOT EXISTS daily_matchups (
  game_date     DATE     NOT NULL,  -- Date of the games
  batter_id     BIGINT   NOT NULL,  -- MLBAM ID for batter
  pitcher_id    BIGINT   NOT NULL,  -- MLBAM ID for pitcher
  avg_xwoba     REAL     NOT NULL,  -- Average of the two xwOBA values
  avg_launch_angle     REAL     NOT NULL,  -- Average of the two launch angles
  avg_barrels_per_pa REAL NOT NULL,  -- Average of the two barrels per PA
  avg_hard_hit_pct REAL NOT NULL,  -- Average of the two hard-hit percentages
  avg_exit_velocity REAL NOT NULL,  -- Average of the two exit velocities
  batter_name   TEXT,               -- Optional for display
  batter_team  TEXT,               -- Optional for display
  pitcher_name  TEXT,               -- Optional for display
  pitcher_team TEXT,               -- Optional for display
  PRIMARY KEY (game_date, batter_id, pitcher_id)
);

ALTER TABLE daily_matchups
  ADD COLUMN lineup_position INTEGER,  -- Optional: Lineup position for the batter
  ADD COLUMN batter_team TEXT,
  ADD COLUMN pitcher_team TEXT;
  
  COMMENT ON COLUMN daily_matchups.lineup_position IS 'Lineup position of the batter in the game (1-9), NULL if not available or published yet';

-- Indexes on daily_matchups to speed up queries by date or score
CREATE INDEX IF NOT EXISTS idx_matchups_date
  ON daily_matchups(game_date);

CREATE INDEX IF NOT EXISTS idx_matchups_score_desc
  ON daily_matchups(avg_xwoba DESC);