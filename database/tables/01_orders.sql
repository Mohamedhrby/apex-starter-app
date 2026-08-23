-- A tiny example table so the starter app has something to render.
-- Replace with your own domain objects.

create table if not exists orders (
  id           number generated always as identity primary key,
  customer     varchar2(200 char) not null,
  status       varchar2(20 char)  default 'Open' not null
               constraint orders_status_ck
               check (status in ('Open','In Progress','Closed')),
  amount       number(12,2)       default 0 not null,
  created_at   timestamp with local time zone default systimestamp not null
);

-- Seed a couple of rows (safe to re-run: only inserts when empty).
begin
  insert into orders (customer, status, amount)
  select * from (
    select 'Acme Corp',   'Open',        1250.00 from dual union all
    select 'Globex',      'In Progress',  480.50 from dual union all
    select 'Initech',     'Closed',      9900.00 from dual
  ) where not exists (select 1 from orders);
  commit;
end;
/
