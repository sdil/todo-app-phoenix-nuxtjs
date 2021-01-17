start-db:
	docker run --rm -it -e POSTGRES_PASSWORD=postgres -p 5432:5432 postgres:12.0-alpine

start-dev:
	mix ecto.create
	mix ecto.migrate
	mix phx.server

start-prod:
	docker-compose down
	docker-compose up -d
	docker-compose exec web mix ecto.create
	docker-compose exec web mix ecto.migrate

new-todo:
	curl -i localhost:4000/api/todos -d '{"todo":{"title": "test", "done": false}}' -X POST -H "Content-type: application/json"