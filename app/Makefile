.PHONY: clean
clean:
	flutter clean

.PHONY: template
template:
	dart ./tool/bin/generate_templates.dart
.PHONY: setup
setup:
	bash ./tool/bin/setup.bash
# setup env
.PHONY: setup-env
setup-env:
	bash ./tool/bin/setup-env.bash

.PHONY: generate
generate:
	bash ./tool/bin/generate_intl.bash
