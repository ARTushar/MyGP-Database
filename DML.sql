INSERT INTO INTERNET_OFFER (OFFER_ID, PRICE, VALIDITY, REWARD_POINTS, DATA_AMOUNT) VALUES
(100, 56, 30, NULL, 115),
(101, 31, 3, 25, 252),
(102, 10, 7, NULL, 10);

INSERT INTO TALK_TIME_OFFER (OFFER_ID, PRICE, VALIDITY, REWARD_POINTS, TALK_TIME) VALUES
(200, 140, 7, NULL, 250),
(201, 30, 1, NULL, 50);

INSERT INTO SMS_OFFER (OFFER_ID, PRICE, VALIDITY, REWARD_POINTS, SMS_AMOUNT) VALUES
(300, 10, 2, NULL, 20);

INSERT INTO PACKAGE (PACKAGE_ID, PACKAGE_NAME, CALL_RATE, SMS_RATE, data_rate, FNF_LIMIT) VALUES
(10, 'BONDHU', .275, .50, 1.5, 18),
(11, 'NISHCHINTO', .22, .50, 1.4, 0),
(12, 'DJUICE', .22, .50, 1.6, 13);

INSERT INTO STAR VALUES (1, 'PLATINUM_PLUS', 4000, 180);
INSERT INTO STAR VALUES (2, 'PLATINUM', 3000, 180);
INSERT INTO STAR VALUES (3, 'GOLD', 2500, 180);
INSERT INTO STAR VALUES (4, 'SILVER', 2000, 180);

INSERT INTO USERS VALUES
(01755840785, 13.4, 10, 185, 0, 'RAJU', 0, 0, 10, NULL, NULL),
(01787571129, 20.9, 50, 200, 0, 'TUSHAR', 5, 10, 11, 1, NULL);

