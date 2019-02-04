--showing username, balance, total_data, total_talk_time, total_sms
select user_name, balance, total_mb, total_talk_time, total_offer_sms
from users where mobile_number = 1755840785;

--showing call_history
select call_number, to_char(h_date, 'YYYY-MM-DD HH12:MI:SS PM') as date, cost, type
from call_history where user_id = 1755840785;
