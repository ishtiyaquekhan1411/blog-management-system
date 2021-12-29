.PHONY: test
rubocop:
	docker-compose run web bundle exec rubocop
up:
	docker-compose up
down:
	docker-compose down
test:
	docker-compose run web rake test