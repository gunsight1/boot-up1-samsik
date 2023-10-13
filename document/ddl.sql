create table country
(
    id            int auto_increment
        primary key,
    name          varchar(64)                        not null,
    currency      varchar(3)                         null,
    exchange_rate double                             not null,
    created_at    datetime default CURRENT_TIMESTAMP null,
    updated_at    datetime default CURRENT_TIMESTAMP null,
    deleted_at    datetime                           null
);

create table member
(
    id           int auto_increment
        primary key,
    email        varchar(128)                       not null,
    password     varchar(64)                        not null,
    phone_number varchar(13)                        null,
    country_id   int                                null,
    created_at   datetime default CURRENT_TIMESTAMP null,
    updated_at   datetime default CURRENT_TIMESTAMP null,
    deleted_at   datetime                           null,
    constraint member_country_id_fk
        foreign key (country_id) references country (id)
)
    comment '예약';

create index member_email_index
    on member (email);

create table store
(
    id             int auto_increment
        primary key,
    store_name     varchar(126)                       not null,
    number_of_seat int                                null,
    location       geometry                           null,
    open_hour      time                               null,
    close_hour     time                               null,
    phone_number   varchar(13)                        null,
    is_parking     tinyint(1)                         null,
    category       varchar(10)                        null,
    store_photo    text                               null,
    sitting_option varchar(10)                        null,
    description    text                               null,
    is_reservation tinyint(1)                         null,
    created_at     datetime default CURRENT_TIMESTAMP null,
    updated_at     datetime default CURRENT_TIMESTAMP null,
    deleted_at     datetime default CURRENT_TIMESTAMP null
);

create table menu
(
    id          int auto_increment
        primary key,
    name        varchar(64) null,
    store_id    int         null,
    picture_url text        null,
    price       double      null,
    created_at  datetime    null,
    updated_at  datetime    null,
    deleted_at  datetime    null,
    constraint menu_store_id_fk
        foreign key (store_id) references store (id)
);

create table menu_review
(
    id          int auto_increment
        primary key,
    member_id   int                                null,
    menu_id     int                                null,
    picture_url text                               null,
    review      int                                null,
    point       int                                null,
    created_at  datetime default CURRENT_TIMESTAMP null,
    updated_at  datetime default CURRENT_TIMESTAMP null,
    deleted_at  datetime                           null,
    constraint menu_review_member_id_fk
        foreign key (member_id) references member (id),
    constraint menu_review_menu_id_fk
        foreign key (menu_id) references menu (id)
);

create table reservation
(
    id              int auto_increment comment 'id'
        primary key,
    member_id       int                                null,
    store_id        int                                null,
    member_of_guest int                                null,
    reserv_status   varchar(6)                         null,
    reserv_start    datetime                           null,
    reserv_finish   datetime                           null,
    created_at      datetime default CURRENT_TIMESTAMP null,
    updated_at      datetime default CURRENT_TIMESTAMP null,
    constraint reservation_member_id_fk
        foreign key (member_id) references member (id),
    constraint reservation_store_id_fk
        foreign key (store_id) references store (id)
);

create table reservation_menu
(
    id             int auto_increment
        primary key,
    reservation_id int                                null,
    menu_id        int                                null,
    menu_count     int                                null,
    created_at     datetime default CURRENT_TIMESTAMP null,
    updated_at     datetime default CURRENT_TIMESTAMP null,
    constraint reservation_menu_reservation_id_fk
        foreign key (reservation_id) references reservation (id)
);

create index store__index
    on store (store_name);

create table store_country_count
(
    id          int auto_increment
        primary key,
    store_id    int      null,
    country_id  int      null,
    visit_count int      null,
    created_at  datetime null,
    updated_at  datetime null,
    constraint store_country_count_country_id_fk
        foreign key (country_id) references country (id),
    constraint store_country_count_store_id_fk
        foreign key (store_id) references store (id)
);

create table store_owner_member
(
    id           int auto_increment
        primary key,
    email        varchar(128)                       not null,
    password     varchar(64)                        not null,
    phone_number varchar(13)                        null,
    created_at   datetime default CURRENT_TIMESTAMP null,
    updated_at   datetime default CURRENT_TIMESTAMP null,
    deleted_at   datetime                           null
)
    comment '예약';

create index store_owner_memger_email_index
    on store_owner_member (email);

create table store_review
(
    id          int auto_increment
        primary key,
    user_id     int                                null,
    store_id    int                                null,
    picture_url text                               null,
    point       int                                null,
    review      text                               null,
    created_at  datetime default CURRENT_TIMESTAMP null,
    updated_at  datetime default CURRENT_TIMESTAMP null,
    deleted_at  datetime default CURRENT_TIMESTAMP null,
    constraint store_review_member_id_fk
        foreign key (user_id) references member (id),
    constraint store_review_store_id_fk
        foreign key (store_id) references store (id)
);

create table storeowner_member_store
(
    store_id              int not null,
    store_owner_member_id int not null,
    primary key (store_id, store_owner_member_id),
    constraint storeowner_member_store_store_id_fk
        foreign key (store_id) references store (id),
    constraint storeowner_member_store_store_owner_member_id_fk
        foreign key (store_owner_member_id) references store_owner_member (id)
);

create table tag
(
    id         int auto_increment
        primary key,
    store_id   int                                null,
    type       varchar(16)                        null,
    value      varchar(64)                        null,
    created_at datetime default CURRENT_TIMESTAMP null,
    updated_at datetime default CURRENT_TIMESTAMP null,
    deleted_at int                                null,
    constraint tag_store_id_fk
        foreign key (store_id) references store (id)
);

