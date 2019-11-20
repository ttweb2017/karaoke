insert into users(id, active, email, password, username, first_name, last_name) values
  (1, 1, 'admin@hazaryorite.com', '$2a$08$JBa431MT9g2lFoESzkGf6uHtNz8fLvqASwHpxh9uhMkByYv/59nwO', 'admin', 'Admin', 'Karaoke'),
  (2, 1, 'moderator@hazaryorite.com', '$2a$08$3kNg2IE5XGSjMY7xGCyiN.5TP0O3WwldgDUv7jUpsZUmZwIzSHozG', 'moderator', 'Moderator', 'Karaoke'),
  (3, 1, 'user@hazaryorite.com', '$2a$08$MHJpU1MSV/U/zJl7Ww3zY.sD7wivlpLL2tfV6OOx2CMrWJF05DvVG', 'user', 'User', 'Karaoke');

insert into user_role(user_id, roles) values
  (1, 'USER'),
  (1, 'MODERATOR'),
  (1, 'ADMIN'),
  (2, 'USER'),
  (2, 'MODERATOR'),
  (3, 'USER');

update hibernate_sequence set next_val = 4;