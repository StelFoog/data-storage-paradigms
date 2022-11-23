start:
	docker compose up
start-bg:
	docker compose up --detach
migrate:
	cat ./migrate.sql | docker exec -i soundgood-db psql -U postgres -d soundgood-db
seed:
	cat ./seed.sql | docker exec -i soundgood-db psql -U postgres -d soundgood-db
reset:
	cat ./dbReset.sql | docker exec -i soundgood-db psql -U postgres
terminal:
	docker exec -it soundgood-db /bin/sh
