### This view contains the NYT county level data, coming from BQ public datasets

view: nyt_data {
  derived_table: {
    distribution_style: all
    sql: select state_code, confirmed_cases, deaths, date,
           case when county = 'Unknown' then concat(county,' - ',state_name) else county end as county,
            case when county = 'Unknown'then NULL
                --mofifying the FIPS code to match other data
                when county = 'New York City' then 36125
                when county = 'Kansas City' then 29095
                else cast(county_fips_code as int64) end as fips
        from public.us_counties;;
    sql_trigger_value: SELECT COUNT(*) FROM public.us_counties ;;
  }

}
