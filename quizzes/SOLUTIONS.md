# Solutions

**NOTE:** These are the solutions I came up with, they are documented here to so that I can remember I did. Feel free to look at them for inspiration (unless prevented by the rules of the course).

## Number of shows with more than 50 but less than 100 episodes

```sql
SELECT COUNT(*) AS total_filtered_shows
FROM (
	SELECT show_title_id
	FROM episodes
	GROUP BY show_title_id
	HAVING COUNT(episode_title_id)>=50 AND COUNT(episode_title_id)<100
) AS filtered_shows
;
```

## Lowest rated Action,Comedy original title

```sql
SELECT titles.original_title, ratings.rating
FROM titles
INNER JOIN ratings
	ON ratings.title_id=titles.title_id
WHERE titles.genres='Action,Comedy'
ORDER BY rating ASC
LIMIT 10
;
```

## `title_id` of lowest rated movie (`rating=1`) with most votes

```sql
SELECT title_id, votes
FROM ratings
WHERE rating=1
ORDER BY votes DESC
LIMIT 10
;
```

## Average rating for shows with more than 500.000 votes

```sql
SELECT AVG(rating) AS average
FROM ratings
WHERE votes>=500000
;
```
