INSERT INTO INTERNET_OFFER (OFFER_ID, PRICE, VALIDITY, REWARD_POINTS, DATA_AMOUNT) VALUES
(100, 56, 30, 0, 115),
(101, 31, 3, 25, 252),
(102, 10, 7, 0, 10);

INSERT INTO TALK_TIME_OFFER (OFFER_ID, PRICE, VALIDITY, REWARD_POINTS, TALK_TIME) VALUES
(200, 140, 7, 0, 250),
(201, 30, 1, 0, 50);

INSERT INTO SMS_OFFER (OFFER_ID, PRICE, VALIDITY, REWARD_POINTS, SMS_AMOUNT) VALUES
(300, 10, 2, 0, 20);

INSERT INTO PACKAGE (PACKAGE_ID, PACKAGE_NAME, CALL_RATE, SMS_RATE, data_rate, FNF_LIMIT) VALUES
(10, 'BONDHU', .275, .50, 1.5, 18),
(11, 'NISHCHINTO', .22, .50, 1.4, 0),
(12, 'DJUICE', .22, .50, 1.6, 13);

INSERT INTO STAR VALUES (1, 'PLATINUM_PLUS', 4000, 180);
INSERT INTO STAR VALUES (2, 'PLATINUM', 3000, 180);
INSERT INTO STAR VALUES (3, 'GOLD', 2500, 180);
INSERT INTO STAR VALUES (4, 'SILVER', 2000, 180);
INSERT INTO STAR VALUES (0, 'NOT_STAR', 0, 0);


INSERT INTO USERS VALUES
(01755840785, 13.4, 10, 185, 0, 'RAJU', 0, 0, 10, NULL, NULL),
(01787571129, 20.9, 50, 200, 0, 'TUSHAR', 5, 10, 11, 1, NULL);

delete from package;
copy package from 'E:\Dropbox\Level 2 Term 2\Database Sessional\Project MyGP\MyGP\MyGP-Database\Data\package.csv'
with (null  'minus',
delimiter ',');

delete from reward_offer;
copy reward_offer from 'E:\Dropbox\Level 2 Term 2\Database Sessional\Project MyGP\MyGP\MyGP-Database\Data\reward_offer.csv'
with (null  'minus',
delimiter ',');

delete from internet_offer;
copy internet_offer
from 'E:\Dropbox\Level 2 Term 2\Database Sessional\Project MyGP\MyGP\MyGP-Database\Data\data_offer.csv'
with (null  'minus',
delimiter ',');


delete from sms_offer;
copy sms_offer
from 'E:\Dropbox\Level 2 Term 2\Database Sessional\Project MyGP\MyGP\MyGP-Database\Data\sms_offer.csv'
with (null  'minus',
delimiter ',');

delete from talk_time_offer;
copy talk_time_offer
from 'E:\Dropbox\Level 2 Term 2\Database Sessional\Project MyGP\MyGP\MyGP-Database\Data\talk_time_offer.csv'
with (null  'minus',
delimiter ',');

delete from users;
copy users
from 'E:\Dropbox\Level 2 Term 2\Database Sessional\Project MyGP\MyGP\MyGP-Database\Data\user.csv'
with (null  'minus',
delimiter ',');

delete from fnf;
copy fnf
from 'E:\Dropbox\Level 2 Term 2\Database Sessional\Project MyGP\MyGP\MyGP-Database\Data\fnf.csv'
with (null  'minus',
delimiter ',');

delete from link;
copy link
from 'E:\Dropbox\Level 2 Term 2\Database Sessional\Project MyGP\MyGP\MyGP-Database\Data\link.csv'
with (null  'minus',
delimiter ',');


delete from purchase_offer;
copy purchase_offer
from 'E:\Dropbox\Level 2 Term 2\Database Sessional\Project MyGP\MyGP\MyGP-Database\Data\purchase_offer.csv'
with (null  'minus',
delimiter ',');

delete from recharge_history;
copy recharge_history
from 'E:\Dropbox\Level 2 Term 2\Database Sessional\Project MyGP\MyGP\MyGP-Database\Data\recharge_history.csv'
with (null  'minus',
delimiter ',');

delete from sms_history;
copy sms_history
from 'E:\Dropbox\Level 2 Term 2\Database Sessional\Project MyGP\MyGP\MyGP-Database\Data\sms_history.csv'
with (null  'minus',
delimiter ',');

delete from internet_history;
copy internet_history
from 'E:\Dropbox\Level 2 Term 2\Database Sessional\Project MyGP\MyGP\MyGP-Database\Data\data_history.csv'
with (null  'minus',
delimiter ',');

delete from call_history;
copy call_history
from 'E:\Dropbox\Level 2 Term 2\Database Sessional\Project MyGP\MyGP\MyGP-Database\Data\call_history.csv'
with (null  'minus',
delimiter ',');

