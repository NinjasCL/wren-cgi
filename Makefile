.PHONY: premake make-bsd make-make make-macos help repl version

p premake:
# Install premake in your PATH (normally /usr/local/bin)
# https://premake.github.io/download.html#v5
# Add any dependency in projects/premake/premake5.lua
	python3 util/generate_projects.py

# Shortcuts to building projects
mb make-bsd:
	cd projects/make.bsd && make

mk make-make:
	cd projects/make && make

mm make-macos:
	cd projects/make.mac && make

# Simple testing commands
h help:
	bin/wren_cli --help

r repl:
	bin/wren_cli

v version:
	bin/wren_cli --version
