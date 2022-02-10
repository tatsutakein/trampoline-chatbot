.PHONY: setup
setup:
	@sh ./scripts/setup.sh

.PHONY: teardown
teardown:
	@docker-compose down
