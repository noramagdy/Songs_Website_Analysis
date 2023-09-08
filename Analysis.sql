select distinct * 
from
(
select e.artist_name, s.artist_id, artist_location, 
count(e.user_id) over(partition by s.artist_name) as users_number
from events e ,songs s
where s.artist_name=e.artist_name) as user_subquery
order by users_number desc;



select * 
from
(
select song_id, s.song_name, e.artist_name, artist_id,
count(user_id) over(partition by song_id) as users_number
from songs s, events e
where e.song_name=s.song_name) as sub_query
order by users_number desc;



select *
from 
(
select distinct s.song_name, song_id, e.artist_name, level, length, 
count(user_id) over(partition by song_id) as users_number
from songs s, events e
where song_played='NextSong') as sub_query
where song_name is not null;



select * 
from 
(
select  distinct session_id, song_name, users_number, artist_name, level, 
dense_rank() over(partition by session_id order by users_number desc) as song_rank 
from
(
select session_id, song_name, artist_name, level, 
count(user_id) over(partition by session_id, song_name) as users_number
from events 
where song_name is not null and song_played='NextSong') as sub_query1)as sub_query2
group by session_id, song_name, level, users_number, artist_name, song_rank
order by session_id, song_rank;



select *, dense_rank() over(order by songs_number desc)
from
(
select distinct artist_name, song_name, count(song_name) over(partition by artist_name) as songs_number
from events
where song_name is not null) as sub_query;



select *
from
(
select distinct user_id, session_id, user_first_name, user_last_name, song_name,
count(song_name) over(partition by user_id) as songs_number
from events
where song_name is not null and song_played='NextSong') as sub_query;



select song_name, length, user_id,
first_value(song_name) over(partition by session_id order by length desc) as longest_song,
first_value(song_name) over(partition by session_id order by length) as shortest_song
from events
where song_name is not null and song_played='NextSong'
order by session_id;



select distinct user_id, user_first_name, user_last_name, number_of_traits, successful_traits,
cast(successful_traits as float)/number_of_traits as successful_percentage
from
(
select user_id, user_first_name, user_last_name,
count(user_id) over(partition by user_id) as number_of_traits,
count(case when status=200 then 1 end) over(partition by user_id) as successful_traits
from events
where song_name is not null and song_played='NextSong') as subquery
order by user_id;



select user_id, user_first_name, user_last_name, paid_songs, free_songs,
cast(paid_songs as float)/(paid_songs+free_songs) as paid_songs_percentage
from
(
select distinct user_id, user_first_name, user_last_name,
count(case when level='paid' then 1 end) over(partition by user_id) as paid_songs,
count(case when level='free' then 1 end) over(partition by user_id) as free_songs
from events
where song_name is not null and song_played='NextSong') as sub_query
order by user_id;



select user_id, dense_rank() over(order by user_duration desc),
user_first_name, user_last_name, user_duration
from
(
select distinct user_id, user_first_name, user_last_name,
sum(length) over(partition by user_id) as user_duration
from events
where song_name is not null and song_played='NextSong') as sub_query;