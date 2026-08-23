-- Install the starter schema. Run in your APEX workspace/parsing schema.
--   SQL> @database/install.sql
-- Order matters: tables before seed data before views/packages.

prompt Installing starter schema…

@@tables/01_orders.sql

prompt Done.
