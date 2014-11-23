CREATE TABLE songs (
  id serial,
  song_name varchar(255) NOT NULL,
  artist varchar(255),
  user_name varchar(255),
  song_url varchar(255),
  created_at timestamp NOT NULL
);
