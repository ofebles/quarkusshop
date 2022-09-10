CREATE SEQUENCE IF NOT EXISTS hibernate_sequence START WITH 1 INCREMENT BY 1;

CREATE TABLE cart
(
    id                 BIGINT                      NOT NULL,
    created_date       TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    last_modified_date TIMESTAMP WITHOUT TIME ZONE,
    customer_id        BIGINT,
    status             VARCHAR(255)                NOT NULL,
    CONSTRAINT pk_cart PRIMARY KEY (id)
);

CREATE TABLE categories
(
    id                 BIGINT                      NOT NULL,
    created_date       TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    last_modified_date TIMESTAMP WITHOUT TIME ZONE,
    name               VARCHAR(255)                NOT NULL,
    description        VARCHAR(255)                NOT NULL,
    CONSTRAINT pk_categories PRIMARY KEY (id)
);

CREATE TABLE customers
(
    id                 BIGINT                      NOT NULL,
    created_date       TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    last_modified_date TIMESTAMP WITHOUT TIME ZONE,
    first_name         VARCHAR(255),
    last_name          VARCHAR(255),
    email              VARCHAR(255),
    telephone          VARCHAR(255),
    enabled            BOOLEAN                     NOT NULL,
    CONSTRAINT pk_customers PRIMARY KEY (id)
);

CREATE TABLE order_items
(
    id                 BIGINT                      NOT NULL,
    created_date       TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    last_modified_date TIMESTAMP WITHOUT TIME ZONE,
    quantity           BIGINT                      NOT NULL,
    product_id         BIGINT,
    order_id           BIGINT,
    CONSTRAINT pk_order_items PRIMARY KEY (id)
);

CREATE TABLE orders
(
    id                 BIGINT                      NOT NULL,
    created_date       TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    last_modified_date TIMESTAMP WITHOUT TIME ZONE,
    total_price        DECIMAL(10, 2)              NOT NULL,
    status             VARCHAR(255)                NOT NULL,
    shipped            TIMESTAMP with time zone,
    payment_id         BIGINT,
    cart_id            BIGINT,
    address_1          VARCHAR(255),
    address_2          VARCHAR(255),
    city               VARCHAR(255),
    postcode           VARCHAR(10)                 NOT NULL,
    country            VARCHAR(2)                  NOT NULL,
    CONSTRAINT pk_orders PRIMARY KEY (id)
);

CREATE TABLE payments
(
    id                 BIGINT                      NOT NULL,
    created_date       TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    last_modified_date TIMESTAMP WITHOUT TIME ZONE,
    paypal_payment_id  VARCHAR(255),
    status             VARCHAR(255)                NOT NULL,
    amount             DECIMAL                     NOT NULL,
    CONSTRAINT pk_payments PRIMARY KEY (id)
);

CREATE TABLE products
(
    id                 BIGINT                      NOT NULL,
    created_date       TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    last_modified_date TIMESTAMP WITHOUT TIME ZONE,
    name               VARCHAR(255)                NOT NULL,
    description        VARCHAR(255)                NOT NULL,
    price              DECIMAL(10, 2)              NOT NULL,
    status             VARCHAR(255)                NOT NULL,
    sales_counter      INTEGER,
    category_id        BIGINT,
    CONSTRAINT pk_products PRIMARY KEY (id)
);

CREATE TABLE products_reviews
(
    product_id BIGINT NOT NULL,
    reviews_id BIGINT NOT NULL,
    CONSTRAINT pk_products_reviews PRIMARY KEY (product_id, reviews_id)
);

CREATE TABLE reviews
(
    id                 BIGINT                      NOT NULL,
    created_date       TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    last_modified_date TIMESTAMP WITHOUT TIME ZONE,
    title              VARCHAR(255)                NOT NULL,
    description        VARCHAR(255)                NOT NULL,
    rating             BIGINT                      NOT NULL,
    CONSTRAINT pk_reviews PRIMARY KEY (id)
);

ALTER TABLE orders
    ADD CONSTRAINT uc_orders_payment UNIQUE (payment_id);

ALTER TABLE products_reviews
    ADD CONSTRAINT uc_products_reviews_reviews UNIQUE (reviews_id);

ALTER TABLE cart
    ADD CONSTRAINT FK_CART_ON_CUSTOMER FOREIGN KEY (customer_id) REFERENCES customers (id);

ALTER TABLE orders
    ADD CONSTRAINT FK_ORDERS_ON_CART FOREIGN KEY (cart_id) REFERENCES cart (id);

ALTER TABLE orders
    ADD CONSTRAINT FK_ORDERS_ON_PAYMENT FOREIGN KEY (payment_id) REFERENCES payments (id);

ALTER TABLE order_items
    ADD CONSTRAINT FK_ORDER_ITEMS_ON_ORDER FOREIGN KEY (order_id) REFERENCES orders (id);

ALTER TABLE order_items
    ADD CONSTRAINT FK_ORDER_ITEMS_ON_PRODUCT FOREIGN KEY (product_id) REFERENCES products (id);

ALTER TABLE products
    ADD CONSTRAINT FK_PRODUCTS_ON_CATEGORY FOREIGN KEY (category_id) REFERENCES categories (id);

ALTER TABLE products_reviews
    ADD CONSTRAINT fk_prorev_on_product FOREIGN KEY (product_id) REFERENCES products (id);

ALTER TABLE products_reviews
    ADD CONSTRAINT fk_prorev_on_review FOREIGN KEY (reviews_id) REFERENCES reviews (id);
