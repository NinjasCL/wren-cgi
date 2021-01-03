.PHONY: premake make-bsd make-make make-macos help repl version include scratch scratch-touch test

# This is just a test file for quick testing
st scratch-touch:
	touch scratch.wren

s scratch:
	bin/wren_cli scratch.wren

# Execute tests in test directory
t test:
	python3 util/test.py

# Execute build all when adding a new module
a all:
	make include
	make premake

p premake:
# Install premake in your PATH (normally /usr/local/bin)
# https://premake.github.io/download.html#v5
# Min version premake5 alpha 13
# https://github.com/premake/premake-core/releases/tag/v5.0.0-alpha13
# Add any dependency in projects/premake/premake5.lua
	python3 util/generate_projects.py

i inc include:
# Creates all wren.inc files
	find ./src -name "*.wren" | xargs -I{} util/wren_to_c_string.py {}.inc {}

# Shortcuts to building projects
mb bsd:
	cd projects/make.bsd && make

mk make:
	cd projects/make && make

mm macos:
	cd projects/make.mac && make

# Simple testing commands
h help:
	bin/wren_cli --help

r repl:
	bin/wren_cli

v version:
	bin/wren_cli --version
