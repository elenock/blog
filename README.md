# 1. API blog

## Требования к проекту:

У нас имеется некий блог со следующими сущностями:
1. Юзер. Имеет только логин.
2. Пост, принадлежит юзеру. Имеет заголовок, содержание, айпи автора (сохраняется отдельно для каждого поста).
3. Оценка, принадлежит посту. Принимает значение от 1 до 5.

Задача: создать JSON API на RoR со следующими экшенами:
1. Создать пост. Принимает заголовок и содержание поста (не могут быть пустыми), а также логин и айпи автора. Если автора с таким логином еще нет, необходимо его создать. Возвращает либо атрибуты поста со статусом 200, либо ошибки валидации со статусом 422.
2. Поставить оценку посту. Принимает айди поста и значение, возвращает новый средний рейтинг поста. Важно: экшен должен корректно отрабатывать при любом количестве конкурентных запросов на оценку одного и того же поста.
3. Получить топ N постов по среднему рейтингу. Просто массив объектов с заголовками и содержанием.
4. Получить список айпи, с которых постило несколько разных авторов. Массив объектов с полями: айпи и массив логинов авторов.

Базу данных используем PostgreSQL. Для девелопмента написать скрипт в db/seeds.rb, который генерирует тестовые данные. Часть постов должна получить оценки. Скрипт должен использовать тот же код, что и контроллеры, можно вообще дергать непосредственно сервер курлом или еще чем-нибудь.
Постов в базе должно быть хотя бы 200к, авторов лучше сделать в районе 100 штук, айпишников использовать штук 50 разных. Экшены должны на стандартном железе работать достаточно быстро как для указанного объема данных (быстрее 100 мс), так и для намного большего, то есть нужен хороший запас в плане оптимизации запросов. Для этого можно использовать денормализацию данных и любые другие средства БД. Можно использовать любые нужные гемы, обязательно наличие спеков, хорошо покрывающих разные кейсы. В коде желательно не использовать рельсовых антипаттернов типа колбеков и валидаций в моделях, сервис-классы наше все. Также желательно не использовать генераторов и вообще обойтись без лишних мусорных файлов в репозитории.

## Подготовка:

Ruby version 2.6.3,
Rails version 5.2.3,
PostgresSQL 11.4

```bash
  git clone https://github.com/elenock/blog
  cd PATH_TO_CLONED_BLOG_FOLDER/ruby_task
  bundle install
  rails db:create
  rails db:migrate
  rails db:seed
  rails s
```

Приложение доступно по URL: `http://localhost:3000`

### Для прогонки тестов:

```bash
rspec spec
```

## API

### 1.1. Создать пост (status 200)

```bash
  curl -X POST \
    http://localhost:3000/api/post/create \
    -H 'Content-Type: application/json' \
    -H 'Host: localhost:3000' \
    -d '{
      "title":"title_1",
      "body":"body_1",
      "login":"login_1",
      "ip":"192.168.0.1"
    }'
```

Результат запроса:

```json
  {
    "id":"id",
    "title":"title",
    "body":"body",
    "ip":"ip",
    "created_at":"created_at",
    "updated_at":"updated_at",
    "avg_score":"avg_score",
    "score_count":"score_count"
  }
```

### 1.2. Создать пост (status 422)

```bash
  curl -X POST \
    http://localhost:3000/api/post/create \
    -H 'Content-Type: application/json' \
    -H 'Host: localhost:3000' \
    -d '{
      "title":"title_1",
      "body":"body_1",
      "login":"",
      "ip":"192.168.0.1"
    }'
```

Результат запроса:

```json
  {"errors":"post invalid"}
```

### 2.1. Поставить оценку посту (status 200)

```bash
  curl -X POST \
    http://localhost:3000/api/score/create \
    -H 'Content-Type: application/json' \
    -H 'Host: localhost:3000' \
    -d '{
      "post_id":"1",
      "level":"3"
    }'
```

Результат запроса:

```json
  {"avg_score":"avg_score"}
```

### 2.2. Поставить оценку посту (status 422)

```bash
  curl -X POST \
    http://localhost:3000/api/score/create \
    -H 'Content-Type: application/json' \
    -H 'Host: localhost:3000' \
    -d '{
      "post_id":"3000000",
      "level":"3"
    }'
```

Результат запроса:

```json
  {"errors":"post_does_not_exist"}
```

### 3. Получить топ N постов по среднему рейтингу

```bash
  curl -X GET \
    http://localhost:3000/api/post/top \
    -H 'Content-Type: application/json' \
    -H 'Host: localhost:3000' \
    -d '{
      "top":"100"
    }'
```

Результат запроса:

```json
  [{"title":"title", "body":"body"}]
```

### 4. Получить список айпи, с которых постило несколько разных авторов

```bash
  curl -X GET \
    http://localhost:3000/api/post/ip \
    -H 'Content-Type: application/json' \
    -H 'Host: localhost:3000' \
```

Результат запроса:

```json
  [{"ip":"ip", "users":["user"]}]
```

## 2. Задание по SQL


Дана таблица users вида - id, group_id:
```sql
create temp table users(id bigserial, group_id bigint);
insert into users(group_id) values (1), (1), (1), (2), (1), (3);
```

1. В этой таблице, упорядоченной по ID необходимо:
2. Выделить непрерывные группы по group_id с учетом указанного порядка записей (их 4).
3. Подсчитать количество записей в каждой группе
4. Вычислить минимальный ID записи в группе

Для таблицы:

```sql
id | group_id
---+---------
 1 | 1
 2 | 1
 3 | 1
 4 | 2
 5 | 1
 6 | 3
```


Непрерывными группами можно считать

```sql
group_id
---------
    1
    2
    1
    3
```

Запрос должен выводить:

```sql
min_id | group_id | count
-------+----------+-------
     1 |        1 |     3
     4 |        2 |     1
     5 |        1 |     1
     6 |        3 |     1
```

## Рeализация:

```sql
SELECT DISTINCT min_id, group_id, count
FROM(
  SELECT group_id, count, MIN(id) OVER(PARTITION BY group_id, count ORDER BY id asc ) AS min_id
  FROM(
    SELECT id, group_id, last_value(row2) OVER(PARTITION BY row) AS count
    FROM(
      SELECT id, group_id, row, row_number() OVER(PARTITION BY row ORDER BY id asc ) AS row2
      FROM(
      SELECT id, group_id, id-row_number() OVER(PARTITION BY group_id ORDER BY id asc ) AS row
      FROM users ORDER BY id
      ) as table1 ORDER BY id
    ) as table2 ORDER BY id
  ) as table3
) as table4 ORDER BY min_id;
```
Результат запроса:

```sql
min_id | group_id | count
-------+----------+-------
     1 |        1 |     3
     4 |        2 |     1
     5 |        1 |     1
     6 |        3 |     1
```