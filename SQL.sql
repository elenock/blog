CREATE TABLE new_table AS
  SELECT id, group_id, last_value(row2) OVER(PARTITION BY row) AS count
  FROM(
    SELECT id, group_id, row, row_number() OVER(PARTITION BY row ORDER BY id asc ) AS row2
      FROM(
        SELECT id, group_id, id-row_number() OVER(PARTITION BY group_id ORDER BY id asc ) AS row
          FROM users ORDER BY id
      ) as table1
    ORDER BY id
  ) as table2 ORDER BY id;

SELECT DISTINCT min_id, group_id, count
FROM(
  SELECT group_id, count, MIN(id) OVER(PARTITION BY group_id, count ORDER BY id asc ) AS min_id
  FROM new_table
) as table3 ORDER BY min_id;
