reduce [inputs] as $s ([input]; . + $s) |
map(.products[] | 
	{
		id,
		name: "\(.productData.name) \(.productData.brand.name)",
		description: .productData.description,
		category: .categories[0].name,
		url: .productData.url,
		price: .priceData.prices[0].value.centAmount,
		reference_price: .priceData.prices[0].value.centUnitAmount,
		iva: .priceData.taxPercentage,
		reference_unit: .priceData.unitPriceUnitType,
		date: now | strftime("%Y-%m-%d")
	} 
)