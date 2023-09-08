create table songs(
artist_id varchar(100),
artist_latitude float,
artist_location varchar(100),
artist_longitude float,
artist_name varchar(200),
duration float,
num_songs int,
song_id varchar(100),
song_name varchar(100),
year int
);
drop table songs;

COPY songs 
FROM 'E:\SQL Projects\Song Website\songs.csv'
DELIMITER ',' CSV HEADER encoding 'windows-1251';

select * 
from songs;

create table events(
artist_name varchar(200),
authentication varchar(200),
user_first_name varchar(200),
gender varchar(200),
num_item_in_session int,
user_last_name varchar(200),
length float,
level varchar(200),
location varchar(200),
method varchar(200),
song_played varchar(200),
registration varchar(200),
session_id int,
song_name varchar(200),
status int,
time_of_song varchar(200),
user_agent varchar(400),
user_id int
);
drop table events;

COPY events 
FROM 'E:\SQL Projects\Song Website\events.csv'
DELIMITER ',' CSV HEADER encoding 'UTF8';

select *
from events;