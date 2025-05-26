-- 001_create_tables.sql

-- Table: player_splits
CREATE TABLE IF NOT EXISTS player_splits (
  player_id     BIGINT    NOT NULL,  -- MLBAM player ID
  season        SMALLINT  NOT NULL,  -- Season year (e.g. 2023)
  player_type   TEXT      NOT NULL,  -- 'batter' or 'pitcher'
  vs_handedness TEXT      NOT NULL,  -- 'L' or 'R'
  xwoba         REAL      NOT NULL,  -- Expected wOBA value
  PRIMARY KEY (player_id, season, player_type, vs_handedness)
);

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