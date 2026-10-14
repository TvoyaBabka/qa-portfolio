-- 1. Посчитай, сколько компаний закрылось.
SELECT COUNT(*)
FROM company
WHERE status = 'closed';

-- 2. Отобрази количество привлечённых средств для новостных компаний США.
-- Используй данные из таблицы company.
-- Отсортируй таблицу по убыванию значений в поле funding_total.
SELECT funding_total
FROM company
WHERE category_code = 'news'
  AND country_code = 'USA'
ORDER BY funding_total DESC;

-- 3. Отобрази имя, фамилию и названия аккаунтов людей в поле
-- network_username, которые начинаются на 'Silver'.
SELECT first_name,
       last_name,
       network_username
FROM people
WHERE network_username LIKE 'Silver%';

-- 4. Выведи всю информацию о людях, у которых названия аккаунтов
-- в поле network_username содержат подстроку 'money',
-- а фамилия начинается на 'K'.
SELECT *
FROM people
WHERE network_username LIKE '%money%'
  AND last_name LIKE 'K%';

-- 5. Для каждой страны отобрази общую сумму привлечённых инвестиций,
-- которые получили компании, зарегистрированные в этой стране.
-- Страна определяется по коду страны.
-- Отсортируй данные по убыванию суммы.
SELECT country_code,
       SUM(funding_total)
FROM company
GROUP BY country_code
ORDER BY SUM(funding_total) DESC;

-- 6. Отобрази имя и фамилию всех сотрудников стартапов.
-- Добавь название учебного заведения, которое окончил сотрудник,
-- если эта информация известна.
SELECT p.first_name,
       p.last_name,
       e.instituition
FROM people AS p
LEFT JOIN education AS e
    ON p.id = e.person_id;

-- 7. Найди общую сумму сделок по покупке одних компаний другими в долларах.
-- Отбери сделки только за наличные с 2011 по 2013 год включительно.
SELECT SUM(price_amount)
FROM acquisition
WHERE term_code = 'cash'
  AND acquired_at BETWEEN '2011-01-01' AND '2013-12-31';

-- 8. Для каждой страны посчитай минимальное, максимальное и среднее число
-- компаний, в которые инвестировали фонды этой страны,
-- основанные с 2010 по 2012 год включительно.
-- Исключи страны, где минимальное число таких компаний равно нулю.
-- Выгрузи десять стран, отсортировав по среднему количеству компаний
-- по убыванию, затем по коду страны в лексикографическом порядке.
SELECT country_code,
       MIN(invested_companies),
       MAX(invested_companies),
       AVG(invested_companies)
FROM fund
WHERE founded_at BETWEEN '2010-01-01' AND '2012-12-31'
GROUP BY country_code
HAVING MIN(invested_companies) > 0
ORDER BY AVG(invested_companies) DESC,
         country_code
LIMIT 10;
