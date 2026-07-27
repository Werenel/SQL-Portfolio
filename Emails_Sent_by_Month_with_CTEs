/* 
dates : звожу в таблицю email_sent, account_session та session для отримання точної дати та місця відправки
month_data: рахую загальну кількість відправлених повідомлень за кожен місяць.
acc_data: агрегую кількість повідомлень, а також першу та останню дату відправки в рёозрізі акаунтів
фінальний запит: об’єднання даних та обчислення відсотку активності кожного аккаунта відносно всього місяця
*/

WITH
  dates AS (
    SELECT
      es.id_message,
      es.id_account,
      DATE_ADD(s.date, INTERVAL es.sent_date DAY) AS date_sent,
      EXTRACT(MONTH FROM DATE_ADD(s.date, INTERVAL es.sent_date DAY))
        AS sent_month
    FROM `data-analytics-mate.DA.email_sent` AS es
    JOIN `data-analytics-mate.DA.account_session` AS acs
      ON es.id_account = acs.account_id
    JOIN `data-analytics-mate.DA.session` AS s
      ON acs.ga_session_id = s.ga_session_id
  ),
  month_data AS (
    SELECT
      sent_month,
      COUNT(id_message) AS msg_month
    FROM dates
    GROUP BY 1
  ),
  acc_data AS (
    SELECT
      sent_month,
      id_account,
      COUNT(id_message) AS msg_acc,
      MIN(date_sent) AS first_sent_date,
      MAX(date_sent) AS last_sent_date
    FROM dates
    GROUP BY 1, 2
  )
SELECT
  a.sent_month,
  a.id_account,
  (a.msg_acc / m.msg_month) * 100 AS sent_msg_percent_from_this_month,
  a.first_sent_date,
  a.last_sent_date
FROM acc_data AS a
JOIN month_data AS m
  ON a.sent_month = m.sent_month
ORDER BY
  a.sent_month,
  a.id_account;






