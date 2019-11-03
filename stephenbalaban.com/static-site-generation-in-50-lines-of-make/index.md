---
title: "Static site generation in 50 lines of code"
date: 2019-11-03
---

After a long time of being stuck on Wordpress, I've finally switched over to
a simple statically generated site hosted on S3. The Makefile itself is 50
lines of code, if you want to include the template, it's 138. It dynamically
generates an index page which acts as a table of contents for the entire blog.

The dependencies are pandoc, make, and awscli. Build and deployment to S3 is as
easy as:

```
make
make upload
```

The entire source of our table of contents generation:

```
#!/bin/bash
# Generates index.md

CONTENT_DIR=${1}
INDEX_PATH=${CONTENT_DIR}/index.md

cat > ${INDEX_PATH} <<EOF
---
title: ${2}
---

$(for file in `find ${CONTENT_DIR}/*/ | grep md$`;
do
	title=$(cat $file|grep title: | awk -F': ' '{ print $2 }' | sed 's/\"//g');
	date=$(cat $file|grep date: | awk -F': ' '{ print $2 }' | sed 's/"//g');
	path=http:\/\/$(echo $file | sed 's/index\.md//');
	echo "* $date [$title]($path)";
done | sort -nrk 2)

Last Updated: $(date). Created using Make & bash, <a href="https://github.com/stephenbalaban/stephenbalaban.com">source available here</a>.
EOF
```

The entire source of the html from markdown generation, media copying
functionality, and S3 deployment:

```
TEMPLATE := template.html
CONTENT_DIR := stephenbalaban.com
SITE_TITLE := Stephen Balaban\'s blog
OUTPUT_DIR := output/

MARKDOWN_FILES := $(wildcard $(CONTENT_DIR)/*/*.md) $(wildcard $(CONTENT_DIR)/*.md)
DOCS = $(MARKDOWN_FILES:.md=.html)

.DEFAULT_GOAL := all
.PHONY : maketoc
.PHONY : images

toc :
	./generate_index.sh $(CONTENT_DIR) "$(SITE_TITLE)"

all : toc $(DOCS) images

%.html : %.md
	mkdir -p output/$(shell dirname $<)
	pandoc --template=$(TEMPLATE) -s -o $(OUTPUT_DIR)/$(@) $<

images:
	rsync --relative -a $(CONTENT_DIR)/*/images $(OUTPUT_DIR)

clean:
	rm -rf output

upload:
	aws s3 sync $(OUTPUT_DIR)/$(CONTENT_DIR) s3://$(CONTENT_DIR)
```

Feel free to use it yourself, the [source is available here](https://github.com/stephenbalaban/stephenbalaban.com).
