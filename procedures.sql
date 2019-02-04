
create or replace procedure recharge_account(in mob_number numeric, in amount numeric) as $$
  declare
  old_amount numeric;
  cur_timestamp timestamptz;
  validity numeric;
  end_date varchar(100);
  begin
    select balance into old_amount from users where mobile_number = mob_number;
    cur_timestamp := now();
    validity := find_recharge_last_date(amount);
    end_date := to_char(cur_timestamp + interval '1 day' * validity:: date, 'yyyy-mm-dd hh12:mi:ss am');
    insert into recharge_history values (cur_timestamp, mob_number, amount, validity);
    update users set  balance = old_amount + amount where mobile_number = mob_number;
    insert into notifications
    values (mob_number, 'You have successfully recharged ' ||
    amount || ' taka in your account balance. Your current account balance is '
    || old_amount+ amount || ' taka. Your balance will be expired on '|| end_date);
    raise notice 'successfully recharged % taka in the account', amount;
  exception when others then
    raise notice 'cannot insert the updated info into the recharge_history or users or notifications :(';
  end;
  $$ language plpgsql;

create or replace function find_recharge_last_date(in amount numeric) returns numeric as $$
  declare
  valid_days numeric;
    begin
    if(amount < 50) then
      valid_days := 30;
    else valid_days := 60;
    end if;
    return valid_days;
  end;
  $$ language plpgsql;

create or replace procedure purchase_sms_offer(in offer_no numeric, in user_no numeric) as $$
  declare
    purchased_timestamp timestamptz;
    cost numeric;
    end_date varchar(100);
    valid numeric;
    reward_point numeric;
    sms_total numeric;
    old_reward_point numeric;
    old_account_balance numeric;
    old_sms numeric;
  begin
    purchased_timestamp := now();
    select price, validity, reward_points, sms_amount  from sms_offer where  offer_id = offer_no
    into cost, valid, reward_point, sms_total;
    select total_reward_point, balance, total_offer_sms from users into
      old_reward_point, old_account_balance, old_sms;
    if old_account_balance >= cost then
      end_date := to_char(purchased_timestamp + interval '1 day' * valid, 'yyyy-mm-dd hh12:mi:ss am');
      insert into purchase_offer values (user_no, offer_no,purchased_timestamp);
      insert into notifications values (user_no, 'You have successfully purchased '
      ||sms_total || '. '||cost || ' taka has been deducted from your account balance.'
      ||' The sms bundle will expire on '|| end_date);
      update users set(total_reward_point, total_offer_sms, balance) =
      (old_reward_point+reward_point, old_sms + sms_total, old_account_balance-cost);
      raise notice 'successfully purchased a sms offer : %',offer_no;
    else
    raise notice 'have not sufficient balance';
    end if;

    exception
    when others then
    raise notice 'cannot purchase the sms offer %', offer_no;
  end;
  $$ language plpgsql;


create or replace procedure purchase_talk_time_offer(in offer_no numeric, in user_no numeric) as $$
  declare
    purchased_timestamp timestamptz;
    cost numeric;
    end_date varchar(100);
    valid numeric;
    reward_point numeric;
    talk_time_total numeric;
    old_reward_point numeric;
    old_account_balance numeric;
    old_talk_time numeric;
  begin
    purchased_timestamp := now();
    select price, validity, reward_points, talk_time  from talk_time_offer where  offer_id = offer_no
    into cost, valid, reward_point, talk_time_total;
    select total_reward_point, balance, total_talk_time from users into
      old_reward_point, old_account_balance, old_talk_time;
    if old_account_balance >= cost then
      end_date := to_char(purchased_timestamp + interval '1 day' * valid, 'yyyy-mm-dd hh12:mi:ss am');
      insert into purchase_offer values (user_no, offer_no,purchased_timestamp);
      insert into notifications values (user_no, 'You have successfully purchased '
      ||talk_time_total || ' minutes. '||cost || ' taka has been deducted from your account balance.'
      ||' The talk time bundle will expire on '|| end_date);
      insert into users(total_reward_point, total_talk_time, balance) values
      (old_reward_point+reward_point, old_talk_time + talk_time_total, old_account_balance-cost);
      raise notice 'successfully purchased a talk time offer : %',offer_no;
    else
    raise notice 'have not sufficient balance';
    end if;

    exception  when others then
    raise notice 'cannot purchase the talk time offer %', offer_no;
  end;
  $$ language plpgsql;


create or replace procedure purchase_general_offer
  (in user_no numeric, in min numeric, in data numeric, in sms numeric, in valid numeric)
as $$
  declare
    purchased_timestamp timestamptz;
    cost numeric;
    end_date varchar(100);
    old_account_balance numeric;
    old_talk_time numeric;
    old_data numeric;
    old_sms numeric;
    offer_no numeric;
  begin
    purchased_timestamp := now();
    select balance, total_talk_time, total_mb, total_offer_sms from users into
    old_account_balance, old_talk_time, old_data, old_sms;
    cost := count_general_offer_price(sms, data, min);

    if old_account_balance >= cost then
      end_date := to_char(purchased_timestamp + interval '1 day' * valid, 'yyyy-mm-dd hh12:mi:ss am');
      offer_no = nextval(pg_get_serial_sequence('general_offer', 'custom_id'));
      insert into general_offer(offer_id, price, validity, reward_points, munite, mb_amount, sms_amount)
      values (offer_no, cost,valid, 0, min, data, sms);
      insert into purchase_offer values(user_no, offer_no, purchased_timestamp);
      insert into notifications values (user_no, 'You have successfully purchased '
      ||min || ' minutes. ' || data || ' mb. ' || sms || ' sms. ' ||cost || ' taka has been deducted from your account balance.'
      ||' The offer will expire on '|| end_date);
      update users set (total_mb, total_talk_time, total_offer_sms, balance) =
      (old_data+data, old_talk_time + min,old_sms+sms,  old_account_balance-cost);
      raise notice 'successfully purchased a general offer : %',offer_no;
    else
    raise notice 'have not sufficient balance';
    end if;

    exception
    when others then
    raise notice 'cannot purchase the general offer %', offer_no;
  end;
  $$ language plpgsql;

create or replace function count_general_offer_price(in sms numeric, in data numeric, in talk numeric)
 returns numeric as $$
declare
  price numeric;
  sms_cost numeric;
  data_cost numeric;
  talk_time_cost numeric;
begin
  select call_rate, sms_rate, data_rate from package into talk_time_cost, sms_cost, data_cost;
  price := sms_cost*4/5 * sms + talk_time_cost*4/5 * talk + data_cost * 4/5 * data;
  return price;
end;

$$ language plpgsql;


create or replace procedure purchase_internet_offer(in offer_no numeric, in user_no numeric) as $$
  declare
    purchased_timestamp timestamptz;
    cost numeric;
    end_date varchar(100);
    valid numeric;
    reward_point numeric;
    data_total numeric;
    old_reward_point numeric;
    old_account_balance numeric;
    old_data numeric;
  begin
    purchased_timestamp := now();
    select price, validity, reward_points, data_amount  from internet_offer where  offer_id = offer_no
    into cost, valid, reward_point, data_total;
    select total_reward_point, balance, total_mb from users into
      old_reward_point, old_account_balance, old_data;

    if old_account_balance >= cost then
      end_date := to_char(purchased_timestamp + interval '1 day' * valid, 'yyyy-mm-dd hh12:mi:ss am');
      if ((select count(*) from offers where offer_id = offer_no) = 1) then
        raise notice 'is present in the table';
      end if;
      insert into purchase_offer values (user_no, offer_no,purchased_timestamp);
      insert into notifications values (user_no, 'You have successfully purchased '
      ||data_total || ' mb. '||cost || ' taka has been deducted from your account balance.'
      ||' The data amount will expire on '|| end_date);
      update users set (total_reward_point, total_mb, balance) =
      (old_reward_point+reward_point, old_data + data_total, old_account_balance-cost);
      raise notice 'successfully purchased a data offer : %',offer_no;
    else
      raise notice 'have not sufficient balance';
    end if;

  exception
   when others then
    raise notice 'cannot purchase the data offer %', offer_no;
  end;
  $$ language plpgsql;

create or replace procedure purchase_reward_offer(in user_no numeric, in offer_no numeric) as $$
declare
    purchased_timestamp timestamptz;
    end_date varchar(100);
    valid numeric;
    reward_point numeric;
    data_total numeric;
    old_reward_point numeric;
    old_data numeric;
 begin
    purchased_timestamp := now();
    select  validity, points_need, mb_amount  from reward_offer where  offer_id = offer_no
    into valid, reward_point, data_total;
    select total_reward_point, total_mb from users into
      old_reward_point, old_data;

    if old_reward_point >= reward_point then
      end_date := to_char(purchased_timestamp + interval '1 day' * valid, 'yyyy-mm-dd hh12:mi:ss am');
      if ((select count(*) from offers where offer_id = offer_no) = 1) then
        raise notice 'is present in the table';
      end if;
      insert into purchase_offer values (user_no, offer_no,purchased_timestamp);
      insert into notifications values (user_no, 'You have successfully purchased '
      ||data_total || ' mb. '|| reward_point || ' reward points have been deducted from your total reward points.'
      ||' The data amount will expire on '|| end_date);
      update users set (total_reward_point, total_mb) =
      (old_reward_point-reward_point, old_data + data_total);
      raise notice 'successfully purchased a data offer : % using reward points',offer_no;
    else
      raise notice 'have not sufficient reward points';
    end if;

  exception
   when others then
    raise notice 'cannot purchase the data offer % using the reward points', offer_no;
  end;

$$ language plpgsql;

create or replace procedure make_fnf(in number_by numeric, in number_to numeric) as $$
declare
begin
    insert into fnf values(number_by, number_to);
    raise notice 'successfully inserted the fnf';
    exception when others then
    raise notice 'cannot insert the fnf';
end;
$$ language plpgsql;

create or replace procedure make_link(in number_by numeric, in number_to numeric) as $$
declare
begin
  insert into link values (number_by, number_to);
  raise notice 'successfully inserted the link';
  exception when others then
  raise notice 'cannot insert the link';

end;
$$ language plpgsql;

create or replace procedure migrate_package(in mob_number numeric, in p_name varchar(40)) as $$
declare
  p_id numeric;
begin
  select p_id from package where package_name = p_name into p_id;
  update users set package_id = p_id where mobile_number = mob_number;
end;

  $$ language plpgsql;