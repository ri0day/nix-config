#
#  NOTE: Makefile's target name should not be the same as one of the file or directory in the current directory,
#    otherwise the target will not be executed!
#


############################################################################
#
#  Darwin related commands
#
############################################################################

#  TODO Feel free to remove this target if you don't need a proxy to speed up the build process

proxy = "http://127.0.0.1:7890"
useproxy:
	sudo python3 scripts/darwin_set_proxy.py $(proxy)

# Darwin hosts
darwin-m1max:
	darwin-rebuild switch --flake .#m1max

darwin-work-mac:
	darwin-rebuild switch --flake .#work-mac

darwin-debug:
	darwin-rebuild switch --flake .#m1max --show-trace --verbose

############################################################################
#
#  NixOS related commands
#
############################################################################

nixos-nix-server:
	sudo nixos-rebuild switch --flake .#nix-server

nixos-debug:
	sudo nixos-rebuild switch --flake .#nix-server --show-trace --verbose

############################################################################
#
#  Home Manager standalone commands (for non-NixOS Linux)
#
############################################################################

home-ubuntu-server:
	home-manager switch --flake .#ubuntu-server

home-debug:
	home-manager switch --flake .#ubuntu-server --show-trace --verbose

############################################################################
#
#  Deploy-rs commands (remote deployment)
#
############################################################################

deploy-m1max:
	nix run .#deploy-rs -- .#m1max

deploy-nix-server:
	nix run .#deploy-rs -- .#nix-server

deploy-ubuntu-server:
	nix run .#deploy-rs -- .#ubuntu-server

deploy-all:
	nix run .#deploy-rs -- .

############################################################################
#
#  nix related commands
#
############################################################################

update:
	nix flake update

update-input:
	nix flake lock --update-input $(input)

history:
	nix profile history --profile /nix/var/nix/profiles/system

gc:
	# remove all generations older than 7 days
	sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 7d

	# garbage collect all unused nix store entries
	sudo nix store gc --debug

fmt:
	# format the nix files in this repo
	nix fmt

check:
	nix flake check

.PHONY: clean
clean:
	rm -rf result
