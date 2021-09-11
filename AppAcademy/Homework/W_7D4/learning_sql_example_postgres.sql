/*
 * Converted by ned@appacademy.io from
 * http://exaples.oreilly.co/9780596007270/LearningSQLExaple.sql
 *
 * This doesn't follow all the conventions we'll learn, because we
 * didn't write it; this is a port of code provided by the Learning SQL
 * author.
*/

/* begin table creation */

create table department
 (dept_id serial,
  name varchar(20) not null,
  constraint pk_department primary key (dept_id)
 );

create table branch
 (branch_id serial,
  name varchar(20) not null,
  address varchar(30),
  city varchar(20),
  state varchar(2),
  zip varchar(12),
  constraint pk_branch primary key (branch_id)
 );

create table employee
 (emp_id serial,
  fname varchar(20) not null,
  lname varchar(20) not null,
  start_date date not null,
  end_date date,
  superior_emp_id integer,
  dept_id integer,
  title varchar(20),
  assigned_branch_id integer,
  constraint fk_e_emp_id
    foreign key (superior_emp_id) references employee (emp_id),
  constraint fk_dept_id
    foreign key (dept_id) references department (dept_id),
  constraint fk_e_branch_id
    foreign key (assigned_branch_id) references branch (branch_id),
  constraint pk_employee primary key (emp_id)
 );

create table product_type
 (product_type_cd varchar(10) not null,
  name varchar(50) not null,
  constraint pk_product_type primary key (product_type_cd)
 );

create table product
 (product_cd varchar(10) not null,
  name varchar(50) not null,
  product_type_cd varchar(10) not null,
  date_offered date,
  date_retired date,
  constraint fk_product_type_cd foreign key (product_type_cd)
    references product_type (product_type_cd),
  constraint pk_product primary key (product_cd)
 );

CREATE TYPE customer_type AS ENUM('I', 'B');

create table customer
 (cust_id serial,
  fed_id varchar(12) not null,
  cust_type_cd customer_type not null,
  address varchar(30),
  city varchar(20),
  state varchar(20),
  postal_code varchar(10),
  constraint pk_customer primary key (cust_id)
 );

create table individual
 (cust_id integer not null,
  fname varchar(30) not null,
  lname varchar(30) not null,
  birth_date date,
  constraint fk_i_cust_id foreign key (cust_id)
    references customer (cust_id),
  constraint pk_individual primary key (cust_id)
 );

create table business
 (cust_id integer not null,
  name varchar(40) not null,
  state_id varchar(10) not null,
  incorp_date date,
  constraint fk_b_cust_id foreign key (cust_id)
    references customer (cust_id),
  constraint pk_business primary key (cust_id)
 );

create table officer
 (officer_id serial,
  cust_id integer not null,
  fname varchar(30) not null,
  lname varchar(30) not null,
  title varchar(20),
  start_date date not null,
  end_date date,
  constraint fk_o_cust_id foreign key (cust_id)
    references business (cust_id),
  constraint pk_officer primary key (officer_id)
 );

CREATE TYPE account_status AS ENUM('ACTIVE','CLOSED','FROZEN');

create table account
 (account_id serial,
  product_cd varchar(10) not null,
  cust_id integer not null,
  open_date date not null,
  close_date date,
  last_activity_date date,
  status account_status,
  open_branch_id integer,
  open_emp_id integer,
  avail_balance float,
  pending_balance float,
  constraint fk_product_cd foreign key (product_cd)
    references product (product_cd),
  constraint fk_a_cust_id foreign key (cust_id)
    references customer (cust_id),
  constraint fk_a_branch_id foreign key (open_branch_id)
    references branch (branch_id),
  constraint fk_a_emp_id foreign key (open_emp_id)
    references employee (emp_id),
  constraint pk_account primary key (account_id)
 );

CREATE TYPE transaction_type AS ENUM('DBT','CDT');

create table transaction
 (txn_id serial,
  txn_date timestamp not null,
  account_id integer not null,
  txn_type_cd transaction_type,
  amount float not null,
  teller_emp_id integer,
  execution_branch_id integer,
  funds_avail_date timestamp,
  constraint fk_t_account_id foreign key (account_id)
    references account (account_id),
  constraint fk_teller_emp_id foreign key (teller_emp_id)
    references employee (emp_id),
  constraint fk_exec_branch_id foreign key (execution_branch_id)
    references branch (branch_id),
  constraint pk_transaction primary key (txn_id)
 );

/* end table creation */

/* begin data population */

/* department data */
insert into department (name)
values ('Operations');
insert into department (name)
values ('Loans');
insert into department (name)
values ('Administration');

/* branch data */
insert into branch (name, address, city, state, zip)
values ('Headquarters', '3882 Main St.', 'Waltham', 'MA', '02451');
insert into branch (name, address, city, state, zip)
values ('Woburn Branch', '422 Maple St.', 'Woburn', 'MA', '01801');
insert into branch (name, address, city, state, zip)
values ('Quincy Branch', '125 Presidential Way', 'Quincy', 'MA', '02169');
insert into branch (name, address, city, state, zip)
values ('So. NH Branch', '378 Maynard Ln.', 'Salem', 'NH', '03079');

/* employee data */
insert into employee (fname, lname, start_date,
  dept_id, title, assigned_branch_id)
values ('Michael', 'Smith', to_date('2005-06-22', 'YYYY-MM-DD'),
  (select dept_id from department where name = 'Administration'),
  'President',
  (select branch_id from branch where name = 'Headquarters'));
insert into employee (fname, lname, start_date,
  dept_id, title, assigned_branch_id)
values ('Susan', 'Barker', to_date('2006-09-12', 'YYYY-MM-DD'),
  (select dept_id from department where name = 'Administration'),
  'Vice President',
  (select branch_id from branch where name = 'Headquarters'));
insert into employee (fname, lname, start_date,
  dept_id, title, assigned_branch_id)
values ('Robert', 'Tyler', to_date('2005-02-09', 'YYYY-MM-DD'),
  (select dept_id from department where name = 'Administration'),
  'Treasurer',
  (select branch_id from branch where name = 'Headquarters'));
insert into employee (fname, lname, start_date,
  dept_id, title, assigned_branch_id)
values ('Susan', 'Hawthorne', to_date('2006-04-24', 'YYYY-MM-DD'),
  (select dept_id from department where name = 'Operations'),
  'Operations Manager',
  (select branch_id from branch where name = 'Headquarters'));
insert into employee (fname, lname, start_date,
  dept_id, title, assigned_branch_id)
values ('John', 'Gooding', to_date('2007-11-14', 'YYYY-MM-DD'),
  (select dept_id from department where name = 'Loans'),
  'Loan Manager',
  (select branch_id from branch where name = 'Headquarters'));
insert into employee (fname, lname, start_date,
  dept_id, title, assigned_branch_id)
values ('Helen', 'Fleming', to_date('2008-03-17', 'YYYY-MM-DD'),
  (select dept_id from department where name = 'Operations'),
  'Head Teller',
  (select branch_id from branch where name = 'Headquarters'));
insert into employee (fname, lname, start_date,
  dept_id, title, assigned_branch_id)
values ('Chris', 'Tucker', to_date('2008-09-15', 'YYYY-MM-DD'),
  (select dept_id from department where name = 'Operations'),
  'Teller',
  (select branch_id from branch where name = 'Headquarters'));
insert into employee (fname, lname, start_date,
  dept_id, title, assigned_branch_id)
values ('Sarah', 'Parker', to_date('2006-12-02', 'YYYY-MM-DD'),
  (select dept_id from department where name = 'Operations'),
  'Teller',
  (select branch_id from branch where name = 'Headquarters'));
insert into employee (fname, lname, start_date,
  dept_id, title, assigned_branch_id)
values ('Jane', 'Grossman', to_date('2006-05-03', 'YYYY-MM-DD'),
  (select dept_id from department where name = 'Operations'),
  'Teller',
  (select branch_id from branch where name = 'Headquarters'));
insert into employee (fname, lname, start_date,
  dept_id, title, assigned_branch_id)
values ('Paula', 'Roberts', to_date('2006-07-27', 'YYYY-MM-DD'),
  (select dept_id from department where name = 'Operations'),
  'Head Teller',
  (select branch_id from branch where name = 'Woburn Branch'));
insert into employee (fname, lname, start_date,
  dept_id, title, assigned_branch_id)
values ('Thomas', 'Ziegler', to_date('2004-10-23', 'YYYY-MM-DD'),
  (select dept_id from department where name = 'Operations'),
  'Teller',
  (select branch_id from branch where name = 'Woburn Branch'));
insert into employee (fname, lname, start_date,
  dept_id, title, assigned_branch_id)
values ('Samantha', 'Jameson', to_date('2007-01-08', 'YYYY-MM-DD'),
  (select dept_id from department where name = 'Operations'),
  'Teller',
  (select branch_id from branch where name = 'Woburn Branch'));
insert into employee (fname, lname, start_date,
  dept_id, title, assigned_branch_id)
values ('John', 'Blake', to_date('2004-05-11', 'YYYY-MM-DD'),
  (select dept_id from department where name = 'Operations'),
  'Head Teller',
  (select branch_id from branch where name = 'Quincy Branch'));
insert into employee (fname, lname, start_date,
  dept_id, title, assigned_branch_id)
values ('Cindy', 'Mason', to_date('2006-08-09', 'YYYY-MM-DD'),
  (select dept_id from department where name = 'Operations'),
  'Teller',
  (select branch_id from branch where name = 'Quincy Branch'));
insert into employee (fname, lname, start_date,
  dept_id, title, assigned_branch_id)
values ('Frank', 'Portman', to_date('2007-04-01', 'YYYY-MM-DD'),
  (select dept_id from department where name = 'Operations'),
  'Teller',
  (select branch_id from branch where name = 'Quincy Branch'));
insert into employee (fname, lname, start_date,
  dept_id, title, assigned_branch_id)
values ('Theresa', 'Markham', to_date('2005-03-15', 'YYYY-MM-DD'),
  (select dept_id from department where name = 'Operations'),
  'Head Teller',
  (select branch_id from branch where name = 'So. NH Branch'));
insert into employee (fname, lname, start_date,
  dept_id, title, assigned_branch_id)
values ('Beth', 'Fowler', to_date('2006-06-29', 'YYYY-MM-DD'),
  (select dept_id from department where name = 'Operations'),
  'Teller',
  (select branch_id from branch where name = 'So. NH Branch'));
insert into employee (fname, lname, start_date,
  dept_id, title, assigned_branch_id)
values ('Rick', 'Tulman', to_date('2006-12-12', 'YYYY-MM-DD'),
  (select dept_id from department where name = 'Operations'),
  'Teller',
  (select branch_id from branch where name = 'So. NH Branch'));

/* create data for self-referencing foreign key 'superior_emp_id' */
create temporary table emp_tmp as
select emp_id, fname, lname from employee;

update employee set superior_emp_id =
 (select emp_id from emp_tmp where lname = 'Smith' and fname = 'Michael')
where ((lname = 'Barker' and fname = 'Susan')
  or (lname = 'Tyler' and fname = 'Robert'));
update employee set superior_emp_id =
 (select emp_id from emp_tmp where lname = 'Tyler' and fname = 'Robert')
where lname = 'Hawthorne' and fname = 'Susan';
update employee set superior_emp_id =
 (select emp_id from emp_tmp where lname = 'Hawthorne' and fname = 'Susan')
where ((lname = 'Gooding' and fname = 'John')
  or (lname = 'Fleming' and fname = 'Helen')
  or (lname = 'Roberts' and fname = 'Paula')
  or (lname = 'Blake' and fname = 'John')
  or (lname = 'Markham' and fname = 'Theresa'));
update employee set superior_emp_id =
 (select emp_id from emp_tmp where lname = 'Fleming' and fname = 'Helen')
where ((lname = 'Tucker' and fname = 'Chris')
  or (lname = 'Parker' and fname = 'Sarah')
  or (lname = 'Grossman' and fname = 'Jane'));
update employee set superior_emp_id =
 (select emp_id from emp_tmp where lname = 'Roberts' and fname = 'Paula')
where ((lname = 'Ziegler' and fname = 'Thomas')
  or (lname = 'Jameson' and fname = 'Samantha'));
update employee set superior_emp_id =
 (select emp_id from emp_tmp where lname = 'Blake' and fname = 'John')
where ((lname = 'Mason' and fname = 'Cindy')
  or (lname = 'Portman' and fname = 'Frank'));
update employee set superior_emp_id =
 (select emp_id from emp_tmp where lname = 'Markham' and fname = 'Theresa')
where ((lname = 'Fowler' and fname = 'Beth')
  or (lname = 'Tulman' and fname = 'Rick'));

drop table emp_tmp;

/* product type data */
insert into product_type (product_type_cd, name)
values ('ACCOUNT','Customer Accounts');
insert into product_type (product_type_cd, name)
values ('LOAN','Individual and Business Loans');
insert into product_type (product_type_cd, name)
values ('INSURANCE','Insurance Offerings');

/* product data */
insert into product (product_cd, name, product_type_cd, date_offered)
values ('CHK','checking account','ACCOUNT',to_date('2004-01-01', 'YYYY-MM-DD'));
insert into product (product_cd, name, product_type_cd, date_offered)
values ('SAV','savings account','ACCOUNT',to_date('2004-01-01', 'YYYY-MM-DD'));
insert into product (product_cd, name, product_type_cd, date_offered)
values ('MM','money market account','ACCOUNT',to_date('2004-01-01', 'YYYY-MM-DD'));
insert into product (product_cd, name, product_type_cd, date_offered)
values ('CD','certificate of deposit','ACCOUNT',to_date('2004-01-01', 'YYYY-MM-DD'));
insert into product (product_cd, name, product_type_cd, date_offered)
values ('MRT','home mortgage','LOAN',to_date('2004-01-01', 'YYYY-MM-DD'));
insert into product (product_cd, name, product_type_cd, date_offered)
values ('AUT','auto loan','LOAN',to_date('2004-01-01', 'YYYY-MM-DD'));
insert into product (product_cd, name, product_type_cd, date_offered)
values ('BUS','business line of credit','LOAN',to_date('2004-01-01', 'YYYY-MM-DD'));
insert into product (product_cd, name, product_type_cd, date_offered)
values ('SBL','small business loan','LOAN',to_date('2004-01-01', 'YYYY-MM-DD'));

/* residential customer data */
insert into customer (fed_id, cust_type_cd,
  address, city, state, postal_code)
values ('111-11-1111', 'I', '47 Mockingbird Ln', 'Lynnfield', 'MA', '01940');
insert into individual (cust_id, fname, lname, birth_date)
select cust_id, 'James', 'Hadley', '1972-04-22' from customer
where fed_id = '111-11-1111';
insert into customer (fed_id, cust_type_cd,
  address, city, state, postal_code)
values ('222-22-2222', 'I', '372 Clearwater Blvd', 'Woburn', 'MA', '01801');
insert into individual (cust_id, fname, lname, birth_date)
select cust_id, 'Susan', 'Tingley', '1968-08-15' from customer
where fed_id = '222-22-2222';
insert into customer (fed_id, cust_type_cd,
  address, city, state, postal_code)
values ('333-33-3333', 'I', '18 Jessup Rd', 'Quincy', 'MA', '02169');
insert into individual (cust_id, fname, lname, birth_date)
select cust_id, 'Frank', 'Tucker', '1958-02-06' from customer
where fed_id = '333-33-3333';
insert into customer (fed_id, cust_type_cd,
  address, city, state, postal_code)
values ('444-44-4444', 'I', '12 Buchanan Ln', 'Waltham', 'MA', '02451');
insert into individual (cust_id, fname, lname, birth_date)
select cust_id, 'John', 'Hayward', '1966-12-22' from customer
where fed_id = '444-44-4444';
insert into customer (fed_id, cust_type_cd,
  address, city, state, postal_code)
values ('555-55-5555', 'I', '2341 Main St', 'Salem', 'NH', '03079');
insert into individual (cust_id, fname, lname, birth_date)
select cust_id, 'Charles', 'Frasier', '1971-08-25' from customer
where fed_id = '555-55-5555';
insert into customer (fed_id, cust_type_cd,
  address, city, state, postal_code)
values ('666-66-6666', 'I', '12 Blaylock Ln', 'Waltham', 'MA', '02451');
insert into individual (cust_id, fname, lname, birth_date)
select cust_id, 'John', 'Spencer', '1962-09-14' from customer
where fed_id = '666-66-6666';
insert into customer (fed_id, cust_type_cd,
  address, city, state, postal_code)
values ('777-77-7777', 'I', '29 Admiral Ln', 'Wilmington', 'MA', '01887');
insert into individual (cust_id, fname, lname, birth_date)
select cust_id, 'Margaret', 'Young', '1947-03-19' from customer
where fed_id = '777-77-7777';
insert into customer (fed_id, cust_type_cd,
  address, city, state, postal_code)
values ('888-88-8888', 'I', '472 Freedom Rd', 'Salem', 'NH', '03079');
insert into individual (cust_id, fname, lname, birth_date)
select cust_id, 'Louis', 'Blake', '1977-07-01' from customer
where fed_id = '888-88-8888';
insert into customer (fed_id, cust_type_cd,
  address, city, state, postal_code)
values ('999-99-9999', 'I', '29 Maple St', 'Newton', 'MA', '02458');
insert into individual (cust_id, fname, lname, birth_date)
select cust_id, 'Richard', 'Farley', '1968-06-16' from customer
where fed_id = '999-99-9999';

/* corporate customer data */
insert into customer (fed_id, cust_type_cd,
  address, city, state, postal_code)
values ('04-1111111', 'B', '7 Industrial Way', 'Salem', 'NH', '03079');
insert into business (cust_id, name, state_id, incorp_date)
select cust_id, 'Chilton Engineering', '12-345-678', '1999-05-01' from customer
where fed_id = '04-1111111';
insert into officer (cust_id, fname, lname,
  title, start_date)
select cust_id, 'John', 'Chilton', 'President', '1999-05-01'
from customer
where fed_id = '04-1111111';
insert into customer (fed_id, cust_type_cd,
  address, city, state, postal_code)
values ('04-2222222', 'B', '287A Corporate Ave', 'Wilmington', 'MA', '01887');
insert into business (cust_id, name, state_id, incorp_date)
select cust_id, 'Northeast Cooling Inc.', '23-456-789', to_date('2005-01-01', 'YYYY-MM-DD') from customer
where fed_id = '04-2222222';
insert into officer (cust_id, fname, lname,
  title, start_date)
select cust_id, 'Paul', 'Hardy', 'President', to_date('2005-01-01', 'YYYY-MM-DD')
from customer
where fed_id = '04-2222222';
insert into customer (fed_id, cust_type_cd,
  address, city, state, postal_code)
values ('04-3333333', 'B', '789 Main St', 'Salem', 'NH', '03079');
insert into business (cust_id, name, state_id, incorp_date)
select cust_id, 'Superior Auto Body', '34-567-890', to_date('2006-06-30', 'YYYY-MM-DD') from customer
where fed_id = '04-3333333';
insert into officer (cust_id, fname, lname,
  title, start_date)
select cust_id, 'Carl', 'Lutz', 'President', to_date('2006-06-30', 'YYYY-MM-DD')
from customer
where fed_id = '04-3333333';
insert into customer (fed_id, cust_type_cd,
  address, city, state, postal_code)
values ('04-4444444', 'B', '4772 Presidential Way', 'Quincy', 'MA', '02169');
insert into business (cust_id, name, state_id, incorp_date)
select cust_id, 'AAA Insurance Inc.', '45-678-901', '2003-05-01' from customer
where fed_id = '04-4444444';
insert into officer (cust_id, fname, lname,
  title, start_date)
select cust_id, 'Stanley', 'Cheswick', 'President', '2003-05-01'
from customer
where fed_id = '04-4444444';

/* residential account data */
insert into account (product_cd, cust_id, open_date,
  last_activity_date, status, open_branch_id,
  open_emp_id, avail_balance, pending_balance)
select a.prod_cd, c.cust_id, a.open_date, a.last_date, 'ACTIVE',
  e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join
 (select b.branch_id, e.emp_id
  from branch b inner join employee e on e.assigned_branch_id = b.branch_id
  where b.city = 'Woburn' limit 1) e
  cross join
 (select 'CHK' prod_cd, to_date('2004-01-15', 'YYYY-MM-DD') open_date, to_date('2009-01-04', 'YYYY-MM-DD') last_date,
    1057.75 avail, 1057.75 pend union all
  select 'SAV' prod_cd, to_date('2004-01-15', 'YYYY-MM-DD') open_date, to_date('2008-12-19', 'YYYY-MM-DD') last_date,
    500.00 avail, 500.00 pend union all
  select 'CD' prod_cd, to_date('2008-06-30', 'YYYY-MM-DD') open_date, to_date('2008-06-30', 'YYYY-MM-DD') last_date,
    3000.00 avail, 3000.00 pend) a
where c.fed_id = '111-11-1111';
insert into account (product_cd, cust_id, open_date,
  last_activity_date, status, open_branch_id,
  open_emp_id, avail_balance, pending_balance)
select a.prod_cd, c.cust_id, a.open_date, a.last_date, 'ACTIVE',
  e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join
 (select b.branch_id, e.emp_id
  from branch b inner join employee e on e.assigned_branch_id = b.branch_id
  where b.city = 'Woburn' limit 1) e
  cross join
 (select 'CHK' prod_cd, to_date('2005-03-12', 'YYYY-MM-DD') open_date, to_date('2008-12-27', 'YYYY-MM-DD') last_date,
    2258.02 avail, 2258.02 pend union all
  select 'SAV' prod_cd, to_date('2005-03-12', 'YYYY-MM-DD') open_date, to_date('2008-12-11', 'YYYY-MM-DD') last_date,
    200.00 avail, 200.00 pend) a
where c.fed_id = '222-22-2222';
insert into account (product_cd, cust_id, open_date,
  last_activity_date, status, open_branch_id,
  open_emp_id, avail_balance, pending_balance)
select a.prod_cd, c.cust_id, a.open_date, a.last_date, 'ACTIVE',
  e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join
 (select b.branch_id, e.emp_id
  from branch b inner join employee e on e.assigned_branch_id = b.branch_id
  where b.city = 'Quincy' limit 1) e
  cross join
 (select 'CHK' prod_cd, to_date('2006-11-23', 'YYYY-MM-DD') open_date, to_date('2008-11-30', 'YYYY-MM-DD') last_date,
    1057.75 avail, 1057.75 pend union all
  select 'MM' prod_cd, to_date('2006-12-15', 'YYYY-MM-DD') open_date, to_date('2008-12-05', 'YYYY-MM-DD') last_date,
    2212.50 avail, 2212.50 pend) a
where c.fed_id = '333-33-3333';
insert into account (product_cd, cust_id, open_date,
  last_activity_date, status, open_branch_id,
  open_emp_id, avail_balance, pending_balance)
select a.prod_cd, c.cust_id, a.open_date, a.last_date, 'ACTIVE',
  e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join
 (select b.branch_id, e.emp_id
  from branch b inner join employee e on e.assigned_branch_id = b.branch_id
  where b.city = 'Waltham' limit 1) e
  cross join
 (select 'CHK' prod_cd, to_date('2007-09-12', 'YYYY-MM-DD') open_date, to_date('2009-01-03', 'YYYY-MM-DD') last_date,
    534.12 avail, 534.12 pend union all
  select 'SAV' prod_cd, to_date('2004-01-15', 'YYYY-MM-DD') open_date, to_date('2008-10-24', 'YYYY-MM-DD') last_date,
    767.77 avail, 767.77 pend union all
  select 'MM' prod_cd, to_date('2008-09-30', 'YYYY-MM-DD') open_date, to_date('2008-11-11', 'YYYY-MM-DD') last_date,
    5487.09 avail, 5487.09 pend) a
where c.fed_id = '444-44-4444';
insert into account (product_cd, cust_id, open_date,
  last_activity_date, status, open_branch_id,
  open_emp_id, avail_balance, pending_balance)
select a.prod_cd, c.cust_id, a.open_date, a.last_date, 'ACTIVE',
  e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join
 (select b.branch_id, e.emp_id
  from branch b inner join employee e on e.assigned_branch_id = b.branch_id
  where b.city = 'Salem' limit 1) e
  cross join
 (select 'CHK' prod_cd, to_date('2008-01-27', 'YYYY-MM-DD') open_date, to_date('2009-01-05', 'YYYY-MM-DD') last_date,
    2237.97 avail, 2897.97 pend) a
where c.fed_id = '555-55-5555';
insert into account (product_cd, cust_id, open_date,
  last_activity_date, status, open_branch_id,
  open_emp_id, avail_balance, pending_balance)
select a.prod_cd, c.cust_id, a.open_date, a.last_date, 'ACTIVE',
  e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join
 (select b.branch_id, e.emp_id
  from branch b inner join employee e on e.assigned_branch_id = b.branch_id
  where b.city = 'Waltham' limit 1) e
  cross join
 (select 'CHK' prod_cd, to_date('2006-08-24', 'YYYY-MM-DD') open_date, to_date('2008-11-29', 'YYYY-MM-DD') last_date,
    122.37 avail, 122.37 pend union all
  select 'CD' prod_cd, to_date('2008-12-28', 'YYYY-MM-DD') open_date, to_date('2008-12-28', 'YYYY-MM-DD') last_date,
    10000.00 avail, 10000.00 pend) a
where c.fed_id = '666-66-6666';
insert into account (product_cd, cust_id, open_date,
  last_activity_date, status, open_branch_id,
  open_emp_id, avail_balance, pending_balance)
select a.prod_cd, c.cust_id, a.open_date, a.last_date, 'ACTIVE',
  e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join
 (select b.branch_id, e.emp_id
  from branch b inner join employee e on e.assigned_branch_id = b.branch_id
  where b.city = 'Woburn' limit 1) e
  cross join
 (select 'CD' prod_cd, to_date('2008-01-12', 'YYYY-MM-DD') open_date, to_date('2008-01-12', 'YYYY-MM-DD') last_date,
    5000.00 avail, 5000.00 pend) a
where c.fed_id = '777-77-7777';
insert into account (product_cd, cust_id, open_date,
  last_activity_date, status, open_branch_id,
  open_emp_id, avail_balance, pending_balance)
select a.prod_cd, c.cust_id, a.open_date, a.last_date, 'ACTIVE',
  e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join
 (select b.branch_id, e.emp_id
  from branch b inner join employee e on e.assigned_branch_id = b.branch_id
  where b.city = 'Salem' limit 1) e
  cross join
 (select 'CHK' prod_cd, to_date('2005-05-23', 'YYYY-MM-DD') open_date, to_date('2009-01-03', 'YYYY-MM-DD') last_date,
    3487.19 avail, 3487.19 pend union all
  select 'SAV' prod_cd, to_date('2005-05-23', 'YYYY-MM-DD') open_date, to_date('2008-10-12', 'YYYY-MM-DD') last_date,
    387.99 avail, 387.99 pend) a
where c.fed_id = '888-88-8888';
insert into account (product_cd, cust_id, open_date,
  last_activity_date, status, open_branch_id,
  open_emp_id, avail_balance, pending_balance)
select a.prod_cd, c.cust_id, a.open_date, a.last_date, 'ACTIVE',
  e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join
 (select b.branch_id, e.emp_id
  from branch b inner join employee e on e.assigned_branch_id = b.branch_id
  where b.city = 'Waltham' limit 1) e
  cross join
 (select 'CHK' prod_cd, to_date('2007-07-30', 'YYYY-MM-DD') open_date, to_date('2008-12-15', 'YYYY-MM-DD') last_date,
    125.67 avail, 125.67 pend union all
  select 'MM' prod_cd, to_date('2008-10-28', 'YYYY-MM-DD') open_date, to_date('2008-10-28', 'YYYY-MM-DD') last_date,
    9345.55 avail, 9845.55 pend union all
  select 'CD' prod_cd, to_date('2008-06-30', 'YYYY-MM-DD') open_date, to_date('2008-06-30', 'YYYY-MM-DD') last_date,
    1500.00 avail, 1500.00 pend) a
where c.fed_id = '999-99-9999';

/* corporate account data */
insert into account (product_cd, cust_id, open_date,
  last_activity_date, status, open_branch_id,
  open_emp_id, avail_balance, pending_balance)
select a.prod_cd, c.cust_id, a.open_date, a.last_date, 'ACTIVE',
  e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join
 (select b.branch_id, e.emp_id
  from branch b inner join employee e on e.assigned_branch_id = b.branch_id
  where b.city = 'Salem' limit 1) e
  cross join
 (select 'CHK' prod_cd, to_date('2006-09-30', 'YYYY-MM-DD') open_date, to_date('2008-12-15', 'YYYY-MM-DD') last_date,
    23575.12 avail, 23575.12 pend union all
  select 'BUS' prod_cd, to_date('2006-10-01', 'YYYY-MM-DD') open_date, to_date('2008-08-28', 'YYYY-MM-DD') last_date,
    0 avail, 0 pend) a
where c.fed_id = '04-1111111';
insert into account (product_cd, cust_id, open_date,
  last_activity_date, status, open_branch_id,
  open_emp_id, avail_balance, pending_balance)
select a.prod_cd, c.cust_id, a.open_date, a.last_date, 'ACTIVE',
  e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join
 (select b.branch_id, e.emp_id
  from branch b inner join employee e on e.assigned_branch_id = b.branch_id
  where b.city = 'Woburn' limit 1) e
  cross join
 (select 'BUS' prod_cd, to_date('2008-03-22', 'YYYY-MM-DD') open_date, to_date('2008-11-14', 'YYYY-MM-DD') last_date,
    9345.55 avail, 9345.55 pend) a
where c.fed_id = '04-2222222';
insert into account (product_cd, cust_id, open_date,
  last_activity_date, status, open_branch_id,
  open_emp_id, avail_balance, pending_balance)
select a.prod_cd, c.cust_id, a.open_date, a.last_date, 'ACTIVE',
  e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join
 (select b.branch_id, e.emp_id
  from branch b inner join employee e on e.assigned_branch_id = b.branch_id
  where b.city = 'Salem' limit 1) e
  cross join
 (select 'CHK' prod_cd, to_date('2007-07-30', 'YYYY-MM-DD') open_date, to_date('2008-12-15', 'YYYY-MM-DD') last_date,
    38552.05 avail, 38552.05 pend) a
where c.fed_id = '04-3333333';
insert into account (product_cd, cust_id, open_date,
  last_activity_date, status, open_branch_id,
  open_emp_id, avail_balance, pending_balance)
select a.prod_cd, c.cust_id, a.open_date, a.last_date, 'ACTIVE',
  e.branch_id, e.emp_id, a.avail, a.pend
from customer c cross join
 (select b.branch_id, e.emp_id
  from branch b inner join employee e on e.assigned_branch_id = b.branch_id
  where b.city = 'Quincy' limit 1) e
  cross join
 (select 'SBL' prod_cd, to_date('2008-02-22', 'YYYY-MM-DD') open_date, to_date('2008-12-17', 'YYYY-MM-DD') last_date,
    50000.00 avail, 50000.00 pend) a
where c.fed_id = '04-4444444';

/* put $100 in all checking/savings accounts on date account opened */
insert into transaction (txn_date, account_id, txn_type_cd,
  amount, funds_avail_date)
select a.open_date, a.account_id, 'CDT', 100, a.open_date
from account a
where a.product_cd IN ('CHK','SAV','CD','MM');

/* end data population */