CREATE TABLE IF NOT EXISTS ship__models(
    id SERIAL PRIMARY KEY,
    name VARCHAR(80) not null,
    frame_slug VARCHAR(60) not null,
    type VARCHAR(20) not null,
    stats json not null
);
CREATE TABLE IF NOT EXISTS ship__slots(
    id SERIAL PRIMARY KEY,
    model_id int not null REFERENCES ship__models(id),
    module_slug VARCHAR(80),
    position int not null
);
CREATE TABLE IF NOT EXISTS ship__player_models(
    player_id int not null REFERENCES players(id),
    model_id int not null REFERENCES ship__models(id)
);
CREATE TABLE IF NOT EXISTS ship__player_modules(
    player_id int not null REFERENCES players(id),
    module_slug VARCHAR(80) not null
);
