create table comment (
  id bigint not null auto_increment,
  content varchar(32767),
  at datetime not null,
  post_id bigint not null,
  user_id bigint,
  primary key (id)
);

create table post (
  id bigint not null auto_increment,
  body longtext not null,
  subject varchar(127) not null,
  at datetime not null,
  user_id bigint,
  primary key (id)
);

create table post_tags (post_id bigint not null, tags varchar(255));

create table user (
  id bigint not null auto_increment,
  email varchar(127),
  name varchar(127) not null,
  password varchar(127),
  primary key (id)
);

alter table comment add constraint FK_comment_post foreign key (post_id) references post (id);
alter table comment add constraint FK_comment_user foreign key (user_id) references user (id);

alter table post add constraint FK_post_user foreign key (user_id) references user (id);

alter table post_tags add constraint FK_post_tags foreign key (post_id) references post (id);
