/*
Внутрішній підзапит (base data): збираю всі таблиці до купи через join і один раз обчислюю правильну дату (actual_msg_date), щоб уникнути дублювання
Основний розрахунок (final_calc): використовую вікконі функції для підрахунку повідомлень на акаунт (msg_per_acc_month) та загалом за місяць (msg_total_amount) для подальшого розрахунку відсотків. Тут же знахожу min та max для визначення першої і останньої дати.
Зовнішній запит: провожу чистову роботу - вивожу унікальні рядки distinct, беру тільки необхідні дані та розраховую фінальну формулу.
*/



SELECT DISTINCT
  sent_month,
  id_account,
  msg_per_acc_month / msg_total_month * 100 AS sent_msg_percent,
  first_sent_date,
  last_sent_date
FROM (
  SELECT 
    id_account,
    DATE_TRUNC(actual_msg_date, MONTH) AS sent_month,
    COUNT(id_message) OVER(PARTITION BY id_account, DATE_TRUNC(actual_msg_date, MONTH)) AS msg_per_acc_month,
    COUNT(id_message) OVER(PARTITION BY DATE_TRUNC(actual_msg_date, MONTH)) AS msg_total_month,
    MIN(actual_msg_date) OVER(PARTITION BY id_account, DATE_TRUNC(actual_msg_date, MONTH)) AS first_sent_date,
    MAX(actual_msg_date) OVER(PARTITION BY id_account, DATE_TRUNC(actual_msg_date, MONTH)) AS last_sent_date
  FROM (
    SELECT 
      es.id_account,
      es.id_message,
      DATE_ADD(s.date, INTERVAL es.sent_date DAY) AS actual_msg_date
    FROM `data-analytics-mate.DA.email_sent` AS es
    JOIN `data-analytics-mate.DA.account_session` AS acs ON es.id_account = acs.account_id
    JOIN `data-analytics-mate.DA.session` AS s ON acs.ga_session_id = s.ga_session_id
  ) AS base_data
) AS final_calc
ORDER BY sent_month, id_account;


