create database mygp;

do  $$
  declare
  ccc int;
begin
  ccc := max_same_offer_used(1727109552, 90);
  raise notice '%', ccc;
end;
$$;

select * from pg_timezone_names;

set timezone = 'asia/dhaka';
do $$
begin
raise notice 'the current month date and time is %',to_char((now()-interval '1 day' * 30), 'yyyy-mm-dd hh12:mi:ss pm');
end;
$$;


copy random_table to 'e:\dopbox\dropbox\level 2 term 2\database sessional\project mygp\new\mygp-database\timestamp.csv'
with (null  'minus',
delimiter ',');

create table random_table(
  random_time timestamptz
);
copy random_table from 'e:\dopbox\dropbox\level 2 term 2\database sessional\project mygp\new\mygp-database\timestamp.csv'

do $$
declare
count int;
begin
  count := 0;
  loop
    insert into random_table values (now() - interval '1 day' * random() * 180);
    count:= count + 1;
    if count = 50000 then
      exit;
    end if;
  end loop;
end;
$$;
