SELECT 
	user_id,
	device_type_canonical,
	order_id,
	created_dt_msk AS order_dt,
	created_ts_msk AS order_ts,
	currency_code,
	tickets_count,
	revenue,
	date(created_dt_msk) - date(LAG(created_dt_msk) OVER (PARTITION BY user_id ORDER BY created_dt_msk)) AS days_since_prev,
	event_id,
	event_name_code AS event_name,
	event_type_main,
	service_name,
	region_name,
	city_name
FROM
	afisha.purchases
LEFT JOIN afisha.events
		USING (event_id)
LEFT JOIN afisha.city
		USING (city_id)
LEFT JOIN afisha.regions
		USING (region_id)
WHERE
	(device_type_canonical = 'mobile'
		OR device_type_canonical = 'desktop')
	AND event_type_main != 'фильм'
ORDER BY
	user_id;

