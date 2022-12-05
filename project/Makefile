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
yearly-totals:
	node scripts/getYearlyTotals.js $(year) | docker exec -i soundgood-db psql -U postgres -d soundgood-db
student-siblings:
	node scripts/getStudentsWithSiblings.js $(siblings) | docker exec -i soundgood-db psql -U postgres -d soundgood-db
instructor-lessons:
	node scripts/getInstructorLessons.js $(year)-$(month) | docker exec -i soundgood-db psql -U postgres -d soundgood-db
weekly-ensembles:
	node scripts/getWeeklyEnsembles.js $(year)-$(week) | docker exec -i soundgood-db psql -U postgres -d soundgood-db
