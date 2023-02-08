#!/bin/bash -e

data_dir="data"
tmp_dir="tmp"

if [[ ! -d $data_dir ]]
then
    echo "Creating data folder"
    mkdir $data_dir
fi

echo "Creating temporary folder"
mkdir $tmp_dir

counter=0
offset=$((counter * 100))

while true
do
	echo "Downloading offset $offset"
	url="https://tienda.consum.es/api/rest/V1.0/catalog/product?limit=100&offset=$offset"
	resp=$(curl --fail --show-error --silent $url)
	echo $resp > $tmp_dir/products-$offset.json
	hasMore=$(echo $resp | jq '.hasMore')
	if [ "$hasMore" = false ] ; then
		break
	fi
	counter=$((counter+1))
	offset=$((counter * 100))
	sleep 2
done

today=$(date +'%Y-%m-%d')

echo "Processing jsons"
jq -n -f products.jq $tmp_dir/*.json > $data_dir/$today-products.json

echo "Deleting temporary folder"
rm -r $tmp_dir