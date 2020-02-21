#!/bin/sh

set -e

[ -z "$CI_COMMIT_SHORT_SHA" ] && export CI_COMMIT_SHORT_SHA=unknown
[ -z "$VERSION" ] && export VERSION="1.0(${CI_COMMIT_SHORT_SHA})"
[ -z "$SERVICE" ] && export SERVICE="API-шлюз"

export YEAR=`date +%Y`
export DATE=`date +%d.%m.%Y`


cat cover.html.in | envsubst > cover.html
cat header.html.in | envsubst > header.html
cat footer.html.in | envsubst > footer.html

echo Processing: $@
echo "  VERSION: ${VERSION}"
echo "  YEAR:    ${YEAR}"
echo "  DATE:    ${DATE}"
echo "  SERVICE: ${SERVICE}"

echo "EXEC: "
#echo gimli -w "--header-html header.html --footer-html footer.html -L 15mm -R 15mm cover cover.html" $@
#exec gimli -w "--header-html header.html --footer-html footer.html -L 15mm -R 15mm cover cover.html" $@
echo gimli -w "--header-html header.html --footer-html footer.html -L 15mm -R 15mm cover cover.html toc --toc-header-text 'Оглавление' --toc-text-size-shrink 1 " $@
exec gimli -w "--header-html header.html --footer-html footer.html -L 15mm -R 15mm cover cover.html toc --toc-header-text 'Оглавление' --toc-text-size-shrink 1 " $@