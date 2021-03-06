.DEFAULT_GOAL := help

help:
	@echo ""
	@echo "Available tasks:"
	@echo "    watch  Upload changed *.py files to flash automatically"
	@echo "    shell  Start an remote shell session"
	@echo "    sync   Sync contents of firmware folder to flash"
	@echo "    reset  Soft reboot the board"
	@echo "    repl   Start a repl session"
	@echo "    deps   Install dependencies with upip"
	@echo ""

watch:
	find . -name "*.py" | entr -c sh -c 'make sync && make reset'

sync:
	rshell --port /dev/tty.SLAB_USBtoUART --timing --buffer-size=32 rsync --mirror --verbose ./firmware  /flash

shell:
	rshell --port /dev/tty.SLAB_USBtoUART --timing --buffer-size=32

repl:
	screen /dev/tty.SLAB_USBtoUART 115200

reset:
	rshell --port /dev/tty.SLAB_USBtoUART --timing --buffer-size=32 repl "~ import machine ~ machine.reset()~"

deps:
	@echo "Nothing to install..."

.PHONY: help watch sync shell repl reset deps
