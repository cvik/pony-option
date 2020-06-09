BIN = option
TEST_BIN = test
TEST_DIR = .test
PC = ponyc
REGISTRY ?= quay.io/cvik/mqttd
IMAGE = $(REGISTRY)/$(BIN)
VERSION = v0.1.0

all:
	@$(PC) -s -b $(BIN)
	@upx $(BIN)
	@sstrip $(BIN)

test:
	@$(PC) -o $(TEST_DIR) -b $(TEST_BIN) option
	@$(TEST_DIR)/$(TEST_BIN)
	@rm -rf $(TEST_DIR)

run: all
	@./$(BIN)

docs:
	@$(PC) --docs

clean:
	@rm -vf *.o
	@rm -rf option-docs
	@rm -vrf $(TEST_DIR)
	@rm -vf $(BIN)
