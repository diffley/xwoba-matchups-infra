-- seeds/seed.sql
-- Sample seed data for testing frontend

-- Sample player_splits for 2024 season
INSERT INTO player_splits (
  player_id, season, player_type, vs_handedness, player_name,
  pa, k_percent, bb_percent, ba, obp, slg, woba, xwoba,
  barrels_total, avg_launch_speed, avg_launch_angle, hard_hit_percent, barrels_per_pa_percent, last_updated
) VALUES
  (
    545361, 2024, 'batter', 'L', 'Mookie Betts',
    150, 0.15, 0.12, 0.300, 0.400, 0.550, 0.410, 0.385,
    15, 92.5, 15.0, 0.50, 0.10, NOW() - INTERVAL '1 day'
  ),  -- Mookie Betts vs LHP
  (
    545361, 2024, 'batter', 'R', 'Mookie Betts',
    450, 0.18, 0.10, 0.280, 0.360, 0.500, 0.370, 0.325,
    40, 91.0, 12.5, 0.45, 0.088, NOW() - INTERVAL '1 day'
  ),  -- Mookie Betts vs RHP
  (
    594798, 2024, 'batter', 'L', 'Aaron Judge',
    180, 0.25, 0.15, 0.290, 0.420, 0.600, 0.430, 0.412,
    25, 95.0, 18.0, 0.55, 0.138, NOW() - INTERVAL '1 day'
  ),  -- Aaron Judge vs LHP
  (
    594798, 2024, 'batter', 'R', 'Aaron Judge',
    420, 0.28, 0.13, 0.260, 0.370, 0.520, 0.380, 0.305,
    50, 94.0, 16.0, 0.50, 0.119, NOW() - INTERVAL '1 day'
  ),  -- Aaron Judge vs RHP
  (
    594798, 2023, 'batter', 'L', 'Aaron Judge', -- additional season data
    170, 0.24, 0.16, 0.285, 0.410, 0.580, 0.420, 0.398,
    22, 94.5, 17.5, 0.53, 0.129, NOW() - INTERVAL '1 year'
  ),
  (
    660670, 2024, 'pitcher', 'L', 'Max Scherzer', -- Assuming vs LHB for pitcher
    120, 0.30, 0.08, 0.220, 0.290, 0.380, 0.280, 0.240,
    5, 88.0, 10.0, 0.35, 0.041, NOW() - INTERVAL '1 day'
  ), -- Max Scherzer vs LHB
  (
    660670, 2024, 'pitcher', 'R', 'Max Scherzer', -- Assuming vs RHB for pitcher
    380, 0.28, 0.07, 0.240, 0.300, 0.400, 0.300, 0.270,
    15, 89.0, 11.0, 0.38, 0.039, NOW() - INTERVAL '1 day'
  ), -- Max Scherzer vs RHB
  (
    545361, 2024, 'pitcher', 'L', 'Mookie Betts', -- Mookie Betts pitching splits (for test)
    20, 0.10, 0.15, 0.300, 0.400, 0.500, 0.400, 0.320,
    2, 85.0, 8.0, 0.30, 0.10, NOW() - INTERVAL '1 day'
  ),
  (
    545361, 2024, 'pitcher', 'R', 'Mookie Betts',
    30, 0.12, 0.18, 0.320, 0.420, 0.550, 0.420, 0.350,
    3, 86.0, 9.0, 0.33, 0.10, NOW() - INTERVAL '1 day'
  ),
  (
    701040, 2024, 'pitcher', 'L', 'Gerrit Cole', -- Assuming vs LHB for pitcher
    150, 0.32, 0.06, 0.210, 0.270, 0.350, 0.270, 0.230,
    6, 90.0, 12.0, 0.33, 0.04, NOW() - INTERVAL '1 day'
  ), -- Gerrit Cole vs LHB
  (
    701040, 2024, 'pitcher', 'R', 'Gerrit Cole', -- Assuming vs RHB for pitcher
    400, 0.30, 0.05, 0.230, 0.280, 0.380, 0.290, 0.260,
    18, 91.0, 13.0, 0.36, 0.045, NOW() - INTERVAL '1 day'
  );

-- Sample daily_matchups for today's date
INSERT INTO daily_matchups (game_date, batter_id, pitcher_id, avg_xwoba, batter_name, pitcher_name) VALUES
  ('2025-05-12', 545361, 660670, (0.240 + 0.385)/2, 'Mookie Betts', 'Max Scherzer'),
  ('2025-05-12', 594798, 701040, (0.260 + 0.412)/2, 'Aaron Judge', 'Gerrit Cole'),
  ('2025-05-12', 545361, 701040, (0.260 + 0.385)/2, 'Mookie Betts', 'Gerrit Cole'),
  ('2025-05-12', 594798, 660670, (0.270 + 0.412)/2, 'Aaron Judge', 'Max Scherzer');

-- Example of a player with some null values for new stats (if data is missing)
INSERT INTO player_splits (
  player_id, season, player_type, vs_handedness, player_name,
  pa, k_percent, bb_percent, ba, obp, slg, woba, xwoba,
  barrels_total, avg_launch_speed, avg_launch_angle, hard_hit_percent, barrels_per_pa_percent, last_updated
) VALUES
  (
    123456, 2024, 'batter', 'R', 'Unknown Player',
    50, 0.20, 0.05, 0.250, 0.300, 0.400, 0.310, 0.300,
    NULL, NULL, NULL, NULL, NULL, NOW()
  );

-- Example of a pitcher with some null values
INSERT INTO player_splits (
  player_id, season, player_type, vs_handedness, player_name,
  pa, k_percent, bb_percent, ba, obp, slg, woba, xwoba,
  barrels_total, avg_launch_speed, avg_launch_angle, hard_hit_percent, barrels_per_pa_percent, last_updated
) VALUES
  (
    654321, 2024, 'pitcher', 'L', 'Mystery Pitcher',
    45, 0.22, 0.09, 0.260, 0.330, 0.420, 0.320, 0.315,
    2, NULL, 14.5, 0.40, NULL, NOW()
  );
