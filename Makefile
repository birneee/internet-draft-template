DRAFT_MD = $(wildcard draft-*.md)
DRAFT_TXT := $(patsubst %.md,out/%.txt,$(DRAFT_MD))
DRAFT_HTML := $(patsubst %.md,out/%.html,$(DRAFT_MD))
DRAFT_PDF := $(patsubst %.md,out/%.pdf,$(DRAFT_MD))

all: $(DRAFT_TXT) $(DRAFT_HTML) $(DRAFT_PDF)

out/%.txt: out/%.xml
	xml2rfc --text $<

out/%.html: out/%.xml
	xml2rfc --html $<

out/%.pdf: out/%.xml
	xml2rfc --pdf $<

.PRECIOUS: out/%.xml
out/%.xml: %.md
	mkdir -p $(dir $@)
	kramdown-rfc $< > $@
