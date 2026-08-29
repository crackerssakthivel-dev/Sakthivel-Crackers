-- =====================================================
-- SAKTHIVEL CRACKERS
-- SUPABASE DATABASE SCHEMA
-- Location:
-- Kundayiruppu, Sivakasi, Tamil Nadu, India
-- =====================================================

create extension if not exists "uuid-ossp";

-- =====================================================
-- ADMIN PROFILES
-- =====================================================

create table if not exists admin_profiles (
    id uuid primary key default uuid_generate_v4(),
    user_id uuid unique not null references auth.users(id) on delete cascade,
    full_name text,
    email text,
    active boolean default true,
    created_at timestamptz default now()
);

-- =====================================================
-- SETTINGS
-- =====================================================

create table if not exists settings (
    id uuid primary key default uuid_generate_v4(),

    shop_name text default 'SAKTHIVEL CRACKERS',
    address text default 'Kundayiruppu, Sivakasi, Tamil Nadu, India',

    whatsapp text default '9344265054',
    whatsapp_cc text default '919344265054',

    email text,
    phone text,

    logo_url text,

    primary_color text default '#0B1F3A',
    secondary_color text default '#B22222',
    accent_color text default '#FFD700',

    seo_title text default 'SAKTHIVEL CRACKERS - Kundayiruppu, Sivakasi',
    seo_description text default 'Premium Sivakasi Fireworks Ordering Website',

    created_at timestamptz default now(),
    updated_at timestamptz default now()
); 
-- =====================================================
-- CATEGORIES
-- =====================================================

create table if not exists categories (
    id bigserial primary key,

    name text not null unique,
    slug text unique,

    image_url text,
    icon text,

    active boolean default true,

    display_order integer default 0,

    created_at timestamptz default now(),
    updated_at timestamptz default now()
);
-- =====================================================
-- PRODUCTS
-- =====================================================

create table if not exists products (
    id bigserial primary key,

    category_id bigint
    references categories(id)
    on delete restrict,

    name text not null,
    slug text unique,

    description text,

    unit text not null,

    mrp numeric(10,2) not null default 0,

    offer_price numeric(10,2),

    discount numeric(10,2) default 0,

    image_url text,

    availability text
    default 'AVAILABLE'
    check (
        availability in (
            'AVAILABLE',
            'UNAVAILABLE'
        )
    ),

    featured boolean default false,
    popular boolean default false,
    active boolean default true,

    display_order integer default 0,

    created_at timestamptz default now(),
    updated_at timestamptz default now()
);
-- =====================================================
-- BANNERS
-- =====================================================

create table if not exists banners (
    id bigserial primary key,

    title text,
    subtitle text,

    image_url text,

    button_text text,
    button_link text,

    active boolean default true,

    display_order integer default 0,

    created_at timestamptz default now()
);
-- =====================================================
-- OFFERS
-- =====================================================

create table if not exists offers (
    id bigserial primary key,

    title text not null,
    description text,

    image_url text,

    start_date date,
    end_date date,

    cta_text text,
    cta_link text,

    active boolean default true,

    display_order integer default 0,

    created_at timestamptz default now()
); 

-- =====================================================
-- ORDERS
-- =====================================================

create table if not exists orders (
    id bigserial primary key,

    order_number text unique not null,

    customer_name text not null,

    mobile text not null,

    address text not null,

    district text,

    pincode text,

    notes text,

    total_amount numeric(10,2) not null,

    status text
    default 'PENDING'
    check (
        status in (
            'PENDING',
            'CONFIRMED',
            'CANCELLED'
        )
    ),

    created_at timestamptz default now(),
    updated_at timestamptz default now()
);
-- =====================================================
-- ORDER ITEMS
-- =====================================================

create table if not exists order_items (
    id bigserial primary key,

    order_id bigint
    references orders(id)
    on delete cascade,

    product_id bigint,

    product_name text not null,

    unit text,

    quantity integer not null,

    price numeric(10,2) not null,

    subtotal numeric(10,2) not null,

    created_at timestamptz default now()
);
-- =====================================================
-- PRICE LISTS
-- =====================================================

create table if not exists price_lists (
    id bigserial primary key,

    title text default 'Price List',

    file_url text,

    active boolean default true,

    button_text text default 'Download Price List',

    created_at timestamptz default now()
); 

-- =====================================================
-- INDEXES
-- =====================================================

create index if not exists idx_products_category
on products(category_id);

create index if not exists idx_products_name
on products(name);

create index if not exists idx_orders_mobile
on orders(mobile);

create index if not exists idx_orders_status
on orders(status);

create index if not exists idx_order_items_order
on order_items(order_id); 
-- =====================================================
-- ORDER NUMBER FUNCTION
-- Format:
-- SV-2026-000001
-- =====================================================

create or replace function generate_order_number()
returns text
language plpgsql
as $$
declare
    next_id bigint;
begin

    select coalesce(max(id),0)+1
    into next_id
    from orders;

    return
    'SV-' ||
    extract(year from now()) ||
    '-' ||
    lpad(next_id::text,6,'0');

end;
$$;
-- =====================================================
-- STORAGE BUCKETS
-- Create in Supabase Dashboard
--
-- logos
-- product-images
-- category-images
-- banner-images
-- offer-images
-- price-lists
-- =====================================================
-- =====================================================
-- INITIAL CATEGORIES
-- =====================================================

insert into categories
(name, slug, display_order)
values

('ONE SOUND CRACKERS','one-sound-crackers',1),

('FLOWER POTS','flower-pots',2),

('GROUND CHAKKAR','ground-chakkar',3),

('BIJILI PATTAS','bijili-pattas',4),

('MULTI SOUND','multi-sound',5),

('TWINKLING STAR','twinkling-star',6),

('BOMB','bomb',7),

('ROCKETS','rockets',8),

('PENCIL TORCHES','pencil-torches',9),

('PAPER BOMB','paper-bomb',10),

('NEW FANCY ITEMS','new-fancy-items',11),

('FANCY ITEMS','fancy-items',12),

('MULTI SHOT FANCY','multi-shot-fancy',13),

('SINGLE SHOT FANCY','single-shot-fancy',14),

('SPARKLERS','sparklers',15),

('GIFT BOX','gift-box',16);

insert into products
(category_id,name,unit,mrp,active)
values

-- ONE SOUND CRACKERS

(1,'Gold Lakshmi','1 Pkt',20,true),
(1,'2¾” Kuruvi','1 Pkt',6,true),
(1,'3½” Lakshmi','1 Pkt',10,true),
(1,'4” Lakshmi','1 Pkt',15,true),
(1,'5” Jallikattu','1 Pkt',35,true),
(1,'5” Lion & Hulk','1 Pkt',40,true),
(1,'4” Lakshmi DLX','1 Pkt',30,true),

-- FLOWER POTS

(2,'Flower Big','1 Box',60,true),
(2,'Flower SPL','1 Box',80,true),
(2,'Flower Ashoka','1 Box',110,true),
(2,'Colour Koti','1 Box',180,true),
(2,'Colour Koti DLX','1 Box',250,true),
(2,'Tri Colour (5 Pcs)','1 Box',250,true),

-- GROUND CHAKKAR

(3,'Disco Wheel','1 Box',80,true),
(3,'Chakkar Big','1 Box',60,true),
(3,'Chakkar SPL','1 Box',100,true),
(3,'Chakkar DLX','1 Box',150,true),
(3,'4×4 Wheel Chakkar','1 Box',180,true),
(3,'Wire Chakkar','1 Box',180,true),
(3,'Wheeling Show','1 Box',220,true),

-- BIJILI PATTAS

(4,'Red Bijili','1 Pkt',25,true),
(4,'Stripped Bijili','1 Pkt',30,true),

-- MULTI SOUND

(5,'50 DLX','1 Pkt',120,true),
(5,'100 DLX','1 Pkt',190,true),
(5,'28 Giant','1 Pkt',40,true),
(5,'56 Giant','1 Pkt',60,true),
(5,'100 Wala','1 Box',50,true),
(5,'1000 Wala','1 Box',150,true),
(5,'2000 Wala','1 Box',300,true),
(5,'5000 Wala','1 Box',600,true),
(5,'10000 Wala','1 Box',1200,true),

-- TWINKLING STAR

(6,'1½” Twinkling Star','1 Box',60,true),
(6,'4” Twinkling Star','1 Box',100,true),

-- BOMB

(7,'Hydro Bomb','1 Box',80,true),
(7,'King Of King','1 Box',100,true),
(7,'Bullet Bomb','1 Box',30,true),
(7,'Classic Bomb','1 Box',150,true),
(7,'Digital Bomb','1 Box',220,true),

-- ROCKETS

(8,'Rocket Bomb','1 Box',100,true),
(8,'Lunik Rocket','1 Box',150,true),
(8,'Musical Rocket','1 Box',150,true),

-- PENCIL TORCHES

(9,'Fire Pencil','1 Box',120,true),
(9,'Flash Light','1 Box',180,true),
(9,'Water Pencil','1 Box',190,true),
(9,'3 Pcs Pencil','1 Box',220,true),

-- PAPER BOMB

(10,'¼ Adiyal','1 Box',35,true),
(10,'½ Adiyal','1 Box',70,true),
(10,'1 Kg Adiyal','1 Box',140,true),
(10,'10 Pcs Adiyal','1 Box',300,true),

-- NEW FANCY ITEMS

(11,'Butterfly','1 Box',120,true),
(11,'Bambaram','1 Box',120,true),
(11,'Money Bank','1 Box',150,true),
(11,'Hanuman Katha','1 Box',200,true),
(11,'Drone','1 Box',100,true),
(11,'Old Is Gold','1 Box',150,true),
(11,'Naruto Siren','1 Box',160,true),
(11,'Dora Singer','1 Box',180,true),
(11,'Cylinder Smoke Bomb (2 Pcs)','1 Box',310,true),
(11,'Kulfi Fountain (3 Pcs)','1 Box',310,true),
(11,'2 Pcs Cracking Fountain','1 Box',250,true),
(11,'Festival Cracking (3 Pcs)','1 Box',350,true),

-- FANCY ITEMS

(12,'Jungle Beat Fountain','1 Box',150,true),
(12,'T-Rex Egg','1 Box',200,true),
(12,'Thirumalaa’s Shower Fountain (5 Pcs)','1 Box',220,true),
(12,'Madurai Malli Fountain (3 Pcs)','1 Box',220,true);
insert into products
(category_id,name,unit,mrp,active)
values

-- FANCY ITEMS CONTINUED

(12,'Colour Smoke (3 Pcs)','1 Box',180,true),
(12,'Helicopter','1 Box',60,true),
(12,'Lolli Pop','1 Box',190,true),
(12,'Photo Flash','1 Box',60,true),
(12,'Chota Fancy','1 Box',35,true),
(12,'Kit Kat','1 Box',60,true),
(12,'Siren (5 Pcs)','1 Box',180,true),
(12,'Penta Sky Shot (5 Pcs)','1 Box',250,true),
(12,'90 Watts','1 Box',200,true),
(12,'Gun Fountain','1 Box',200,true),
(12,'Tin Fountain','1 Box',120,true),
(12,'Car Fountain','1 Box',190,true),
(12,'Murugan Vel Fountain','1 Box',190,true),
(12,'Peacock','1 Box',150,true),
(12,'Bada Peacock','1 Box',350,true),
(12,'Self Stick','1 Box',160,true),
(12,'Toys Shower Fountain','1 Box',140,true),
(12,'Top Gun','1 Box',210,true),
(12,'Water Queen Fountain','1 Box',190,true),

-- MULTI SHOT FANCY

(13,'12 Shot','1 Box',150,true),
(13,'15 Shot','1 Box',280,true),
(13,'15 Smoke Shot','1 Box',400,true),
(13,'25 Cracking Shot','1 Box',400,true),
(13,'30 Peacock Shot','1 Box',400,true),
(13,'30 Shot Multi Colour','1 Box',350,true),
(13,'60 Shot Multi Colour','1 Box',700,true),
(13,'120 Shot Multi Colour','1 Box',1400,true),
(13,'240 Shot Multi Colour','1 Box',2800,true),
(13,'5×5 Cracking Shot','1 Box',700,true),
(13,'10×10 Cracking Shot','1 Box',3000,true),

-- SINGLE SHOT FANCY

(14,'2” Fancy','1 Box',100,true),
(14,'2” Fancy (3 Pcs)','1 Box',240,true),
(14,'3½” Fancy','1 Box',280,true),
(14,'4½” Fancy','1 Box',350,true),
(14,'3½” Double Ball','1 Box',350,true),
(14,'3½” Nayagara Falls','1 Box',350,true),
(14,'3” Fancy (2 Pcs)','1 Box',800,true),
(14,'5” Fancy (2 Pcs)','1 Box',1400,true),
(14,'7 Shot','1 Box',120,true),

-- SPARKLERS

(15,'Rotating Sparklers','1 Box',250,true),
(15,'50cm ELE','1 Box',200,true),
(15,'50cm Colour','1 Box',220,true),
(15,'30cm ELE','1 Box',55,true),
(15,'30cm Colour','1 Box',55,true),
(15,'30cm Red','1 Box',60,true),
(15,'30cm Green','1 Box',60,true),
(15,'15cm ELE','1 Box',55,true),
(15,'15cm Colour','1 Box',55,true),
(15,'15cm Red','1 Box',60,true),
(15,'15cm Green','1 Box',60,true),
(15,'10cm ELE','1 Box',15,true),
(15,'10cm Colour','1 Box',15,true),
(15,'10cm Red','1 Box',20,true),
(15,'10cm Green','1 Box',20,true),
(15,'7cm ELE','1 Box',8,true),
(15,'7cm Colour','1 Box',8,true),
(15,'7cm Red','1 Box',10,true),
(15,'7cm Green','1 Box',10,true),

-- GIFT BOX

(16,'25 Item Box','1 Box',400,true),
(16,'30 Item Box','1 Box',500,true),
(16,'36 Item Box','1 Box',600,true),
(16,'41 Item Box','1 Box',750,true),
(16,'50 Item Box','1 Box',900,true),
(16,'60 Item Box','1 Box',1000,true),
(16,'70 Item Box','1 Box',1200,true);
create or replace function update_timestamp()
returns trigger
language plpgsql
as $$
begin
    new.updated_at = now();
    return new;
end;
$$;
create trigger trg_products_updated
before update on products
for each row
execute function update_timestamp();

create trigger trg_categories_updated
before update on categories
for each row
execute function update_timestamp();

create trigger trg_orders_updated
before update on orders
for each row
execute function update_timestamp();

create trigger trg_settings_updated
before update on settings
for each row
execute function update_timestamp();
create or replace function calculate_discount()
returns trigger
language plpgsql
as $$
begin

if new.offer_price is not null
and new.offer_price > 0
then

new.discount :=
round(
(
(new.mrp - new.offer_price)
/
new.mrp
) * 100,
2
);

else

new.discount := 0;

end if;

return new;

end;
$$;
create trigger trg_discount
before insert or update
on products
for each row
execute function calculate_discount();
insert into settings
(
shop_name,
address,
whatsapp,
whatsapp_cc,
seo_title,
seo_description
)
values
(
'SAKTHIVEL CRACKERS',
'Kundayiruppu, Sivakasi, Tamil Nadu, India',
'9344265054',
'919344265054',
'SAKTHIVEL CRACKERS - Kundayiruppu, Sivakasi',
'Premium Fireworks Ordering Website'
);
insert into banners
(
title,
subtitle,
button_text,
button_link,
active,
display_order
)
values
(
'Premium Sivakasi Fireworks',
'Order Direct From SAKTHIVEL CRACKERS',
'Shop Now',
'#products',
true,
1
);
alter table products enable row level security;
alter table categories enable row level security;
alter table orders enable row level security;
alter table order_items enable row level security;
alter table banners enable row level security;
alter table offers enable row level security;
alter table settings enable row level security;
alter table price_lists enable row level security;
alter table admin_profiles enable row level security;
create policy products_public_read
on products
for select
using (active = true);

create policy categories_public_read
on categories
for select
using (active = true);

create policy banners_public_read
on banners
for select
using (active = true);

create policy offers_public_read
on offers
for select
using (active = true);

create policy settings_public_read
on settings
for select
using (true);

create policy pricelist_public_read
on price_lists
for select
using (active = true);
create policy orders_insert
on orders
for insert
with check (true);

create policy order_items_insert
on order_items
for insert
with check (true);
create or replace function is_admin()
returns boolean
language sql
stable
as $$
select exists (
    select 1
    from admin_profiles
    where user_id = auth.uid()
    and active = true
);
$$; 
create policy admin_products_all
on products
for all
using (is_admin())
with check (is_admin());

create policy admin_categories_all
on categories
for all
using (is_admin())
with check (is_admin());

create policy admin_orders_all
on orders
for all
using (is_admin())
with check (is_admin());

create policy admin_order_items_all
on order_items
for all
using (is_admin())
with check (is_admin());

create policy admin_banners_all
on banners
for all
using (is_admin())
with check (is_admin());

create policy admin_offers_all
on offers
for all
using (is_admin())
with check (is_admin());

create policy admin_settings_all
on settings
for all
using (is_admin())
with check (is_admin());

create policy admin_price_lists_all
on price_lists
for all
using (is_admin())
with check (is_admin());


