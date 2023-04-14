use warehouse demo_warehouse;

use database demo_database;

create or replace table ap_sales_data_final
(
  order_id varchar(20),
  order_Date varchar(14),
  ship_date varchar(14),
  ship_mode varchar(40),
  customer_name varchar(30),
  segment varchar(50),
  state varchar(70),
  country varchar(40),
  market varchar(20),
  region varchar(20),
  product_id varchar(40),
  category varchar(20),
  sub_category varchar(20),
  product_name Varchar(200),
  sales number(10),
  quantity number(10),
  discount number(10,2),
  profit number(10,2),
  shipping number(10,2),
  order_priority varchar(10),
  year number(4,0)
   
);

describe table ap_sales_data_final;

select * from ap_sales_data_final;

select distinct ship_date from ap_sales_data_final;

--assignment 1
alter table ap_sales_data_final add primary key (order_id,product_id);

--assignment 2
update ap_sales_data_final set ship_date=replace(ship_date,'/','-'),order_date=replace(order_Date,'/','-');
update ap_sales_data_final set order_date=to_date(order_date,'mm-dd-yyyy'),ship_date=to_date(ship_date,'mm-dd-yyyy');

--assignment 3
select regexp_substr(order_id,'[[:digit:]]+',1,2) as matches from ap_sales_data_final;


-- assignment 4
select discount,
        case
            when discount > 0 then 'Yes'
            else 'False'
         end as For_Every_Order_ID
from ap_sales_data_final;

alter table ap_sales_data_final alter column order_date date;

--assignment 5
--select *,profit-shipping as final_profit from ap_sales_data_final;

--assignment 6
create or replace table ap_sales_data_final_date as
select order_id,order_date,ship_date,customer_name,country,market,product_name,datediff('day',order_date,ship_date) as Days_Taken_For_Each_Order from ap_sales_data_final;


--assgnment 7
select order_id,Days_Taken_For_Each_Order,
    case 
        when Days_Taken_For_Each_Order <=3 then 5
        when Days_Taken_For_Each_Order>3 and Days_Taken_For_Each_Order<=6 then 4
        when Days_Taken_For_Each_Order>6 and Days_Taken_For_Each_Order<=10 then 3
        else 2
     end as Rating
from ap_sales_data_final_date;


