#!/bin/sh

set -e

[ -z "$CI_COMMIT_SHORT_SHA" ] && export CI_COMMIT_SHORT_SHA=unknown
[ -z "$VERSION" ] && export VERSION="1.0(${CI_COMMIT_SHORT_SHA})"
[ -z "$SERVICE" ] && export SERVICE="API-шлюз"
[ -z "$DOC_TITLE"] && export DOC_TITLE="SERVICE"
[ -z "$DOC_SUBTITLE"] && export DOC_SUBTITLE="description"

export YEAR=`date +%Y`
export DATE=`date +%d.%m.%Y`


cat ${COVER_PATH} | envsubst > cover.html
cat ${HEADER_PATH} | envsubst > header.html
cat ${FOOTER_PATH} | envsubst > footer.html

TOC_HEADER=${TOC_HEADER:-Содержание}
BOTTOM_MARGIN=${BOTTOM_MARGIN:-20mm}
TOP_MARGIN=${TOP_MARGIN:-20mm}
LEFT_MARGIN=${LEFT_MARGIN:-15mm}
RIGHT_MARGIN=${RIGHT_MARGIN:-15mm}
export GIMLI_EXTRA_STYLES=${EXTRA_STYLES:-/home/common/style.css}

echo Processing: $@
echo "  VERSION:      ${VERSION}"
echo "  YEAR:         ${YEAR}"
echo "  DATE:         ${DATE}"
echo "  SERVICE:      ${SERVICE}"
echo "  DOC_TITLE:    ${DOC_TITLE}"
echo "  DOC_SUBTITLE: ${DOC_SUBTITLE}"
echo "  EXTRA_STYLES: ${GIMLI_EXTRA_STYLES}"

echo "EXEC: "
echo gimli -w "--disable-smart-shrinking --header-html header.html --footer-html footer.html -T ${TOP_MARGIN} -B ${BOTTOM_MARGIN} -L ${LEFT_MARGIN} -R ${RIGHT_MARGIN} cover cover.html toc --toc-header-text '${TOC_HEADER}' --toc-text-size-shrink 1" $@
exec gimli -w "--disable-smart-shrinking --header-html header.html --footer-html footer.html -T ${TOP_MARGIN} -B ${BOTTOM_MARGIN} -L ${LEFT_MARGIN} -R ${RIGHT_MARGIN} cover cover.html toc --toc-header-text '${TOC_HEADER}' --toc-text-size-shrink 1" $@