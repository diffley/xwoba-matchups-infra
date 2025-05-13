-- seeds/seed.sql
-- Sample seed data for testing frontend

-- Sample player_splits for 2024 season
INSERT INTO player_splits (player_id, season, player_type, vs_handedness, xwoba) VALUES
  (545361, 2024, 'batter', 'L', 0.385),  -- Mookie Betts vs LHP
  (545361, 2024, 'batter', 'R', 0.325),  -- Mookie Betts vs RHP
  (594798, 2024, 'batter', 'L', 0.412),  -- Aaron Judge vs LHP
  (594798, 2024, 'batter', 'R', 0.305),  -- Aaron Judge vs RHP
  (594798, 2023, 'batter', 'L', 0.398),  -- additional season data
  (660670, 2024, 'pitcher', 'L', 0.240), -- Max Scherzer vs LHB
  (660670, 2024, 'pitcher', 'R', 0.270), -- Max Scherzer vs RHB
  (545361, 2024, 'pitcher', 'L', 0.320), -- Mookie Betts pitching splits (for test)
  (545361, 2024, 'pitcher', 'R', 0.350),
  (701040, 2024, 'pitcher', 'L', 0.230), -- Gerrit Cole vs LHB
  (701040, 2024, 'pitcher', 'R', 0.260);

-- Sample daily_matchups for today's date
INSERT INTO daily_matchups (game_date, batter_id, pitcher_id, avg_xwoba, batter_name, pitcher_name) VALUES
  ('2025-05-12', 545361, 660670, (0.240 + 0.385)/2, 'Mookie Betts', 'Max Scherzer'),
  ('2025-05-12', 594798, 701040, (0.260 + 0.412)/2, 'Aaron Judge', 'Gerrit Cole'),
  ('2025-05-12', 545361, 701040, (0.260 + 0.385)/2, 'Mookie Betts', 'Gerrit Cole'),
  ('2025-05-12', 594798, 660670, (0.270 + 0.412)/2, 'Aaron Judge', 'Max Scherzer');
