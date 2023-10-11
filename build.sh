#!/bin/bash

## Configuration.
host=https://help.prestashop.com
distDir=dist

## Store all langs, controllers and versions in arrays.
langs=$(cat "config/langs")
controllers=$(cat "config/controllers")
versions=$(cat "config/versions")
len_langs=`echo ${langs[@]} | wc -w`
len_controllers=`echo ${controllers[@]} | wc -w`
len_versionss=`echo ${versions[@]} | wc -w`

## Create dist folder, and retrieve css styles.
echo "-- Init documentation folder"
mkdir -p ${distDir}/css
wget ${host}/css/doc.css -O ${distDir}/css/doc.css >> /dev/null 2>&1

## For each langs, versions and controllers, retrieve the documentation.
doneFiles=0
neededFiles=$(((${len_langs} * ${len_controllers} * ${len_versionss}) + (${len_langs} * ${len_versionss})))

echo "-- Download documentation"
for l in ${langs[@]}; do

  for v in ${versions[@]}; do
    path=${distDir}/doc/${l}/${v}
    mkdir -p ${path}
    doneFiles=$((${doneFiles} + 1))
    fallback="${path}/__fallback.html"
    wget ${host}/${l}/doc/__fallback?version=${v} -O ${fallback} >> /dev/null 2>&1
    sed -i '' 's/<script.*<\/script>//gi' ${fallback}

    echo "-- [${doneFiles}/${neededFiles}] - ${l} - ${v} - __fallback"

    for c in ${controllers[@]}; do
      doneFiles=$((${doneFiles} + 1))
      filename="${path}/${c}.html"
      wget ${host}/${l}/doc/${c}?version=${v} -O ${filename} >> /dev/null 2>&1
      sed -i '' 's/<script.*<\/script>//gi' ${filename}

      if cmp --silent -- "${filename}" "${fallback}"; then
        rm ${filename}
      fi

      echo "-- [${doneFiles}/${neededFiles}] - ${l} - ${v} - ${c}"
    done

  done

done

echo "-- Documentation downloaded! Well done!"
