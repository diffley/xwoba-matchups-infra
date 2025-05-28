ALTER TABLE public.games
ADD COLUMN home_team_probable_pitcher_id INTEGER,
ADD COLUMN away_team_probable_pitcher_id INTEGER;

-- Optional: Add foreign key constraints if you have a players table
-- and want to ensure these IDs reference actual players.
-- This assumes your players table is named 'players' and has a primary key 'id'.
-- Adjust table and column names as necessary.

ALTER TABLE public.games
 ADD CONSTRAINT fk_home_probable_pitcher
 FOREIGN KEY (home_team_probable_pitcher_id)
 REFERENCES public.player_splits (player_id)
 ON DELETE SET NULL; -- Or ON DELETE NO ACTION, depending on desired behavior

ALTER TABLE public.games
 ADD CONSTRAINT fk_away_probable_pitcher
 FOREIGN KEY (away_team_probable_pitcher_id)
 REFERENCES public.player_splits (player_id)
 ON DELETE SET NULL; -- Or ON DELETE NO ACTION
