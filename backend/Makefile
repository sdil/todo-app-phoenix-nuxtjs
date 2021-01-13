start-db:
	docker run --rm -it -e POSTGRES_PASSWORD=postgres -p 5432:5432 postgres:12.0-alpine

new-todo:
	curl -i localhost:4000/api/todos -d '{"todo":{"title": "test", "done": false}}' -X POST -H "Content-type: application/json"