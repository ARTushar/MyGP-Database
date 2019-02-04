--showing username, balance, total_data, total_talk_time, total_sms
select user_name, balance, total_mb, total_talk_time, total_offer_sms
from users where mobile_number = 1755840785;

--showing call_history
select call_number, to_char(h_date, 'YYYY-MM-DD HH12:MI:SS PM') as date, cost, type
from call_history where user_id = 1755840785;

--showing sms_history
select sms_number, to_char(h_date, 'YYYY-MM-DD HH12:MI:SS PM') as date, cost, type
from sms_history where user_id = 1755840785;

--showing internet_history
select mb_used, to_char(h_date, 'YYYY-MM-DD HH12:MI:SS PM') as date
from internet_history where user_id = 1755840785;

--showing recharge_history
select amount, validity, to_char(h_date, 'YYYY-MM HH12:MI:SS PM') as recharged_time
from recharge_history where  user_id = 1755840785;

--showing reward_offer
select mb_amount, points_need, validity
from reward_offer;

--showing talk_time_offer
select talk_time, validity, price, reward_points
from talk_time_offer;

--showing sms_offer
select sms_amount, validity, price, reward_points
from sms_offer;

--showing data_offer
select data_amount, validity, price, reward_points
from internet_offer;

--showing packages
select package_name, call_rate, data_rate, fnf_limit
from package;

--showing notifications
select message from notifications
where user_id = 1755840785;