TEMPLATE := template.html
CONTENT_DIR := stephenbalaban.com
OUTPUT_DIR := output/

MARKDOWN_FILES := $(wildcard $(CONTENT_DIR)/*/*.md) $(wildcard $(CONTENT_DIR)/*.md)

DOCS = $(MARKDOWN_FILES:.md=.html)

.DEFAULT_GOAL := all
.PHONY : maketoc
.PHONY: images

toc :
	./generate_index.sh

all : toc $(DOCS) images

%.html : %.md
	mkdir -p output/$(shell dirname $<)
	pandoc --template=$(TEMPLATE) -s -o $(OUTPUT_DIR)/$(@) $<

images:
	    rsync --relative -a $(CONTENT_DIR)/*/images $(OUTPUT_DIR)

clean:
	rm -rf output

upload:
	aws s3 sync $(OUTPUT_DIR)/$(CONTENT_DIR) s3://stephenbalaban.com
