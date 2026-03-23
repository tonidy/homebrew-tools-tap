.PHONY: audit

audit:
	brew audit --strict --online Formula/*.rb
