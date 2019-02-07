-- show the user_name of those users who use djuice package and
-- they have used al least 1000 taka in the past 60 days

/*select user_name from users u
where package_id  = (select package_id
  from package where package_name = "DJUICE"
  ) and (
    select sum()
    from purchase_offer p inner join where
    p.user_id = u.mobile_number
    and
  )*/

-- show the user_name and total number of sms he or she
-- has sent in the past 90 days of those users who have used
-- the same offer of any kinds more than or equal 3 times in the past 60 days

select user_name, (
  select count(*)
  from sms_history where
  user_id = u.mobile_number and now() - h_date <= interval  '1 day' * 90
  and type = 'outgoing'
  ) sms_sent
from users u
where 3 <= max_same_offer_used(u.mobile_number, 90);


create or replace function max_same_offer_used(in mob numeric, in days numeric)
returns int as $$
  declare
    max_count int;
    offer cursor for select count(user_id) tcount
    from purchase_offer where user_id = mob and
          now() - purchase_date <= interval '1 day' * days
    group by offer_id;
  begin
    max_count := 0;
    for r in offer
    loop
      if max_count < r.tcount then
        max_count := r.tcount;
      end if;
    end loop;
    return max_count;
  end;
  $$ language plpgsql;


-- show the users star status those who have taken the offer
-- that have been purchased maximum number of times
select offer_id
from offers ofer
  where (select max(count) from (
  select offer_id, count(purchase_offer.offer_id)
  from purchase_offer
  group by offer_id
  ) count) in (
  select count(purchase_offer.offer_id)
  from purchase_offer
  group by offer_id)


