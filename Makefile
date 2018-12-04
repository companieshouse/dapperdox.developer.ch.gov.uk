CHS_ENV_HOME  ?= $(HOME)/.chs_env
TESTS         ?= ./...

target        := dapperdox
bin           := dapperdox/$(target)
dapperdox_assets := dapperdox/assets
assets        := assets
themes        := themes
specs         := specs
test_path     := ./test
chs_envs      := $(CHS_ENV_HOME)/global_env $(CHS_ENV_HOME)/developer.ch.gov.uk/env
test_unit_env := PROXY_TARGET_URLS=http:// DEVELOPER_HUB_URL=123 BIND_ADDRESS=4005
source_env    := for chs_env in $(chs_envs); do test -f $$chs_env && . $$chs_env; done
xunit_output  := test.xml
lint_output   := lint.txt

commit        := $(shell git rev-parse --short HEAD)
tag           := $(shell git tag -l 'v*-rc*' --points-at HEAD)
version       := $(shell if [[ -n "$(tag)" ]]; then echo $(tag) | sed 's/^v//'; else echo $(commit); fi)

.PHONY: all
all: build

.PHONY: fmt
fmt:
	go fmt ./...

.PHONY: deps
deps:

.PHONY: build
build: deps fmt $(bin)

$(bin):
	@$(MAKE) -C dapperdox 

.PHONY: test-deps
test-deps: deps
	go get github.com/smartystreets/goconvey
	go get github.com/smartystreets/assertions
	go get github.com/stvp/tempredis
	go get github.com/rafaeljusto/redigomock

.PHONY: test
#test: test-unit test-integration # FIXME integration tests currently failing
test: test-unit

.PHONY: test-unit
test-unit: test-deps
	@set -a; $(test_unit_env); go test $(TESTS) -run 'Unit'

.PHONY: test-integration
test-integration: test-deps
	$(source_env); go test $(TESTS) -run 'Integration'

.PHONY: convey
convey: clean build
	$(source_env); goconvey

.PHONY: clean
clean:
	rm -f ./$(bin) ./$(target)-*.zip $(test_path) build.log

.PHONY: package
package: deps
	$(eval tmpdir:=$(shell mktemp -d build-XXXXXXXXXX))
	mkdir $(tmpdir)/dapperdox
	cp -r $(bin) $(tmpdir)/dapperdox/
	cp -r $(dapperdox_assets) $(tmpdir)/dapperdox/
	cp -r $(specs) $(tmpdir)/
	cp -r $(themes) $(tmpdir)/
	cp -r $(assets) $(tmpdir)/
	cp ./start.sh $(tmpdir)/start.sh
	cd $(tmpdir) && zip -r ../$(target)-$(version).zip *
	rm -rf $(tmpdir)

.PHONY: dist
dist: clean build package

.PHONY: xunit-tests
xunit-tests: test-deps
	go get github.com/tebeka/go2xunit
	@set -a; $(test_unit_env); go test -v $(TESTS) -run 'Unit' | go2xunit -output $(xunit_output)

.PHONY: lint
lint:
	go get -u github.com/alecthomas/gometalinter
	gometalinter --install
	gometalinter ./... > $(lint_output); true
