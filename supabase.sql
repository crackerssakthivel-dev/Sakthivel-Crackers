-- ============================================================
-- SAKTHIVEL CRACKERS
-- COMPLETE SUPABASE DATABASE
-- ============================================================
-- Business:
-- SAKTHIVEL CRACKERS
-- Kundayiruppu, Sivakasi, Tamil Nadu, India
-- WhatsApp: 93442 65054
--
-- IMPORTANT:
-- 1. Run this entire file in Supabase SQL Editor.
-- 2. NEVER put SUPABASE_SERVICE_ROLE_KEY in browser code.
-- 3. Customer ordering is handled through secure RPC functions.
-- 4. Customer tracking is handled through secure RPC functions.
-- 5. Admin authorization is controlled by admin_profiles.
-- ============================================================

create extension if not exists pgcrypto;

-- ============================================================
-- 1. CATEGORIES
-- ============================================================

create table if not exists public.categories (
    id uuid primary key default gen_random_uuid(),
    name text not null unique,
    slug text not null unique,
    image_url text,
    icon text default '🎆',
    active boolean not null default true,
    display_order integer not null default 0,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

-- ============================================================
-- 2. PRODUCTS
-- ============================================================

create table if not exists public.products (
    id uuid primary key default gen_random_uuid(),
    name text not null unique,
    slug text not null unique,
    category_id uuid not null references public.categories(id) on delete restrict,
    description text,
    unit text not null,
    mrp numeric(12,2) not null check (mrp >= 0),
    offer_price numeric(12,2),
    discount numeric(6,2) not null default 0,
    image_url text,
    availability text not null default 'AVAILABLE'
        check (availability in ('AVAILABLE','UNAVAILABLE')),
    featured boolean not null default false,
    popular boolean not null default false,
    active boolean not null default true,
    display_order integer not null default 0,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now(),
    constraint products_offer_price_check
        check (offer_price is null or offer_price >= 0)
);

-- ============================================================
-- 3. BANNERS
-- ============================================================

create table if not exists public.banners (
    id uuid primary key default gen_random_uuid(),
    image_url text,
    title text,
    subtitle text,
    button_text text,
    button_link text,
    active boolean not null default true,
    display_order integer not null default 0,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

-- ============================================================
-- 4. OFFERS
-- ============================================================

create table if not exists public.offers (
    id uuid primary key default gen_random_uuid(),
    title text not null,
    description text,
    image_url text,
    start_date date,
    end_date date,
    active boolean not null default true,
    display_order integer not null default 0,
    cta_text text,
    cta_link text,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

-- ============================================================
-- 5. PRICE LISTS
-- ============================================================

create table if not exists public.price_lists (
    id uuid primary key default gen_random_uuid(),
    title text not null default 'PRICE LIST',
    file_url text not null,
    file_path text,
    file_name text,
    active boolean not null default true,
    button_text text not null default 'DOWNLOAD PRICE LIST PDF',
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

-- ============================================================
-- 6. WEBSITE SETTINGS
-- Single settings row.
-- ============================================================

create table if not exists public.settings (
    id integer primary key default 1 check (id = 1),

    shop_name text not null
        default 'SAKTHIVEL CRACKERS',

    address text not null
        default 'Kundayiruppu, Sivakasi, Tamil Nadu, India',

    whatsapp text not null
        default '93442 65054',

    whatsapp_cc text not null
        default '919344265054',

    phone text
        default '93442 65054',

    email text,

    logo_url text,

    footer_text text
        default 'SAKTHIVEL CRACKERS — Kundayiruppu, Sivakasi',

    primary_color text
        default '#07152E',

    secondary_color text
        default '#B3132B',

    accent_color text
        default '#F4C542',

    gold_color text
        default '#F6D365',

    background_image_url text,

    seo_title text
        default 'SAKTHIVEL CRACKERS — Kundayiruppu, Sivakasi',

    seo_description text
        default 'Premium fireworks ordering website for SAKTHIVEL CRACKERS, Kundayiruppu, Sivakasi.',

    show_price_list boolean not null default true,
    show_offers boolean not null default true,
    show_contact boolean not null default true,
    show_whatsapp boolean not null default true,
    show_categories boolean not null default true,
    show_featured boolean not null default true,
    show_popular boolean not null default true,

    social_links jsonb not null default '{}'::jsonb,

    updated_at timestamptz not null default now()
);

-- ============================================================
-- 7. ADMIN AUTHORIZATION
-- ============================================================

create table if not exists public.admin_profiles (
    user_id uuid primary key references auth.users(id) on delete cascade,
    is_admin boolean not null default true,
    created_at timestamptz not null default now()
);

-- ============================================================
-- 8. ORDERS
-- ============================================================

create table if not exists public.orders (
    id uuid primary key default gen_random_uuid(),

    order_number text not null unique,

    customer_name text not null,

    mobile text not null,

    address text not null,

    district text not null,

    pincode text not null,

    notes text,

    total_amount numeric(12,2) not null
        check (total_amount >= 0),

    status text not null default 'PENDING'
        check (status in ('PENDING','CONFIRMED','CANCELLED')),

    created_at timestamptz not null default now(),

    updated_at timestamptz not null default now()
);

-- ============================================================
-- 9. ORDER ITEMS
-- Snapshot fields are intentionally stored so old orders
-- do not change when products are edited later.
-- ============================================================

create table if not exists public.order_items (
    id uuid primary key default gen_random_uuid(),

    order_id uuid not null
        references public.orders(id)
        on delete cascade,

    product_id uuid
        references public.products(id)
        on delete set null,

    product_name text not null,

    quantity integer not null
        check (quantity > 0),

    unit text not null,

    price numeric(12,2) not null
        check (price >= 0),

    subtotal numeric(12,2) not null
        check (subtotal >= 0)
);

-- ============================================================
-- 10. INDEXES
-- ============================================================

create index if not exists idx_categories_active_order
on public.categories(active, display_order);

create index if not exists idx_products_category
on public.products(category_id);

create index if not exists idx_products_active
on public.products(active);

create index if not exists idx_products_availability
on public.products(availability);

create index if not exists idx_products_featured
on public.products(featured);

create index if not exists idx_products_popular
on public.products(popular);

create index if not exists idx_products_display_order
on public.products(display_order);

create index if not exists idx_orders_mobile
on public.orders(mobile);

create index if not exists idx_orders_status
on public.orders(status);

create index if not exists idx_orders_created_at
on public.orders(created_at desc);

create index if not exists idx_order_items_order_id
on public.order_items(order_id);

-- ============================================================
-- 11. SETTINGS SEED
-- ============================================================

insert into public.settings (
    id,
    shop_name,
    address,
    whatsapp,
    whatsapp_cc,
    phone,
    seo_title,
    seo_description
)
values (
    1,
    'SAKTHIVEL CRACKERS',
    'Kundayiruppu, Sivakasi, Tamil Nadu, India',
    '93442 65054',
    '919344265054',
    '93442 65054',
    'SAKTHIVEL CRACKERS — Kundayiruppu, Sivakasi',
    'Premium fireworks ordering website for SAKTHIVEL CRACKERS, Kundayiruppu, Sivakasi.'
)
on conflict (id) do update set
    shop_name = excluded.shop_name,
    address = excluded.address,
    whatsapp = excluded.whatsapp,
    whatsapp_cc = excluded.whatsapp_cc,
    phone = excluded.phone,
    seo_title = excluded.seo_title,
    seo_description = excluded.seo_description;

-- ============================================================
-- 12. CATEGORY SEED
-- EXACTLY 16 INITIAL CATEGORIES
-- ============================================================

insert into public.categories
(name, slug, icon, display_order)
values
('ONE SOUND CRACKERS','one-sound-crackers','🎆',1),
('FLOWER POTS','flower-pots','🌸',2),
('GROUND CHAKKAR','ground-chakkar','🌀',3),
('BIJILI PATTAS','bijili-pattas','💥',4),
('MULTI SOUND','multi-sound','🎇',5),
('TWINKLING STAR','twinkling-star','⭐',6),
('BOMB','bomb','💣',7),
('ROCKETS','rockets','🚀',8),
('PENCIL TORCHES','pencil-torches','🔥',9),
('PAPER BOMB','paper-bomb','💥',10),
('NEW FANCY ITEMS','new-fancy-items','✨',11),
('FANCY ITEMS','fancy-items','🎆',12),
('MULTI SHOT FANCY','multi-shot-fancy','🎇',13),
('SINGLE SHOT FANCY','single-shot-fancy','💫',14),
('SPARKLERS','sparklers','✨',15),
('GIFT BOX','gift-box','🎁',16)
on conflict (name) do update set
    slug = excluded.slug,
    display_order = excluded.display_order,
    icon = excluded.icon;

-- ============================================================
-- 13. PRODUCT SEED
-- EXACTLY 130 INITIAL PRODUCTS
-- ============================================================

with seed(
    category_name,
    product_name,
    unit,
    price,
    product_order
) as (
values

('ONE SOUND CRACKERS','Gold Lakshmi','1 Pkt',20,1),
('ONE SOUND CRACKERS','2¾” Kuruvi','1 Pkt',6,2),
('ONE SOUND CRACKERS','3½” Lakshmi','1 Pkt',10,3),
('ONE SOUND CRACKERS','4” Lakshmi','1 Pkt',15,4),
('ONE SOUND CRACKERS','5” Jallikattu','1 Pkt',35,5),
('ONE SOUND CRACKERS','5” Lion & Hulk','1 Pkt',40,6),
('ONE SOUND CRACKERS','4” Lakshmi DLX','1 Pkt',30,7),

('FLOWER POTS','Flower Big','1 Box',60,8),
('FLOWER POTS','Flower SPL','1 Box',80,9),
('FLOWER POTS','Flower Ashoka','1 Box',110,10),
('FLOWER POTS','Colour Koti','1 Box',180,11),
('FLOWER POTS','Colour Koti DLX','1 Box',250,12),
('FLOWER POTS','Tri Colour (5 Pcs)','1 Box',250,13),

('GROUND CHAKKAR','Disco Wheel','1 Box',80,14),
('GROUND CHAKKAR','Chakkar Big','1 Box',60,15),
('GROUND CHAKKAR','Chakkar SPL','1 Box',100,16),
('GROUND CHAKKAR','Chakkar DLX','1 Box',150,17),
('GROUND CHAKKAR','4×4 Wheel Chakkar','1 Box',180,18),
('GROUND CHAKKAR','Wire Chakkar','1 Box',180,19),
('GROUND CHAKKAR','Wheeling Show','1 Box',220,20),

('BIJILI PATTAS','Red Bijili','1 Pkt',25,21),
('BIJILI PATTAS','Stripped Bijili','1 Pkt',30,22),

('MULTI SOUND','50 DLX','1 Pkt',120,23),
('MULTI SOUND','100 DLX','1 Pkt',190,24),
('MULTI SOUND','28 Giant','1 Pkt',40,25),
('MULTI SOUND','56 Giant','1 Pkt',60,26),
('MULTI SOUND','100 Wala','1 Box',50,27),
('MULTI SOUND','1000 Wala','1 Box',150,28),
('MULTI SOUND','2000 Wala','1 Box',300,29),
('MULTI SOUND','5000 Wala','1 Box',600,30),
('MULTI SOUND','10000 Wala','1 Box',1200,31),

('TWINKLING STAR','1½” Twinkling Star','1 Box',60,32),
('TWINKLING STAR','4” Twinkling Star','1 Box',100,33),

('BOMB','Hydro Bomb','1 Box',80,34),
('BOMB','King Of King','1 Box',100,35),
('BOMB','Bullet Bomb','1 Box',30,36),
('BOMB','Classic Bomb','1 Box',150,37),
('BOMB','Digital Bomb','1 Box',220,38),

('ROCKETS','Rocket Bomb','1 Box',100,39),
('ROCKETS','Lunik Rocket','1 Box',150,40),
('ROCKETS','Musical Rocket','1 Box',150,41),

('PENCIL TORCHES','Fire Pencil','1 Box',120,42),
('PENCIL TORCHES','Flash Light','1 Box',180,43),
('PENCIL TORCHES','Water Pencil','1 Box',190,44),
('PENCIL TORCHES','3 Pcs Pencil','1 Box',220,45),

('PAPER BOMB','¼ Adiyal','1 Box',35,46),
('PAPER BOMB','½ Adiyal','1 Box',70,47),
('PAPER BOMB','1 Kg Adiyal','1 Box',140,48),
('PAPER BOMB','10 Pcs Adiyal','1 Box',300,49),

('NEW FANCY ITEMS','Butterfly','1 Box',120,50),
('NEW FANCY ITEMS','Bambaram','1 Box',120,51),
('NEW FANCY ITEMS','Money Bank','1 Box',150,52),
('NEW FANCY ITEMS','Hanuman Katha','1 Box',200,53),
('NEW FANCY ITEMS','Drone','1 Box',100,54),
('NEW FANCY ITEMS','Old Is Gold','1 Box',150,55),
('NEW FANCY ITEMS','Naruto Siren','1 Box',160,56),
('NEW FANCY ITEMS','Dora Singer','1 Box',180,57),
('NEW FANCY ITEMS','Cylinder Smoke Bomb (2 Pcs)','1 Box',310,58),
('NEW FANCY ITEMS','Kulfi Fountain (3 Pcs)','1 Box',310,59),
('NEW FANCY ITEMS','2 Pcs Cracking Fountain','1 Box',250,60),
('NEW FANCY ITEMS','Festival Cracking (3 Pcs)','1 Box',350,61),

('FANCY ITEMS','Jungle Beat Fountain','1 Box',150,62),
('FANCY ITEMS','T-Rex Egg','1 Box',200,63),
('FANCY ITEMS','Thirumalaa’s Shower Fountain (5 Pcs)','1 Box',220,64),
('FANCY ITEMS','Madurai Malli Fountain (3 Pcs)','1 Box',220,65),
('FANCY ITEMS','Colour Smoke (3 Pcs)','1 Box',180,66),
('FANCY ITEMS','Helicopter','1 Box',60,67),
('FANCY ITEMS','Lolli Pop','1 Box',190,68),
('FANCY ITEMS','Photo Flash','1 Box',60,69),
('FANCY ITEMS','Chota Fancy','1 Box',35,70),
('FANCY ITEMS','Kit Kat','1 Box',60,71),
('FANCY ITEMS','Siren (5 Pcs)','1 Box',180,72),
('FANCY ITEMS','Penta Sky Shot (5 Pcs)','1 Box',250,73),
('FANCY ITEMS','90 Watts','1 Box',200,74),
('FANCY ITEMS','Gun Fountain','1 Box',200,75),
('FANCY ITEMS','Tin Fountain','1 Box',120,76),
('FANCY ITEMS','Car Fountain','1 Box',190,77),
('FANCY ITEMS','Murugan Vel Fountain','1 Box',190,78),
('FANCY ITEMS','Peacock','1 Box',150,79),
('FANCY ITEMS','Bada Peacock','1 Box',350,80),
('FANCY ITEMS','Self Stick','1 Box',160,81),
('FANCY ITEMS','Toys Shower Fountain','1 Box',140,82),
('FANCY ITEMS','Top Gun','1 Box',210,83),
('FANCY ITEMS','Water Queen Fountain','1 Box',190,84),

('MULTI SHOT FANCY','12 Shot','1 Box',150,85),
('MULTI SHOT FANCY','15 Shot','1 Box',280,86),
('MULTI SHOT FANCY','15 Smoke Shot','1 Box',400,87),
('MULTI SHOT FANCY','25 Cracking Shot','1 Box',400,88),
('MULTI SHOT FANCY','30 Peacock Shot','1 Box',400,89),
('MULTI SHOT FANCY','30 Shot Multi Colour','1 Box',350,90),
('MULTI SHOT FANCY','60 Shot Multi Colour','1 Box',700,91),
('MULTI SHOT FANCY','120 Shot Multi Colour','1 Box',1400,92),
('MULTI SHOT FANCY','240 Shot Multi Colour','1 Box',2800,93),
('MULTI SHOT FANCY','5×5 Cracking Shot','1 Box',700,94),
('MULTI SHOT FANCY','10×10 Cracking Shot','1 Box',3000,95),

('SINGLE SHOT FANCY','2” Fancy','1 Box',100,96),
('SINGLE SHOT FANCY','2” Fancy (3 Pcs)','1 Box',240,97),
('SINGLE SHOT FANCY','3½” Fancy','1 Box',280,98),
('SINGLE SHOT FANCY','4½” Fancy','1 Box',350,99),
('SINGLE SHOT FANCY','3½” Double Ball','1 Box',350,100),
('SINGLE SHOT FANCY','3½” Nayagara Falls','1 Box',350,101),
('SINGLE SHOT FANCY','3” Fancy (2 Pcs)','1 Box',800,102),
('SINGLE SHOT FANCY','5” Fancy (2 Pcs)','1 Box',1400,103),
('SINGLE SHOT FANCY','7 Shot','1 Box',120,104),

('SPARKLERS','Rotating Sparklers','1 Box',250,105),
('SPARKLERS','50cm ELE','1 Box',200,106),
('SPARKLERS','50cm Colour','1 Box',220,107),
('SPARKLERS','30cm ELE','1 Box',55,108),
('SPARKLERS','30cm Colour','1 Box',55,109),
('SPARKLERS','30cm Red','1 Box',60,110),
('SPARKLERS','30cm Green','1 Box',60,111),
('SPARKLERS','15cm ELE','1 Box',55,112),
('SPARKLERS','15cm Colour','1 Box',55,113),
('SPARKLERS','15cm Red','1 Box',60,114),
('SPARKLERS','15cm Green','1 Box',60,115),
('SPARKLERS','10cm ELE','1 Box',15,116),
('SPARKLERS','10cm Colour','1 Box',15,117),
('SPARKLERS','10cm Red','1 Box',20,118),
('SPARKLERS','10cm Green','1 Box',20,119),
('SPARKLERS','7cm ELE','1 Box',8,120),
('SPARKLERS','7cm Colour','1 Box',8,121),
('SPARKLERS','7cm Red','1 Box',10,122),
('SPARKLERS','7cm Green','1 Box',10,123),

('GIFT BOX','25 Item Box','1 Box',400,124),
('GIFT BOX','30 Item Box','1 Box',500,125),
('GIFT BOX','36 Item Box','1 Box',600,126),
('GIFT BOX','41 Item Box','1 Box',750,127),
('GIFT BOX','50 Item Box','1 Box',900,128),
('GIFT BOX','60 Item Box','1 Box',1000,129),
('GIFT BOX','70 Item Box','1 Box',1200,130)
)
insert into public.products (
    name,
    slug,
    category_id,
    description,
    unit,
    mrp,
    offer_price,
    discount,
    availability,
    featured,
    popular,
    active,
    display_order
)
select
    s.product_name,
    regexp_replace(
        lower(
            replace(
                replace(
                    replace(
                        replace(s.product_name,'×','x'),
                        '¾','3-4'
                    ),
                    '½','1-2'
                ),
                '¼','1-4'
            )
        ),
        '[^a-z0-9]+',
        '-',
        'g'
    ) || '-' || s.product_order,
    c.id,
    'Premium ' || s.product_name || ' fireworks item.',
    s.unit,
    s.price,
    null,
    0,
    'AVAILABLE',
    case when s.product_order <= 12 then true else false end,
    case when s.product_order <= 20 then true else false end,
    true,
    s.product_order
from seed s
join public.categories c
    on c.name = s.category_name
on conflict (name) do update set
    category_id = excluded.category_id,
    unit = excluded.unit,
    mrp = excluded.mrp,
    slug = excluded.slug,
    active = true,
    display_order = excluded.display_order;

-- ============================================================
-- 14. PRODUCT DISCOUNT AUTO-CALCULATION
-- ============================================================

create or replace function public.normalize_product_discount()
returns trigger
language plpgsql
as $$
begin
    if new.offer_price is null
       or new.offer_price >= new.mrp
       or new.mrp = 0 then
        new.discount := 0;
    else
        new.discount :=
            round(
                ((new.mrp - new.offer_price) / new.mrp) * 100,
                2
            );
    end if;

    new.updated_at := now();

    return new;
end;
$$;

drop trigger if exists trg_products_discount
on public.products;

create trigger trg_products_discount
before insert or update
on public.products
for each row
execute function public.normalize_product_discount();

-- ============================================================
-- 15. UPDATED_AT TRIGGERS
-- ============================================================

create or replace function public.touch_updated_at()
returns trigger
language plpgsql
as $$
begin
    new.updated_at := now();
    return new;
end;
$$;

drop trigger if exists trg_categories_updated
on public.categories;

create trigger trg_categories_updated
before update on public.categories
for each row
execute function public.touch_updated_at();

drop trigger if exists trg_banners_updated
on public.banners;

create trigger trg_banners_updated
before update on public.banners
for each row
execute function public.touch_updated_at();

drop trigger if exists trg_offers_updated
on public.offers;

create trigger trg_offers_updated
before update on public.offers
for each row
execute function public.touch_updated_at();

drop trigger if exists trg_price_lists_updated
on public.price_lists;

create trigger trg_price_lists_updated
before update on public.price_lists
for each row
execute function public.touch_updated_at();

drop trigger if exists trg_settings_updated
on public.settings;

create trigger trg_settings_updated
before update on public.settings
for each row
execute function public.touch_updated_at();

drop trigger if exists trg_orders_updated
on public.orders;

create trigger trg_orders_updated
before update on public.orders
for each row
execute function public.touch_updated_at();

-- ============================================================
-- 16. ADMIN CHECK
-- ============================================================

create or replace function public.is_admin()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
    select exists (
        select 1
        from public.admin_profiles
        where user_id = auth.uid()
        and is_admin = true
    );
$$;

revoke all on function public.is_admin()
from public;

grant execute on function public.is_admin()
to anon, authenticated;

-- ============================================================
-- 17. ORDER NUMBER GENERATOR
-- ============================================================
-- Transaction advisory lock prevents two customers from
-- generating the same number at the same time.

create or replace function public.next_order_number()
returns text
language plpgsql
security definer
set search_path = public
as $$
declare
    next_number bigint;
begin

    perform pg_advisory_xact_lock(
        hashtext('sakthivel-crackers-order-number')
    );

    select
        coalesce(
            max(
                substring(
                    order_number
                    from '[0-9]{6}$'
                )::bigint
            ),
            0
        ) + 1
    into next_number
    from public.orders
    where order_number like
        'SV-' || to_char(current_date,'YYYY') || '-%';

    return
        'SV-' ||
        to_char(current_date,'YYYY') ||
        '-' ||
        lpad(next_number::text,6,'0');

end;
$$;

-- ============================================================
-- 18. SECURE CUSTOMER ORDER CREATION
-- ============================================================
-- Browser sends product IDs + quantities only.
-- Database calculates actual price.
-- Customer cannot submit fake prices or fake totals.
-- Order item snapshots are stored at creation time.

create or replace function public.create_order(
    p_customer_name text,
    p_mobile text,
    p_address text,
    p_district text,
    p_pincode text,
    p_notes text,
    p_items jsonb
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare

    item jsonb;

    p_id uuid;

    qty integer;

    unit_price numeric(12,2);

    product_unit text;

    line_total numeric(12,2);

    grand_total numeric(12,2) := 0;

    new_order_id uuid;

    new_order_number text;

begin

    -- Customer name validation
    if trim(coalesce(p_customer_name,'')) = '' then
        raise exception 'Customer name is required';
    end if;

    if length(trim(p_customer_name)) < 2 then
        raise exception 'Customer name is too short';
    end if;

    -- Indian mobile validation
    if p_mobile !~ '^[6-9][0-9]{9}$' then
        raise exception 'Invalid Indian mobile number';
    end if;

    -- Address validation
    if trim(coalesce(p_address,'')) = '' then
        raise exception 'Address is required';
    end if;

    if length(trim(p_address)) < 5 then
        raise exception 'Address is too short';
    end if;

    -- Pincode validation
    if p_pincode !~ '^[1-9][0-9]{5}$' then
        raise exception 'Invalid Indian pincode';
    end if;

    -- Cart validation
    if p_items is null
       or jsonb_typeof(p_items) <> 'array'
       or jsonb_array_length(p_items) = 0 then

        raise exception 'Cart is empty';

    end if;

    -- Create secure order number
    new_order_number := public.next_order_number();

    insert into public.orders (
        order_number,
        customer_name,
        mobile,
        address,
        district,
        pincode,
        notes,
        total_amount,
        status
    )
    values (
        new_order_number,
        trim(p_customer_name),
        p_mobile,
        trim(p_address),
        trim(coalesce(p_district,'')),
        p_pincode,
        nullif(trim(coalesce(p_notes,'')),''),
        0,
        'PENDING'
    )
    returning id into new_order_id;

    -- Process every product.
    for item in
        select *
        from jsonb_array_elements(p_items)
    loop

        p_id :=
            (item->>'product_id')::uuid;

        qty :=
            greatest(
                1,
                least(
                    coalesce(
                        (item->>'quantity')::integer,
                        1
                    ),
                    999
                )
            );

        select
            coalesce(offer_price,mrp),
            unit
        into
            unit_price,
            product_unit
        from public.products
        where id = p_id
          and active = true
          and availability = 'AVAILABLE';

        if not found then
            raise exception
                'One or more products are unavailable';
        end if;

        line_total :=
            unit_price * qty;

        grand_total :=
            grand_total + line_total;

        -- SNAPSHOT
        insert into public.order_items (
            order_id,
            product_id,
            product_name,
            quantity,
            unit,
            price,
            subtotal
        )
        select
            new_order_id,
            p.id,
            p.name,
            qty,
            p.unit,
            unit_price,
            line_total
        from public.products p
        where p.id = p_id;

    end loop;

    if grand_total <= 0 then
        raise exception 'Invalid order total';
    end if;

    update public.orders
    set total_amount = grand_total
    where id = new_order_id;

    return jsonb_build_object(
        'order_id', new_order_id,
        'order_number', new_order_number,
        'total_amount', grand_total,
        'status', 'PENDING'
    );

end;
$$;

revoke all
on function public.create_order(
    text,text,text,text,text,text,jsonb
)
from public;

grant execute
on function public.create_order(
    text,text,text,text,text,text,jsonb
)
to anon, authenticated;

-- ============================================================
-- 19. SECURE ORDER TRACKING
-- ============================================================
-- Customer receives only the fields needed for tracking.
-- No order-items or address data are exposed in this function.

create or replace function public.track_orders(
    p_mobile text
)
returns table (
    order_id uuid,
    order_number text,
    created_at timestamptz,
    customer_name text,
    total_amount numeric,
    status text
)
language sql
stable
security definer
set search_path = public
as $$
    select
        o.id,
        o.order_number,
        o.created_at,
        o.customer_name,
        o.total_amount,
        o.status
    from public.orders o
    where o.mobile = p_mobile
    order by o.created_at desc
    limit 50;
$$;

revoke all
on function public.track_orders(text)
from public;

grant execute
on function public.track_orders(text)
to anon, authenticated;

-- ============================================================
-- 20. SECURE SINGLE ORDER DETAILS
-- ============================================================
-- Mobile number + order number must both match.

create or replace function public.track_order_details(
    p_order_number text,
    p_mobile text
)
returns jsonb
language plpgsql
stable
security definer
set search_path = public
as $$
declare

    order_data jsonb;

    item_data jsonb;

begin

    select
        to_jsonb(x)
    into
        order_data
    from (
        select
            id,
            order_number,
            created_at,
            customer_name,
            mobile,
            address,
            district,
            pincode,
            total_amount,
            status
        from public.orders
        where order_number = p_order_number
          and mobile = p_mobile
        limit 1
    ) x;

    if order_data is null then
        raise exception 'Order not found';
    end if;

    select
        coalesce(
            jsonb_agg(
                to_jsonb(i)
                order by i.id
            ),
            '[]'::jsonb
        )
    into
        item_data
    from public.order_items i
    where i.order_id =
        (order_data->>'id')::uuid;

    return jsonb_build_object(
        'order', order_data,
        'items', item_data
    );

end;
$$;

revoke all
on function public.track_order_details(text,text)
from public;

grant execute
on function public.track_order_details(text,text)
to anon, authenticated;

-- ============================================================
-- 21. RLS
-- ============================================================

alter table public.categories
enable row level security;

alter table public.products
enable row level security;

alter table public.banners
enable row level security;

alter table public.offers
enable row level security;

alter table public.price_lists
enable row level security;

alter table public.settings
enable row level security;

alter table public.admin_profiles
enable row level security;

alter table public.orders
enable row level security;

alter table public.order_items
enable row level security;

-- ============================================================
-- 22. CATEGORY POLICIES
-- ============================================================

drop policy if exists categories_public_read
on public.categories;

create policy categories_public_read
on public.categories
for select
using (
    active = true
    or public.is_admin()
);

drop policy if exists categories_admin_all
on public.categories;

create policy categories_admin_all
on public.categories
for all
to authenticated
using (public.is_admin())
with check (public.is_admin());

-- ============================================================
-- 23. PRODUCT POLICIES
-- ============================================================

drop policy if exists products_public_read
on public.products;

create policy products_public_read
on public.products
for select
using (
    active = true
    or public.is_admin()
);

drop policy if exists products_admin_all
on public.products;

create policy products_admin_all
on public.products
for all
to authenticated
using (public.is_admin())
with check (public.is_admin());

-- ============================================================
-- 24. BANNER POLICIES
-- ============================================================

drop policy if exists banners_public_read
on public.banners;

create policy banners_public_read
on public.banners
for select
using (
    active = true
    or public.is_admin()
);

drop policy if exists banners_admin_all
on public.banners;

create policy banners_admin_all
on public.banners
for all
to authenticated
using (public.is_admin())
with check (public.is_admin());

-- ============================================================
-- 25. OFFER POLICIES
-- ============================================================

drop policy if exists offers_public_read
on public.offers;

create policy offers_public_read
on public.offers
for select
using (
    active = true
    or public.is_admin()
);

drop policy if exists offers_admin_all
on public.offers;

create policy offers_admin_all
on public.offers
for all
to authenticated
using (public.is_admin())
with check (public.is_admin());

-- ============================================================
-- 26. PRICE LIST POLICIES
-- ============================================================

drop policy if exists price_lists_public_read
on public.price_lists;

create policy price_lists_public_read
on public.price_lists
for select
using (
    active = true
    or public.is_admin()
);

drop policy if exists price_lists_admin_all
on public.price_lists;

create policy price_lists_admin_all
on public.price_lists
for all
to authenticated
using (public.is_admin())
with check (public.is_admin());

-- ============================================================
-- 27. SETTINGS POLICIES
-- ============================================================

drop policy if exists settings_public_read
on public.settings;

create policy settings_public_read
on public.settings
for select
using (true);

drop policy if exists settings_admin_update
on public.settings;

create policy settings_admin_update
on public.settings
for update
to authenticated
using (public.is_admin())
with check (public.is_admin());

drop policy if exists settings_admin_insert
on public.settings;

create policy settings_admin_insert
on public.settings
for insert
to authenticated
with check (public.is_admin());

-- ============================================================
-- 28. ADMIN PROFILE POLICIES
-- ============================================================

drop policy if exists admin_profiles_self_read
on public.admin_profiles;

create policy admin_profiles_self_read
on public.admin_profiles
for select
to authenticated
using (
    user_id = auth.uid()
    or public.is_admin()
);

drop policy if exists admin_profiles_admin_all
on public.admin_profiles;

create policy admin_profiles_admin_all
on public.admin_profiles
for all
to authenticated
using (public.is_admin())
with check (public.is_admin());

-- ============================================================
-- 29. ORDERS POLICIES
-- ============================================================
-- IMPORTANT:
-- No anonymous direct INSERT policy is intentionally created.
-- Customers must use create_order() RPC.
-- Admin can manage orders.

drop policy if exists orders_admin_all
on public.orders;

create policy orders_admin_all
on public.orders
for all
to authenticated
using (public.is_admin())
with check (public.is_admin());

-- ============================================================
-- 30. ORDER ITEMS POLICIES
-- ============================================================

drop policy if exists order_items_admin_all
on public.order_items;

create policy order_items_admin_all
on public.order_items
for all
to authenticated
using (public.is_admin())
with check (public.is_admin());

-- ============================================================
-- 31. STORAGE BUCKETS
-- ============================================================

insert into storage.buckets
(id,name,public)
values
('logos','logos',true),
('product-images','product-images',true),
('category-images','category-images',true),
('banner-images','banner-images',true),
('offer-images','offer-images',true),
('price-lists','price-lists',true)
on conflict (id)
do update set public = true;

-- ============================================================
-- 32. STORAGE PUBLIC READ
-- ============================================================

drop policy if exists storage_public_read
on storage.objects;

create policy storage_public_read
on storage.objects
for select
using (
    bucket_id in (
        'logos',
        'product-images',
        'category-images',
        'banner-images',
        'offer-images',
        'price-lists'
    )
);

-- ============================================================
-- 33. STORAGE ADMIN INSERT
-- ============================================================

drop policy if exists storage_admin_insert
on storage.objects;

create policy storage_admin_insert
on storage.objects
for insert
to authenticated
with check (
    public.is_admin()
    and bucket_id in (
        'logos',
        'product-images',
        'category-images',
        'banner-images',
        'offer-images',
        'price-lists'
    )
);

-- ============================================================
-- 34. STORAGE ADMIN UPDATE
-- ============================================================

drop policy if exists storage_admin_update
on storage.objects;

create policy storage_admin_update
on storage.objects
for update
to authenticated
using (
    public.is_admin()
)
with check (
    public.is_admin()
);

-- ============================================================
-- 35. STORAGE ADMIN DELETE
-- ============================================================

drop policy if exists storage_admin_delete
on storage.objects;

create policy storage_admin_delete
on storage.objects
for delete
to authenticated
using (
    public.is_admin()
);

-- ============================================================
-- 36. FINAL BUSINESS SETTINGS
-- ============================================================

update public.settings
set
    shop_name = 'SAKTHIVEL CRACKERS',

    address =
        'Kundayiruppu, Sivakasi, Tamil Nadu, India',

    whatsapp =
        '93442 65054',

    whatsapp_cc =
        '919344265054',

    phone =
        '93442 65054',

    seo_title =
        'SAKTHIVEL CRACKERS — Kundayiruppu, Sivakasi',

    seo_description =
        'Premium fireworks ordering website for SAKTHIVEL CRACKERS, Kundayiruppu, Sivakasi.'
where id = 1;

-- ============================================================
-- 37. VERIFICATION QUERIES
-- ============================================================
-- Run these after the complete SQL finishes.

select count(*) as total_categories
from public.categories;

select count(*) as total_products
from public.products;

select
    c.name as category,
    count(p.id) as product_count
from public.categories c
left join public.products p
    on p.category_id = c.id
group by c.id,c.name,c.display_order
order by c.display_order;

select
    name,
    unit,
    mrp,
    availability
from public.products
order by display_order;

-- ============================================================
-- 38. ADMIN AUTHORIZATION
-- ============================================================
-- IMPORTANT:
--
-- First create the Admin user in:
--
-- Supabase Dashboard
-- → Authentication
-- → Users
-- → Add user
--
-- After creating the user, copy that user's UUID.
--
-- Then run:
--
-- insert into public.admin_profiles(user_id,is_admin)
-- values ('PASTE_ADMIN_USER_UUID_HERE',true)
-- on conflict (user_id)
-- do update set is_admin=true;
--
-- NEVER put the Admin password in this SQL file.
-- ============================================================

-- ============================================================
-- END OF SAKTHIVEL CRACKERS SUPABASE DATABASE
-- ============================================================
