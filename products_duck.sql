CREATE TABLE IF NOT EXISTS products(url VARCHAR, category VARCHAR, 
	"name" VARCHAR, description VARCHAR, price DOUBLE, reference_price DOUBLE, 
	reference_unit VARCHAR, date DATE, id VARCHAR, code VARCHAR, ean VARCHAR, iva INTEGER);

insert into products(url, category, name, description, price, reference_price, reference_unit, date, id, code, ean, iva)
select
  json ->> '$.url',
  json ->> '$.category',
  json ->> '$.name',
  json ->> '$.description',
  json ->> '$.price',
  json ->> '$.reference_price',
  json ->> '$.reference_unit',
  json ->> '$.date',
  json ->> '$.id',
  json ->> '$.code',
  json ->> '$.ean',
  json ->> '$.iva'
from read_ndjson_objects('temp.ndjson');