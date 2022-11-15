create:
	docker build -t datalagring ./
start:
	docker run -d --name imdb -p 5432:5432 datalagring
copy:
	docker cp imdb_dump.sql imdb:/imdb_dump.sql
terminal:
	docker exec -it imdb /bin/sh
