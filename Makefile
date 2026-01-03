APP_NAME=wekicode-platform
PORT=8080

build:
	docker build -t $(APP_NAME) .

run:
	docker run --rm -d --name $(APP_NAME) -p $(PORT):80 $(APP_NAME)

stop:
	docker rm -f $(APP_NAME) || true

logs:
	docker logs -f $(APP_NAME)

compose-up:
	docker compose up -d --build

compose-down:
	docker compose down

health:
	curl -fsS http://localhost:$(PORT)/health
