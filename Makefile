SHELL := /bin/bash

SCRIPT_PATH := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

TARGETS_DIR = targets
TARGETS = $(SCRIPT_PATH)$(TARGETS_DIR)

viproxy: $(TARGETS)/viproxy
$(TARGETS)/viproxy: main.go
	@echo "Build viproxy..."
	@go build -o $(TARGETS)/viproxy main.go

run-viproxy: viproxy
	IN_ADDRS=:$(APP_PORT),:80,3:$(SOCKS_PORT) OUT_ADDRS=4:$(APP_PORT),4:80,127.0.0.1:$(SOCKS_PORT) $(TARGETS)/viproxy &> $(TARGETS)/viproxy.log

run-viproxy-quiet: viproxy
	IN_ADDRS=:$(APP_PORT),:80,3:$(SOCKS_PORT) OUT_ADDRS=4:$(APP_PORT),4:80,127.0.0.1:$(SOCKS_PORT) $(TARGETS)/viproxy &> $(TARGETS)/viproxy.log &

clean:
	rm -rf $(TARGETS)