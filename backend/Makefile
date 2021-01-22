start-db:
	docker rm -f phoenix-todo-db || true
	docker run -d -it -e POSTGRES_PASSWORD=postgres -p 5432:5432 --name phoenix-todo-db postgres:12.0-alpine

start-dev: start-db
	sleep 10 && mix ecto.create
	mix ecto.migrate
	mix phx.server

start-prod:
	docker-compose build
	docker-compose down
	docker-compose up -d
	docker-compose exec web mix ecto.create
	docker-compose exec web mix ecto.migrate

new-todo:
	curl -i localhost:4000/api/todos -d '{"todo":{"title": "test", "done": false}}' -X POST -H "Content-type: application/json"

new-user:
	curl -i localhost:4000/api/registration -X POST -d '{"user": {"email":"test@asdsf.com", "password":"test123456789", "confirm_password": "test123456789"}}' -H "Content-type: application/json"

get_token:
	curl -i localhost:4000/api/session -X POST -d '{"user": {"email":"test@asdsf.com", "password":"test123456789"}}' -H "Content-type: application/json"
