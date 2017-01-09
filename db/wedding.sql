DROP TABLE guestsgifts;
DROP TABLE gifts;
DROP TABLE guests;

CREATE TABLE guests (
  id SERIAL4 primary key,
  name VARCHAR( 255 )
);

CREATE TABLE gifts (
  id SERIAL4 primary key,
  name VARCHAR( 255 )
);

CREATE TABLE guestsgifts (
  id SERIAL4 primary key,
  guests_id INT4 references guests( id ),
  gifts_id INT4 references gifts( id )
);