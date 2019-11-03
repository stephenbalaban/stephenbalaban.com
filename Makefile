TEMPLATE := template.html
CONTENT_DIR := stephenbalaban.com
OUTPUT_DIR := output/

MARKDOWN_FILES := $(wildcard $(CONTENT_DIR)/*/*.md) $(wildcard $(CONTENT_DIR)/*.md)

DOCS = $(MARKDOWN_FILES:.md=.html)

.PHONY : maketoc

toc :
	./generate_index.sh

all : toc $(DOCS)

%.html : %.md
	mkdir -p output/$(shell dirname $<)
	pandoc --template=$(TEMPLATE) -s -o output/$(@) $<

clean:
	rm -rf output

upload:
	./upload.sh
