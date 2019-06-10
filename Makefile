artifact_name := dapperdox.developer.ch.gov.uk
assets        := assets
themes        := themes
specs         := specs

dapperdox_target := dapperdox
dapperdox_bin    := dapperdox/$(dapperdox_target)
dapperdox_assets := dapperdox/assets

.PHONY: all
all: build

.PHONY: submodules
submodules:
	git submodule init
	git submodule update

.PHONY: $(dapperdox_bin)
$(dapperdox_bin):
	@$(MAKE) -C dapperdox

.PHONY: build
build: submodules $(dapperdox_bin)

.PHONY: clean
clean:
	rm -f ./$(dapperdox_bin) ./$(artifact_name)-*.zip $(test_path) build.log

.PHONY: package
package:
ifndef version
	$(error No version given. Aborting)
endif
	$(info Packaging version: $(version))
	$(eval tmpdir:=$(shell mktemp -d build-XXXXXXXXXX))
	mkdir $(tmpdir)/dapperdox
	cp $(dapperdox_bin) $(tmpdir)/dapperdox/
	cp -r $(dapperdox_assets) $(tmpdir)/dapperdox/
	cp -r $(specs) $(tmpdir)/
	cp -r $(themes) $(tmpdir)/
	cp -r $(assets) $(tmpdir)/
	cp ./start.sh $(tmpdir)/start.sh
	cd $(tmpdir) && zip -r ../$(artifact_name)-$(version).zip *
	rm -rf $(tmpdir)

.PHONY: dist
dist: clean build package
