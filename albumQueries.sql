use demetrip; 
-- Computer Science II
-- Lab 7.0 - Structured Query Language I
-- Queries
--
-- Name(s): Demetri Papageorge
--
-- 
--
-- For each question, write an SQL query to get the specified result. You
-- are highly encouraged to use a GUI SQL tool such as MySQL Workbench and
-- keep track of your queries in an SQL script so that lab instructors can
-- verify your work. If you do, write your queries in the script file
-- provided rather than hand-writing your queries here.

-- Simple Queries 
-- --------------

-- 1. List all albums in the database.
select * from Album;
-- 2. List all albums in the database from newest to oldest.
select * from Album order by year desc;
-- 3. List all bands in the database that begin with "The".
select * from Band where name like "The%";
-- 4. List all songs in the database in alphabetic order.
select * from Song order by title;
-- 5. Write a query that gives just the albumId of the album "Nevermind".
select albumId from Album where title like "Nevermind";

-- Simple Aggregate Queries 
-- ------------------------

-- 6. Write a query to determine how many musicians are in the database.
select count(*) from Musician;
-- 7. Write a (nested) query to list the oldest album(s) in the database.
select * from Album where year < 1970 order by year;
-- 8. Write a query to find the total running time (in seconds) of all 
--    tracks on the album *Rain Dogs* by Tom Waits
select sum(trackLength) from AlbumSong where albumId = (select albumId from Album where title like "Rain Dogs");
-- Join Queries 
-- ------------

-- 9. Write a query list all albums in the database along with the album's
--    band, but only include the album title, year and band name.
select Album.title,Album.year,Band.name from Album join Band where Band.bandId = Album.bandId;
-- 10. Write a query that lists all albums and all tracks on the albums 
--     for the band Nirvana.
select a.title,s.title
from Band b inner join Album a
on b.name like "Nirvana"
inner join AlbumSong al
on al.AlbumId = a.AlbumId
inner join Song s
on al.SongId = s.SongId;

-- 11. Write a query that list all bands along with all their albums in 
--     the database *even if they do not have any*.
select Band.name,Album.title from Band left join Album on Album.BandId = Band.BandId;
-- Grouped Join Queries 
-- --------------------
-- 12. Write a query list all bands along with a *count* of how many albums
--     they have in the database (as you saw in the previous query, some should
--     have zero).
select Band.name,count(Album.BandId) from Band left join Album on Album.BandId = Band.BandId group by Band.BandId;
-- 13. Write a query that lists all albums in the database along with the
--     number of tracks on them.
select Album.title, count(AlbumSong.AlbumId) from Album inner join AlbumSong on Album.AlbumId = AlbumSong.AlbumId group by AlbumSong.AlbumId;
-- 14. Write the same query, but limit it to albums which have 12 or more
--     tracks on them.
select Album.title, count(AlbumSong.AlbumId) from Album inner join AlbumSong on Album.AlbumId = AlbumSong.AlbumId group by AlbumSong.AlbumId having count(AlbumSong.AlbumId) >= 12;
-- 15. Write a query to find all musicians that are not in any bands.
select Musician.firstName,Musician.lastName,BandMember.bandId from Musician left join BandMember on Musician.musicianId = BandMember.MusicianId where BandMember.BandId is null;
-- 16. Write a query to find all musicians that are in more than one band.
select Musician.firstName, Musician.lastName from Musician right join BandMember on Musician.MusicianId = BandMember.MusicianId group by BandMember.MusicianId having count(BandMember.MusicianId) > 1;



