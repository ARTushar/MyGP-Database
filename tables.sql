CREATE TABLE "users" (
  "mobile_number" number,
  "balance" number,
  "total_mb" number,
  "total_rewards_point" number,
  "emergency_balance_due" number,
  "name" varchar2(40),
  "total_talktime" number,
  "tatal_sms" number,
  "package_id" number,
  "star_id" number
);

CREATE TABLE "user_voucher" (
  "user_id" number,
  "voucher_id" number
);

CREATE TABLE "user_link" (
  "linked_by" number,
  "linked_to" number
);

CREATE TABLE "fnf" (
  "fnf_by" number,
  "fnf_to" number
);

CREATE TABLE "purchase_offer" (
  "purchased_user" number,
  "offer_id" number,
  "purchased_date" number
);

CREATE TABLE "package" (
  "id" number,
  "name" varchar2(40),
  "call_rate" number,
  "sms_rate" number,
  "fnf_limit" number
);

CREATE TABLE "history" (
  "history_date" date,
  "user_id" number
);

CREATE TABLE "recharge_history" (
  "amount" number,
  "validity" date
);

CREATE TABLE "internet_history" (
  "mb_used" number
);

CREATE TABLE "sms_history" (
  "number_sms" number,
  "cost" number,
  "type" varchar2(20)
);

CREATE TABLE "call_history" (
  "call_number" number,
  "cost" number,
  "type" varchar2(20)
);

CREATE TABLE "offer" (
  "id" number,
  "price" number,
  "expire_date" date,
  "rewards_point" number
);

CREATE TABLE "rewards_offer" (
  "points_need" number,
  "mb_amount" number
);

CREATE TABLE "sms_offer" (
  "sms_amount" number
);

CREATE TABLE "general_offer" (
  "minute" number,
  "data_amount" number,
  "sms_amount" number
);

CREATE TABLE "internet_offer" (
  "data_amount" number
);

CREATE TABLE "talktime_offer" (
  "talktime_amount" number
);

CREATE TABLE "emergency_balance" (
  "amount" number,
  "validity" date,
  "taken_date" date
);

CREATE TABLE "notifications" (
  "message" varchar2(400)
);

CREATE TABLE "vouchers" (
  "id" number,
  "code" number,
  "validity" date,
  "description" varchar2(200)
);

CREATE TABLE "star" (
  "id" number,
  "type" varchar2(20),
  "average_uses" number,
  "validity" date
);

CREATE TABLE "stars_offer" (
  "id" number,
  "name" varchar2(20),
  "title" varchar2(40),
  "description" varchar2(400)
);