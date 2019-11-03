#!/bin/bash
CONTENT_DIR=${1}
INDEX_PATH=${CONTENT_DIR}/index.md

cat > ${INDEX_PATH} <<EOF
---
title: ${2}
---

$(for file in `find ${CONTENT_DIR}/*/ | grep md$`;
do
	title=$(cat $file | grep title: | head -n 1 | awk -F'title: ' '{ print $2 }' | sed 's/\"//g');
	date=$(cat $file | grep date: | head -n 1 | awk -F'date: ' '{ print $2 }' | sed 's/"//g');
	path=http:\/\/$(echo $file | sed 's/index\.md//');
	echo "* $date [$title]($path)";
done | sort -nrk 2)

Created using Make & bash, <a href="https://github.com/stephenbalaban/stephenbalaban.com">source available here</a>.

Last Updated: $(date).
EOF
