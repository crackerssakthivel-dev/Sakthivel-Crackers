# SAKTHIVEL CRACKERS

## Premium Fireworks Ordering Website

**Business Name:** SAKTHIVEL CRACKERS

**Location:** Kundayiruppu, Sivakasi, Tamil Nadu, India

**WhatsApp:** 93442 65054

**WhatsApp Country Code:** 919344265054

---

# PROJECT DESCRIPTION

SAKTHIVEL CRACKERS is a premium, mobile-first fireworks ordering website.

The website allows customers to:

- Browse fireworks products
- Browse products category-wise
- Search products
- Filter products
- Sort products
- View product details
- Add products to cart
- Change quantities
- Place orders
- Send order information through WhatsApp
- Download order bill PDF
- Track orders using mobile number

The website does NOT process online payments.

---

# TECHNOLOGY

This project uses only:

- HTML5
- CSS3
- Vanilla JavaScript
- Supabase
- GitHub
- Vercel

The project does not require:

- React
- Next.js
- Vue
- Angular
- Node.js backend
- Express
- MongoDB
- Firebase
- Unnecessary frameworks

---

# PROJECT STRUCTURE

The required project structure is:

SAKTHIVEL-CRACKERS/

├── index.html
├── admin.html
├── supabase.sql
├── README.md
└── .gitignore

The customer website is primarily contained inside:

index.html

The Admin Panel is primarily contained inside:

admin.html

The database setup is contained inside:

supabase.sql

---

# BUSINESS INFORMATION

Business:

SAKTHIVEL CRACKERS

Location:

Kundayiruppu, Sivakasi, Tamil Nadu, India

WhatsApp:

93442 65054

WhatsApp country-code number:

919344265054

The website must consistently use the above business information.

---

# PAYMENT RULE

This website is an ordering system only.

There is NO online payment.

The website must NOT implement:

- UPI
- QR payment
- Card payment
- Payment gateway
- Payment screenshot
- UTR
- Transaction ID
- Payment verification

Customers only place orders.

---

# ORDER STATUS

Only these order statuses are allowed:

PENDING

CONFIRMED

CANCELLED

Every new order starts as:

PENDING

Only an authorized Admin can change the status.

---

# CUSTOMER WEBSITE

The customer website is:

index.html

It contains:

- Header
- Hero banner
- Categories
- Featured products
- Popular products
- Search
- Filters
- Sorting
- Product details
- Cart
- Checkout
- Order creation
- WhatsApp order
- Order success
- PDF bill
- Order tracking
- Price List
- Offers
- Contact
- Footer
- Fixed mobile bottom navigation

---

# MOBILE BOTTOM NAVIGATION

The customer website contains a fixed bottom navigation on mobile.

The navigation provides:

1. MENU
2. PRICE LIST
3. CART
4. OFFERS
5. TRACK ORDER

The navigation remains fixed while scrolling.

The navigation supports mobile safe-area spacing.

The navigation does not cover important page content.

The page contains sufficient bottom padding.

---

# LARGE CENTER CART BUTTON

The center Cart button is larger than the other bottom navigation buttons.

It is designed to visually stand out.

It displays:

- Cart icon
- CART label
- Live cart count

The cart button opens the cart when tapped.

---

# LIVE CART COUNT

The cart count must update immediately when:

- Product is added
- Quantity increases
- Quantity decreases
- Product is removed
- Cart is cleared

The following must stay synchronized:

- Header cart count
- Bottom navigation cart count
- Cart contents

---

# ADD TO CART ANIMATION

When a customer adds a product:

1. Cart count updates.
2. Bottom Cart button updates.
3. Header Cart button updates.
4. Cart button animates.
5. A confirmation toast appears.
6. Product-to-cart animation may play.
7. Cart is saved to LocalStorage.

Example toast:

Product added to cart

---

# LOCAL STORAGE CART

The cart is stored in browser LocalStorage.

The cart survives page refreshes.

Each cart item contains:

- Product ID
- Product name
- Image
- Price
- Quantity
- Subtotal

The customer can:

- Increase quantity
- Decrease quantity
- Remove product
- Continue shopping
- Checkout

The cart displays:

- Subtotal
- Grand Total

---

# CHECKOUT

Checkout fields:

- Customer Name
- Mobile Number
- Full Address
- City / District
- Pincode
- Optional Notes

Validation:

- Name is required.
- Mobile number must be a valid Indian 10-digit number.
- Address is required.
- Pincode must be a valid Indian pincode.

The customer places the order using:

PLACE ORDER

---

# ORDER ID

Orders use this format:

SV-YYYY-XXXXXX

Example:

SV-2026-000001

---

# ORDER DATA

An order stores:

- Order ID
- Customer name
- Mobile
- Address
- District
- Pincode
- Notes
- Total
- Status
- Created date
- Updated date

Order items store snapshots of:

- Product ID
- Product name
- Quantity
- Unit
- Price
- Subtotal

Old orders must not change when Admin later edits products.

---

# WHATSAPP ORDER

After successful order creation, the customer can open WhatsApp with a pre-filled order message.

WhatsApp number:

919344265054

The customer manually presses SEND.

The website does not use the WhatsApp API.

---

# ORDER SUCCESS

After successful order placement, the website shows:

ORDER RECEIVED!

The success page shows:

- Order ID
- Status
- Customer name
- Mobile
- Address
- Products
- Quantities
- Total

Buttons:

- DOWNLOAD ORDER BILL PDF
- TRACK ORDER
- CONTINUE SHOPPING

---

# PDF BILL

The website provides a professional order bill PDF.

The bill contains:

SAKTHIVEL CRACKERS

Kundayiruppu, Sivakasi, Tamil Nadu, India

WhatsApp: 93442 65054

The PDF contains:

- Order ID
- Date
- Customer
- Mobile
- Address
- Product
- Quantity
- Unit price
- Subtotal
- Grand total
- Status

The customer can:

- Download
- Save
- Print

---

# TRACK ORDER

Customers do not need an account.

They enter their registered 10-digit mobile number.

The website displays matching orders.

The customer can view:

- Order ID
- Date
- Customer name
- Total
- Status

Status display:

PENDING

CONFIRMED

CANCELLED

The customer can open order details.

Unrelated customer information must not be exposed.

---

# PRICE LIST

The website contains a Price List section.

The active Price List PDF comes from Supabase Storage.

The website does not permanently hard-code an uploaded PDF URL.

The Price List can be accessed from:

- Header
- Homepage
- Footer
- Mobile bottom navigation

Customer buttons include:

- VIEW PRICE LIST
- DOWNLOAD PRICE LIST PDF

---

# OFFERS

Offers are dynamic.

Offer fields include:

- Title
- Description
- Image
- Start date
- End date
- Active
- Display order
- CTA text
- CTA link

---

# PRODUCTS

The database contains exactly:

130 initial products

The products are automatically seeded through:

supabase.sql

The Admin does not need to manually create the initial 130 products.

---

# CATEGORIES

The database contains exactly:

16 initial categories

The categories are:

1. ONE SOUND CRACKERS
2. FLOWER POTS
3. GROUND CHAKKAR
4. BIJILI PATTAS
5. MULTI SOUND
6. TWINKLING STAR
7. BOMB
8. ROCKETS
9. PENCIL TORCHES
10. PAPER BOMB
11. NEW FANCY ITEMS
12. FANCY ITEMS
13. MULTI SHOT FANCY
14. SINGLE SHOT FANCY
15. SPARKLERS
16. GIFT BOX

---

# PRODUCT FIELDS

Every product supports:

- id
- name
- slug
- category_id
- description
- unit
- mrp
- offer_price
- discount
- image_url
- availability
- featured
- popular
- active
- display_order
- created_at
- updated_at

---

# PRODUCT AVAILABILITY

There is no complicated stock quantity system.

Products use:

AVAILABLE

or:

UNAVAILABLE

Admin controls availability.

---

# SEARCH

Customers can search by:

- Product name
- Category

Search works on mobile and desktop.

---

# FILTERS

Available filters:

- Category
- Featured
- Popular
- Availability
- Price range

---

# SORTING

Available sorting:

- Price low to high
- Price high to low
- Featured
- Popular
- Name

---

# PRODUCT DETAILS

Product details display:

- Image
- Name
- Category
- MRP
- Offer price
- Discount
- Unit
- Description
- Availability
- Quantity selector
- ADD TO CART

---

# ADMIN PANEL

The Admin Panel is:

admin.html

Admin authentication uses Supabase Authentication.

Admin login requires:

- Email
- Password

Authentication alone does not grant Admin permissions.

Only explicitly authorized Admin users can perform Admin operations.

---

# ADMIN DASHBOARD

The Admin Dashboard displays:

- Total products
- Active products
- Total orders
- Pending orders
- Confirmed orders
- Cancelled orders
- Recent orders
- Recent products
- Quick actions

---

# ADMIN MENU

The Admin Panel contains:

- Dashboard
- Orders
- Products
- Categories
- Banners
- Offers
- Price List
- Homepage / Content
- Settings
- Logout

---

# ADMIN ORDERS

Admin can:

- View all orders
- Search orders
- Filter orders
- Sort orders
- Open orders
- View customer information
- View mobile number
- View address
- View products
- View quantities
- View prices
- View total
- View date and time

Admin actions:

CONFIRM ORDER

CANCEL ORDER

Only authorized Admin users can change order status.

---

# ADMIN PRODUCTS

Admin can:

- Add products
- Edit products
- Delete products
- Change product name
- Change category
- Change MRP
- Change offer price
- Change discount
- Change description
- Change unit
- Change availability
- Upload image
- Replace image
- Delete image
- Enable product
- Disable product
- Set Featured
- Set Popular
- Change display order

---

# ADMIN CATEGORIES

Admin can:

- Add
- Edit
- Delete
- Upload image
- Change icon
- Enable
- Disable
- Reorder

There is no fixed category limit.

---

# ADMIN BANNERS

Admin can:

- Add banners
- Upload banner images
- Replace images
- Delete banners
- Enable/disable banners
- Reorder banners
- Edit title
- Edit subtitle
- Edit button text
- Edit button link

There is no fixed banner limit.

---

# ADMIN OFFERS

Admin can:

- Add offers
- Edit offers
- Delete offers
- Upload images
- Change title
- Change description
- Set dates
- Enable/disable
- Reorder

There is no fixed offer limit.

---

# ADMIN PRICE LIST

Admin can:

- Upload PDF
- Replace PDF
- Delete PDF
- Activate PDF
- Deactivate PDF
- Change button text
- Control visibility

The active official Price List is automatically used by the customer website.

---

# ADMIN HOMEPAGE CONTROL

Admin can control, where technically practical:

- Hero title
- Hero subtitle
- Hero banners
- Banner order
- CTA buttons
- Featured products
- Popular products
- Offers
- Categories
- Price List section
- Contact section
- Section visibility

---

# ADMIN HEADER AND FOOTER

Admin can control, where supported:

- Logo
- Shop name
- Address
- WhatsApp
- Phone
- Email
- Social links
- Footer text
- Navigation visibility
- WhatsApp button

---

# ADMIN THEME

The website supports theme settings where practical.

Possible settings:

- Primary colour
- Secondary colour
- Accent colour
- Gold colour
- Background image
- Logo
- Section visibility

CSS variables are used to maintain the premium design.

---

# SUPABASE DATABASE

The project uses Supabase PostgreSQL.

Required tables:

- categories
- products
- banners
- offers
- orders
- order_items
- price_lists
- settings
- admin_profiles

---

# SUPABASE STORAGE

Required Storage buckets:

- logos
- product-images
- category-images
- banner-images
- offer-images
- price-lists

---

# SECURITY

The browser must NEVER contain:

SUPABASE_SERVICE_ROLE_KEY

Only public browser-safe Supabase credentials may be used.

Supabase Row Level Security protects the database.

Customers cannot:

- Change order status
- Modify orders
- Edit products
- Edit categories
- Edit banners
- Edit offers
- Edit settings
- Upload Admin content

Only authorized Admin users can perform Admin operations.

---

# GITHUB

The project is designed to work with GitHub.

Required files:

- index.html
- admin.html
- supabase.sql
- README.md
- .gitignore

Never commit:

- Passwords
- Private keys
- Supabase service-role key
- Other secrets

---

# VERCEL

Deployment architecture:

GitHub → Vercel → Supabase

The website is designed for static deployment using Vercel.

---

# BEGINNER SETUP GUIDE

## STEP 1 — CREATE SUPABASE

1. Open Supabase.
2. Create a new project.
3. Choose a project name.
4. Create a secure database password.
5. Wait for the project to finish creating.

---

## STEP 2 — GET SUPABASE PROJECT URL

1. Open the Supabase project.
2. Open Project Settings.
3. Open API.
4. Find the Project URL.
5. Copy it.

---

## STEP 3 — GET PUBLIC ANON KEY

1. Stay in the Supabase API settings.
2. Find the public/anon key.
3. Copy it.
4. Do NOT copy the service-role key.

---

## STEP 4 — RUN supabase.sql

1. Open Supabase.
2. Open SQL Editor.
3. Create a new SQL query.
4. Open the project's supabase.sql file.
5. Copy the complete SQL.
6. Paste it into SQL Editor.
7. Run the SQL.
8. Wait for it to complete successfully.

---

## STEP 5 — CHECK DATABASE

Open:

Table Editor

Verify that these tables exist:

- categories
- products
- banners
- offers
- orders
- order_items
- price_lists
- settings
- admin_profiles

Verify:

16 categories

130 products

---

## STEP 6 — CREATE ADMIN LOGIN

1. Open Supabase.
2. Open Authentication.
3. Open Users.
4. Create a new user.
5. Enter Admin email.
6. Enter Admin password.
7. Save the user.

---

## STEP 7 — AUTHORIZE ADMIN

The Admin user must be explicitly authorized through the Admin authorization system.

Only authorized Admin users can access protected Admin functionality.

---

## STEP 8 — CONFIGURE STORAGE

Open:

Supabase → Storage

Verify the required buckets:

- logos
- product-images
- category-images
- banner-images
- offer-images
- price-lists

---

## STEP 9 — CONFIGURE WEBSITE

Open:

index.html

and:

admin.html

Configure the public Supabase connection values required by the website.

Use:

SUPABASE_URL

and:

SUPABASE_ANON_KEY

Never use:

SUPABASE_SERVICE_ROLE_KEY

---

# GITHUB DEPLOYMENT

## STEP 10 — CREATE GITHUB REPOSITORY

1. Open GitHub.
2. Create a new repository.
3. Name it:

SAKTHIVEL-CRACKERS

4. Create the repository.

---

## STEP 11 — UPLOAD FILES

Upload only the required project files:

- index.html
- admin.html
- supabase.sql
- README.md
- .gitignore

Commit the changes.

---

# VERCEL DEPLOYMENT

## STEP 12 — CREATE VERCEL PROJECT

1. Open Vercel.
2. Sign in using GitHub.
3. Select Add New Project.
4. Select the SAKTHIVEL-CRACKERS repository.
5. Import the project.
6. Deploy.

---

## STEP 13 — OPEN CUSTOMER WEBSITE

After deployment:

1. Open the Vercel website URL.
2. Check the homepage.
3. Check products.
4. Check categories.
5. Check cart.
6. Check checkout.
7. Check order creation.
8. Check WhatsApp.
9. Check PDF.
10. Check order tracking.

---

## STEP 14 — OPEN ADMIN PANEL

Open:

/admin.html

Login using the authorized Admin account.

---

# ADMIN FIRST-TIME SETUP

After Admin login:

1. Upload the official logo.
2. Upload product images.
3. Upload category images.
4. Upload banner images.
5. Create or edit offers.
6. Upload official Price List PDF.
7. Check website settings.
8. Check contact details.
9. Check product availability.
10. Check Featured products.
11. Check Popular products.

---

# CUSTOMER TESTING

Test the complete customer flow:

HOME

↓

PRODUCTS

↓

PRODUCT DETAILS

↓

ADD TO CART

↓

CART

↓

CHECKOUT

↓

PLACE ORDER

↓

SUPABASE

↓

PENDING

↓

WHATSAPP

↓

ORDER SUCCESS

↓

PDF BILL

↓

TRACK ORDER

↓

CONFIRMED / CANCELLED

---

# CART TESTING

Verify:

- Product can be added.
- Cart count updates.
- Header cart count updates.
- Bottom cart count updates.
- Cart button animates.
- Toast appears.
- Quantity can increase.
- Quantity can decrease.
- Product can be removed.
- Cart survives refresh.
- Cart can be cleared.
- Checkout opens correctly.

---

# ORDER TESTING

Create a test order.

Verify:

- Order ID is generated.
- Customer details are saved.
- Products are saved.
- Quantities are saved.
- Prices are saved.
- Total is saved.
- Status is PENDING.
- Cart clears only after successful order creation.
- WhatsApp message is created.
- Success screen appears.
- PDF bill works.
- Track Order works.

---

# ADMIN ORDER TESTING

Login as Admin.

Open a pending order.

Confirm the order.

The status should become:

CONFIRMED

Then open Track Order as the customer.

Verify that the latest status is:

CONFIRMED

Also test:

CANCELLED

---

# SECURITY TESTING

Verify that customers cannot:

- Change order status
- Edit products
- Edit categories
- Edit banners
- Edit offers
- Edit settings
- Upload Admin content

Verify that only authorized Admin users can perform Admin operations.

---

# PRODUCT VERIFICATION

Before going live verify:

Exactly 130 products.

Exactly 16 initial categories.

Verify:

- Product names
- Product categories
- Product prices
- Product units
- No duplicate products
- No missing products

---

# PERFORMANCE

The website should be optimized for:

- Mobile devices
- Fast loading
- Lazy-loaded images
- Efficient database queries
- Lightweight JavaScript
- Responsive design
- Static Vercel deployment

---

# ACCESSIBILITY

The website should provide:

- Good contrast
- Readable text
- Image alt text
- Proper button labels
- Touch-friendly controls
- Keyboard support where appropriate

---

# SEO

The customer website includes:

- Page title
- Meta description
- Open Graph metadata
- Semantic HTML
- Descriptive headings

Default title:

SAKTHIVEL CRACKERS — Kundayiruppu, Sivakasi

---

# FINAL CHECKLIST

Before publishing the website, verify:

[ ] Supabase project created

[ ] supabase.sql executed successfully

[ ] 16 categories exist

[ ] 130 products exist

[ ] Admin Auth user created

[ ] Admin user authorized

[ ] Storage configured

[ ] Supabase URL configured

[ ] Public anon key configured

[ ] Service-role key is NOT exposed

[ ] GitHub repository created

[ ] Required files uploaded

[ ] Vercel deployment completed

[ ] Customer website opens

[ ] Admin panel opens

[ ] Products load

[ ] Categories load

[ ] Search works

[ ] Filters work

[ ] Sorting works

[ ] Cart works

[ ] Cart survives refresh

[ ] Fixed bottom navigation works

[ ] Large center Cart button works

[ ] Cart count works

[ ] Add-to-cart animation works

[ ] Checkout validation works

[ ] Order creation works

[ ] Order status starts as PENDING

[ ] WhatsApp works

[ ] PDF bill works

[ ] Track Order works

[ ] Admin can confirm orders

[ ] Admin can cancel orders

[ ] Customer sees latest status

[ ] Price List works

[ ] Logo upload works

[ ] Product image upload works

[ ] Banner management works

[ ] Offer management works

[ ] RLS/security verified

---

# DEPLOYMENT ARCHITECTURE

Customer:

CUSTOMER

↓

VERCEL

↓

index.html

↓

SUPABASE

↓

PostgreSQL + Storage + RLS

Admin:

ADMIN

↓

VERCEL

↓

admin.html

↓

SUPABASE AUTH

↓

ADMIN AUTHORIZATION

↓

PROTECTED ADMIN DATA

---

# PROJECT GOAL

The final system provides a professional ordering experience for:

SAKTHIVEL CRACKERS

Kundayiruppu, Sivakasi, Tamil Nadu, India

WhatsApp:

93442 65054

Customers can browse products, add products to the cart, place orders, send order information through WhatsApp, download an order bill and track their orders.

Authorized Admin users can manage products, categories, banners, offers, Price List, website settings and customer orders.

---

# END OF README
