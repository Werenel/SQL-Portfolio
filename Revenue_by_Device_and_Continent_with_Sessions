/* 
revenue_usd: розрахунок загального доходу та розподіляю його на мобільні й десктопні пристрої в розрізі континентів.
revenue_percent: за допомогою віконної функції обчислюю, яку частку приносить кожен континент від усього доходу.
registrarion: визначаю кількість створених та успішно верифікованих акаунтів для кожного континенту.
session_cnt: рахую кількість уніклаьних сесій.
Фінальний запит: збираю усі підготовлені метрики в одну вітрину даних, об’єднуючи їх за континентом.
*/

WITH
  revenue_usd AS (
    SELECT
      sp.continent,
      SUM(p.price) AS revenue,
      SUM(CASE WHEN device = 'mobile' THEN p.price END) AS revenue_from_mobile,
      SUM(CASE WHEN device = 'desktop' THEN p.price END) AS revenue_from_desktop
    FROM `DA.order` o
    JOIN `DA.product` p
      ON o.item_id = p.item_id
    JOIN `DA.session_params` sp
      ON o.ga_session_id = sp.ga_session_id
    GROUP BY
      sp.continent
  ),
  
  revenue_percent AS ( 
    SELECT
      continent,
      revenue / SUM(revenue) OVER() * 100 AS revenue_from_total
    FROM revenue_usd
  ),

  registration AS (
    SELECT
      sp.continent,
      COUNT(ac.account_id) AS account_cnt,
      COUNT(CASE WHEN a.is_verified = 1 THEN ac.account_id END) AS verified_account
    FROM `DA.session_params` sp
    LEFT JOIN `DA.account_session` ac
      ON sp.ga_session_id = ac.ga_session_id
    LEFT JOIN `DA.account` AS a
      ON a.id = ac.account_id
    GROUP BY
      1
  ), 


  session_cnt AS (
    SELECT
      continent,
      COUNT(DISTINCT ga_session_id) AS session_count
    FROM `DA.session_params`
    GROUP BY
      continent
  )


SELECT
  sc.continent AS Continent,
  ru.revenue AS Revenue,
  ru.revenue_from_mobile AS `Revenue from Mobile`,
  ru.revenue_from_desktop AS `Revenue from Desktop`,
  rp.revenue_from_total AS `% Revenue from Total`,
  reg.account_cnt AS `Account Count`,
  reg.verified_account AS `Verified Account`,
  sc.session_count AS `Session Count`
FROM session_cnt sc
LEFT JOIN registration reg 
  ON sc.continent = reg.continent
LEFT JOIN revenue_usd ru
  ON sc.continent = ru.continent
LEFT JOIN revenue_percent rp 
  ON sc.continent = rp.continent;


