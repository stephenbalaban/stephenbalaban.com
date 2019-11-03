#!/bin/bash
# Generates index.md

CONTENT_DIR=stephenbalaban.com
INDEX_PATH=${CONTENT_DIR}/index.md

cat > ${INDEX_PATH} <<EOF
---
title: Stephen Balaban's blog
---

$(for file in `find ${CONTENT_DIR}/*/ | grep md$`;
do
	title=$(cat $file|grep title: | awk -F': ' '{ print $2 }' | sed 's/\"//g');
	date=$(cat $file|grep date: | awk -F': ' '{ print $2 }' | sed 's/"//g');
	path=http:\/\/$(echo $file | sed 's/index\.md//');
	echo "* $date [$title]($path)";
done | sort -nrk 2)

Last Updated: $(date). Created using Make & bash, <a href="ht">source available here</a>.
EOF
