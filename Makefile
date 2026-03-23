.PHONY: audit

audit:
	brew audit --strict --online --tap tonidy/tools-tap gen-secp mkpasswd pa
