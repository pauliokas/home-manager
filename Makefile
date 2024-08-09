.PHONY: apply
apply:
	home-manager switch

.PHONY: update
update:
	nix flake update