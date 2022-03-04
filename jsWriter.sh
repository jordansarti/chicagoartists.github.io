#!/bin/bash

sed -i '' '1i\
var artTermsTable = ' cafoutput/artTerms.json
echo >> cafoutput/artTerms.json
sed -i '' '1i\
var caaJson = '  cafoutput/caaJson.json
echo >> cafoutput/caaJson.json
sed -i '' '1i\
var culturesWithIds = ' cafoutput/cultures.json
cat cafoutput/* >> caa-db.js