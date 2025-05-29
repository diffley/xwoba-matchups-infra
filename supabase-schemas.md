# Teams
create table public.teams (
  id bigint not null,
  name text not null,
  abbreviation character varying(10) null,
  nickname text null,
  short_name text null,
  location_name text null,
  venue_id bigint null,
  venue_name_cache text null,
  league_id integer null,
  league_name text null,
  division_id integer null,
  division_name text null,
  active boolean null,
  last_updated timestamp with time zone not null default now(),
  constraint teams_pkey primary key (id),
  constraint teams_abbreviation_key unique (abbreviation),
  constraint fk_venue foreign KEY (venue_id) references venues (id) on delete set null
) TABLESPACE pg_default;

create index IF not exists idx_teams_abbreviation on public.teams using btree (abbreviation) TABLESPACE pg_default;

create index IF not exists idx_teams_venue_id on public.teams using btree (venue_id) TABLESPACE pg_default;

# Venues
create table public.venues (
  id bigint not null,
  name text null,
  postal_code character varying(20) null,
  elevation integer null,
  roof_type text null,
  field_left_line integer null,
  field_left_center integer null,
  field_center integer null,
  field_right_center integer null,
  field_right_line integer null,
  active boolean null,
  last_updated timestamp with time zone not null default now(),
  city text null,
  state text null,
  latitude numeric(9, 6) null,
  longitude numeric(9, 6) null,
  constraint venues_pkey primary key (id)
) TABLESPACE pg_default;

create index IF not exists idx_venues_name on public.venues using btree (name) TABLESPACE pg_default;

# Players
create table public.players (
  player_id integer not null,
  full_name text not null,
  current_age integer null,
  height character varying(10) null,
  weight integer null,
  primary_position_name character varying(255) null,
  primary_position_abbreviation character varying(10) null,
  bat_side_code character varying(1) null,
  pitch_hand_code character varying(1) null,
  created_at timestamp with time zone null default CURRENT_TIMESTAMP,
  updated_at timestamp with time zone null default CURRENT_TIMESTAMP,
  constraint players_pkey primary key (player_id)
) TABLESPACE pg_default;

create index IF not exists idx_players_full_name on public.players using btree (full_name) TABLESPACE pg_default;

create trigger trigger_players_updated_at BEFORE
update on players for EACH row
execute FUNCTION update_updated_at_column ();

# Games
create table public.games (
  game_pk bigint not null,
  official_date date not null,
  game_datetime_utc timestamp with time zone null,
  detailed_state character varying(50) null,
  away_team_id bigint null,
  home_team_id bigint null,
  venue_id bigint null,
  away_batting_order bigint[] null,
  home_batting_order bigint[] null,
  last_updated timestamp with time zone not null default now(),
  home_team_probable_pitcher_id integer null,
  away_team_probable_pitcher_id integer null,
  constraint games_pkey primary key (game_pk),
  constraint fk_games_away_team foreign KEY (away_team_id) references teams (id) on delete set null,
  constraint fk_games_home_team foreign KEY (home_team_id) references teams (id) on delete set null,
  constraint fk_games_venue foreign KEY (venue_id) references venues (id) on delete set null
) TABLESPACE pg_default;

create index IF not exists idx_games_official_date on public.games using btree (official_date) TABLESPACE pg_default;

create index IF not exists idx_games_home_team_id on public.games using btree (home_team_id) TABLESPACE pg_default;

create index IF not exists idx_games_away_team_id on public.games using btree (away_team_id) TABLESPACE pg_default;

# Player Splits
create table public.player_splits (
  player_id bigint not null,
  season smallint not null,
  player_type public.split_player_type not null,
  vs_handedness public.hand not null,
  player_name text null,
  pa integer null,
  ab integer null,
  ba numeric(4, 3) null,
  obp numeric(4, 3) null,
  slg numeric(4, 3) null,
  woba numeric(4, 3) null,
  xwoba numeric(4, 3) null,
  xba numeric(4, 3) null,
  xobp numeric(4, 3) null,
  xslg numeric(4, 3) null,
  iso numeric(4, 3) null,
  babip numeric(4, 3) null,
  barrels integer null,
  barrels_per_pa numeric(7, 4) null,
  hard_hit_pct numeric(5, 4) null,
  avg_exit_velocity numeric(6, 2) null,
  max_exit_velocity numeric(6, 2) null,
  avg_launch_angle numeric(5, 2) null,
  groundball_pct numeric(5, 4) null,
  line_drive_pct numeric(5, 4) null,
  flyball_pct numeric(5, 4) null,
  last_updated timestamp with time zone not null default now(),
  hrs integer null,
  swing_miss_percent numeric(5, 4) null,
  hyper_speed numeric(4, 1) null,
  k_percent numeric(5, 4) null,
  bb_percent numeric(5, 4) null,
  constraint player_splits_pkey primary key (player_id, season, player_type, vs_handedness)
) TABLESPACE pg_default;

create index IF not exists idx_player_splits_player on public.player_splits using btree (player_id) TABLESPACE pg_default;

create index IF not exists idx_player_splits_type_hand on public.player_splits using btree (player_type, vs_handedness) TABLESPACE pg_default;

# Daily Matchups
create table public.daily_matchups (
  game_date date not null,
  batter_id bigint not null,
  pitcher_id bigint not null,
  avg_xwoba real not null,
  avg_launch_angle real not null,
  avg_barrels_per_pa real not null,
  avg_hard_hit_pct real not null,
  avg_exit_velocity real not null,
  batter_name text null,
  pitcher_name text null,
  lineup_position integer null,
  batter_team text null,
  pitcher_team text null,
  game_pk bigint null,
  game_home_team_abbreviation character varying(10) null,
  game_away_team_abbreviation character varying(10) null,
  pitcher_hand text null,
  batter_hand text null,
  avg_k_percent double precision null,
  avg_bb_percent double precision null,
  avg_iso double precision null,
  avg_swing_miss_percent double precision null,
  home_team_id integer null,
  away_team_id integer null,
  constraint daily_matchups_pkey primary key (game_date, batter_id, pitcher_id)
) TABLESPACE pg_default;

create index IF not exists idx_matchups_date on public.daily_matchups using btree (game_date) TABLESPACE pg_default;

create index IF not exists idx_matchups_score_desc on public.daily_matchups using btree (avg_xwoba desc) TABLESPACE pg_default;


