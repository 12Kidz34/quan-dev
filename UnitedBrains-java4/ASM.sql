create database PolyOE_ASM
use PolyOE_ASM
create table Users(
	id nvarchar(10) not null,
    password nvarchar(50) not null,
    fullname nvarchar(50) not null,
    email nvarchar(50) not null unique,
    admin bit not null,
    primary key(id)
)
drop table Video
create table Video(
	id nvarchar(10) not null,
    title nvarchar(50) not null,
    poster nvarchar(500) not null,
    views int not null,
    description nvarchar(50) not null,
    active bit not null,
    link nvarchar(200) not null unique,
    primary key(id)
)

drop table Favorite
create table Favorite(
	id bigint not null,
    userId nvarchar(50) not null,
    videoId nvarchar(50) not null,
    likeDate date not null,
    primary key(id),
    foreign key(userId) references Users(id),
    foreign key(videoId) references Video(id)
)

drop table Share
create table Share(
	id bigint not null,
    userId nvarchar(50) not null,
    videoId nvarchar(50) not null,
    emails nvarchar(50) not null,
    shareDate date not null,
    primary key(id),
    foreign key(userId) references Users(id),
    foreign key(videoId) references Video(id)
)
select* from users
select* from video
select* from share
select* from favorite
insert into users(id, password, fullname, email, admin) values ('1', '111', 'User01', 'user01@gmail.com', 0);
insert into users(id, password, fullname, email, admin) values ('2', '222', 'User02', 'user02@gmail.com', 1);
insert into users(id, password, fullname, email, admin) values ('3', '333', 'User03', 'user03@fpt.edu.vn', 1);
insert into users(id, password, fullname, email, admin) values ('4', '444', 'User04', 'user04@fpt.edu.vn', 0);
insert into users(id,password, fullname, email, admin) values ('5', '555', 'User05', 'user05@fpt.edu.vn', 0);
insert into users(id, password, fullname, email, admin) values ('6', '666', 'User06', 'user06@fpt.edu.vn', 1);
insert into users(id, password, fullname, email, admin) values ('7', '777', 'User07', 'user07@fpt.edu.vn', 1);
insert into users(id, password, fullname, email, admin) values ('8', '888', 'User08', 'user08@fpt.edu.vn', 0);

insert into video(id, title, poster, views, description, active, link) values ('1', 'Haru - Yorushika', 'Chasca.jpg', 1000, 'N', 0, 'https://www.youtube.com/embed/LTGkt3GrGNY');
insert into video(id, title, poster, views, description, active, link) values ('2', 'Yuusha - YOASOBI', 'Chasca.jpg', 1500, 'N', 0, 'https://www.youtube.com/embed/OIBODIPC_8Y');
insert into video(id, title, poster, views, description, active, link) values ('3', 'Cruel Summer - Taylor Swift', 'Chasca.jpg', 1000, 'N', 1, 'https://www.youtube.com/embed/ic8j13piAhQ');
insert into video(id, title, poster, views, description, active, link) values ('4', 'Love Story - Taylor Swift', 'Chasca.jpg', 2000, 'N', 1, 'https://www.youtube.com/embed/8xg3vE8Ie_E');
insert into video(id, title, poster, views, description, active, link) values ('5', 'Blank Space - Taylor Swift', 'Chasca.jpg', 13000, 'N', 1, 'https://www.youtube.com/embed/e-ORhEE9VVg');
insert into video(id, title, poster, views, description, active, link) values ('6', 'Style - Taylor Swift', 'Chasca.jpg', 4000, 'N', 0, 'https://www.youtube.com/embed/-CmadmM5cOk');
insert into video(id, title, poster, views, description, active, link) values ('7', 'Delicate - Taylor Swift', 'Chasca.jpg', 100, 'N', 0, 'https://www.youtube.com/embed/tCXGJQYZ9JA');
insert into video(id, title, poster, views, description, active, link) values ('8', 'The Man - Taylor Swift', 'Chasca.jpg', 100, 'N', 0, 'https://www.youtube.com/embed/AqAJLh9wuZ0g');
insert into video(id, title, poster, views, description, active, link) values ('9', 'Lover - Taylor Swift', 'Citlali.png', 7000, 'N', 0, 'https://www.youtube.com/embed/-BjZmE2gtdo');
insert into video(id, title, poster, views, description, active, link) values ('10', 'Shake It Off - Taylor Swift', 'Citlali.png', 8000, 'N', 1, 'https://www.youtube.com/embed/nfWlot6h_JM');
insert into video(id, title, poster, views, description, active, link) values ('11', 'Anti-Hero - Taylor Swift', 'Citlali.png', 5000, 'N', 1, 'https://www.youtube.com/embed/b1kbLwvqugk');
insert into video(id, title, poster, views, description, active, link) values ('12', 'ME! - Taylor Swift', 'Citlali.png', 1400, 'N', 0, 'https://www.youtube.com/embed/FuXNumBwDOM');
insert into video(id, title, poster, views, description, active, link) values ('13', '22 - Taylor Swift', 'Citlali.png', 300, 'N', 0, 'https://www.youtube.com/embed/AgFeZr5ptV8');
insert into video(id, title, poster, views, description, active, link) values ('14', 'cardigan - Taylor Swift', 'Citlali.png', 200, 'N', 1, 'https://www.youtube.com/embed/K-a8s8OLBSE');
insert into video(id, title, poster, views, description, active, link) values ('15', 'Back To December - Taylor Swift', 'Citlali.png', 800, 'N', 0, 'https://www.youtube.com/embed/QUwxKWT6m7U');
insert into favorite(id, userId, videoId, likeDate) values (1, '1', '1', '2020-09-08');
insert into share(id, userId, videoId, emails, shareDate) values (1, '1', '1', 'user01@gmail.com', '2021-09-08');
insert into share(id, userId, videoId, emails, shareDate) values (2, '3', '1', 'user03@gmail.com', '2021-10-08');