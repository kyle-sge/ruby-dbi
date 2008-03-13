create table names (
    name varchar(255) not null,
    age integer not null
) Engine=InnoDB;
---
insert into names (name, age) values ('Joe', 19);
---
insert into names (name, age) values ('Jim', 30);
---
insert into names (name, age) values ('Bob', 21);
---
CREATE TABLE blob_test (name VARCHAR(30), data BLOB) Engine=InnoDB;
---
create view view_names as select * from names;
---
create table boolean_test (num integer, mybool boolean) Engine=InnoDB;
---
create table time_test (mytime time) Engine=InnoDB;
---
create table timestamp_test (mytimestamp timestamp) Engine=InnoDB;
---
create table bit_test (mybit bit) Engine=InnoDB;
---
create table field_types_test (foo integer not null primary key default 1);
