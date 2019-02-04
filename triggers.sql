create or replace function insert_pk_to_offer() returns trigger as $$
begin
  insert into offers values (new.offer_id, new.price, new.validity, new.reward_points);
  return new;
end;
$$ language plpgsql;



drop trigger if exists insert_internet_pk_to_parent on internet_offer;
create trigger insert_internet_pk_to_parent after insert on internet_offer
for each row
  execute procedure insert_pk_to_offer();


drop trigger if exists insert_talk_time_pk_to_parent on talk_time_offer;
create trigger insert_talk_time_pk_to_parent after insert on talk_time_offer
for each row
  execute procedure insert_pk_to_offer();

drop trigger if exists insert_sms_pk_to_parent on sms_offer;
create trigger insert_sms_pk_to_parent after insert on sms_offer
for each row
  execute procedure insert_pk_to_offer();

drop trigger if exists insert_reward_pk_to_parent on reward_offer;
create trigger insert_reward_pk_to_parent after insert on reward_offer
for each row
  execute procedure insert_pk_to_offer();

drop trigger if exists insert_general_pk_to_parent on general_offer;
create trigger insert_general_pk_to_parent after insert on general_offer
for each row
  execute procedure insert_pk_to_offer();

