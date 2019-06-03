/*
 * TODO(Студент): Опишите процесс создания базы данных
 * 1. Создайте все таблицы, согласно предложенной диаграмме.
 * 2. Опишите все необходимые отношения между таблицами.
 * 3. Добавьте в каждую таблицу минимум три записи.
 */

create table ROLES (
    ID int not null,
    "NAME" varchar (255) not null,
    constraint PK_ROLES primary key("NAME"),
    constraint UK_ROLES_ID unique(ID)
);

create table USERINFO (
    ID int generated always as identity (start with 1, increment by 1),
    "NAME" varchar(255),
    SURNAME varchar(255),
    constraint PK_USERINFO primary key (ID)
);

create table "USER" (
    ID int generated always as identity (start with 1, increment by 1),
    EMAIL varchar(255) not null,
    PASSWORD varchar(255) not null,
    INFO int not null unique,
    "ROLE" int not null,
    constraint PK_USER primary key (EMAIL),
    constraint FK_USER_INFO foreign key (INFO) references USERINFO(ID),
    constraint FK_USER_ROLE foreign key ("ROLE") references ROLES(ID),
    constraint UK_USER_ID unique(ID)
);

create table "ORDER" (
    ID int generated always as identity (start with 1, increment by 1),
    "USER" int not null,
    CREATED timestamp not null,
    constraint PK_ORDER primary key (ID),
    constraint FK_ORDER_USER foreign key ("USER") references "USER"(ID)
);

create table SUPPLIER (
    ID int generated always as identity (start with 1, increment by 1),
    "NAME" varchar(255) not null,
    ADDRESS varchar(255),
    PHONE varchar(255) not null,
    REPRESENTATIVE varchar(255),
    constraint UK_ID_SUPPLIER unique(ID),
    constraint PK_SUPPLIER primary key ("NAME")
);

create table PRODUCT (
    ID int generated always as identity (start with 1, increment by 1),
    CODE varchar(255) not null,
    TITLE varchar(255) not null,
    SUPPLIER int not null,
    INITIAL_PRICE double not null,
    RETAIL_VALUE double not null,
    constraint UK_ID_PRODUCT unique(ID),
    constraint PK_PRODUCT primary key (CODE),
    constraint FK_PRODUCT_SUPPLIER foreign key (SUPPLIER) references SUPPLIER(ID)
);

create table ORDER2PRODUCT (
    "ORDER" int not null,
    PRODUCT int not null,
    constraint PK_ORDER2PRODUCT primary key("ORDER", PRODUCT),
    constraint FK_OREDER2PRODUCT_ORDER foreign key ("ORDER") references "ORDER"(ID),
    constraint FK_OREDER2PRODUCT_PRODUCT foreign key (PRODUCT) references PRODUCT(ID)
);

insert into ROLES values(1, 'USER'),
                        (2, 'ADMIN'),
                        (3, 'GUEST');

insert into USERINFO ( "NAME", SURNAME) values  ('Oleg', 'Ivanov'),
                                                ('Denis', 'Chebushev'),
                                                ('Steven', 'Spielberg');

insert into "USER" (EMAIL, PASSWORD, INFO, "ROLE") 
            values  ('ivanov@gmail.com', 'passWord1', 1, 1),
                    ('cheb1832@mail.ru', '1q2w3e4r5tCHEB!', 2, 3),
                    ('nemoeKino@yandex.ru', 'SS12qwaszx', 3, 2);

insert into "ORDER" ("USER", CREATED) values    (1, '2019-03-17 15:52:25'),
                                                (3, '2019-04-10 17:44:14'),
                                                (3, '2019-05-04 11:55:08');

insert into SUPPLIER ("NAME", ADDRESS, PHONE, REPRESENTATIVE)
            values ('John', null, '555-325-17', 'yes'),
                   ('Alex', 'SPb', '812-845-22-12', 'yes'),
                   ('Steve', null, '421-3452', 'no');

insert into PRODUCT (CODE, TITLE, SUPPLIER, INITIAL_PRICE, RETAIL_VALUE)
            values ('123125355', 'майонез', 3, 57.0, 89.99),
                   ('364323362', 'хлеб', 1, 20., 45.),
                   ('124157975', 'батон', 1, 15., 38.);

insert into ORDER2PRODUCT values (1, 1),
                                 (1, 2),
                                 (3, 3);

/*
select "USER".ID,
       EMAIL,
       PASSWORD,
       USERINFO."NAME",
       USERINFO.SURNAME,
       ROLES."NAME"
from "USER" 
join USERINFO on "USER".INFO = USERINFO.ID
join ROLES on "USER"."ROLE" = ROLES.ID;
*/