ALTER TABLE faction__factions DROP COLUMN color, ADD COLUMN colors JSON NOT NULL DEFAULT '{}'::JSON;
ALTER TABLE faction__factions ALTER COLUMN colors SET DEFAULT NULL;