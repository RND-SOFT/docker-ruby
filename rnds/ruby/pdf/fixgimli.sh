#!/bin/sh

rm `which wkhtmltopdf | grep bundle | head -n 1` &> /dev/null
rm `which wkhtmltopdf | grep gems | head -n 1` &> /dev/null

gimli=$(gem which gimli | sed 's/lib\/gimli.rb/lib\/gimli\/wkhtmltopdf.rb/')
echo patching gimli at $gimli
sed -i "/[bin, @parameters, '-q', '-', \"\\\"#{filename}\\\"\"].compact/c[bin, \'-q\', @parameters, \'-\', \"'#{filename}'\"].compact" $gimli
 