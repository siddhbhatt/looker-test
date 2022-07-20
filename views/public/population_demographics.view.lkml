# # The name of this view in Looker is "Population Demographics"
# view: population_demographics {
#   # The sql_table_name parameter indicates the underlying database table
#   # to be used for all fields in this view.
#   sql_table_name: public.population_demographics ;;
#   # No primary key is defined for this view. In order to join this view in an Explore,
#   # define primary_key: yes on a dimension that has no repeated values.

#   # Here's what a typical dimension looks like in LookML.
#   # A dimension is a groupable field that can be used to filter query results.
#   # This dimension will be called "Area Land Meters" in Explore.

#   dimension: area_land_meters {
#     type: number
#     sql: ${TABLE}.area_land_meters ;;
#   }

#   dimension: count_population_demographics {
#     type: number
#     sql: ${TABLE}.count ;;
#   }

#   dimension: country_region {
#     type: string
#     sql: ${TABLE}.country_region ;;
#   }

#   dimension: county {
#     type: string
#     sql: ${TABLE}.county ;;
#   }

#   dimension: fips {
#     type: number
#     sql: ${TABLE}.fips ;;
#   }

#   dimension: population {
#     type: number
#     sql: ${TABLE}.population ;;
#   }

#   dimension: province_state {
#     type: string
#     sql: ${TABLE}.province_state ;;
#   }

#   measure: count {
#     type: count
#     drill_fields: []
#   }
# }

#this data was pulled in from bigquery public datasets and shows populations by geographic regions

view: population_demographics {
  derived_table: {
    distribution_style: all
    datagroup_trigger: covid_data
    sql:
      SELECT a.*, b.area_land_meters
      FROM
      (
         SELECT fips,county,province_state,country_region,population,count FROM public.population_by_county_state_country_core WHERE county <> 'New York City' UNION ALL
         SELECT fips,county,province_state,country_region,population,count FROM public.population_by_county_state_country_core WHERE country_region <> 'US'
          and not (country_region = 'France' and province_state is not null)
          and not (country_region = 'United Kingdom' and province_state is not null)
          and not (country_region = 'Netherlands' and province_state is not null)
          UNION ALL
         SELECT 36125 as fips,'New York City' as county,'New York' as province_state,'US' as country_region,8343000 as population, 1 as count
        ) a
      LEFT JOIN
      (
        SELECT geo_id, area_land_meters FROM public.us_county_area UNION ALL
        SELECT 36125 as geo_id, sum(area_land_meters) as area_land_meters FROM public.us_county_area WHERE cast(geo_id as int4) in (36005, 36081, 36061, 36047, 36085) GROUP BY 1
      )  b
        ON cast(a.fips as varchar) = cast(b.geo_id as varchar)

    ;;
  }

  dimension: pre_pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: case  ${country_region} WHEN 'United Kingdom' then
                (coalesce(${county},'')|| coalesce(${province_state},'')|| 'UK')
                else (coalesce(${county},'')|| coalesce(${province_state},'')|| coalesce(${country_region},'')) end;;
  }

  dimension: count2 {
    hidden: yes
    type: number
    sql: ${TABLE}.count ;;
  }

  dimension: country_region {
    hidden: yes
    type: string
    sql: ${TABLE}.country_region ;;
  }

  dimension: county {
    hidden: yes
    type: string
    sql: ${TABLE}.county ;;
  }

  dimension: fips {
    hidden: yes
    type: number
    sql: ${TABLE}.fips ;;
  }

  dimension: population {
    hidden: yes
    type: number
    sql: ${TABLE}.population ;;
  }

  dimension: area_land_meters {
    hidden: yes
    type: number
    sql: ${TABLE}.area_land_meters ;;
  }

  dimension: province_state {
    hidden: yes
    type: string
    sql: ${TABLE}.province_state ;;
  }

  measure: sum_population {
    label: "Total Population"
    type: sum
    sql: ${population} ;;
    link: {
      label: "Data Source - American Community Survey Data (ACS)"
      url: "https://www2.census.gov/programs-surveys/acs/summary_file/2017/data/?#"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.census.gov"
    }
  }

  measure: sum_area_land_meters {
    label: "Total Land Area"
    type: sum
    sql: ${area_land_meters} ;;
    link: {
      label: "Data Source - American Community Survey Data (ACS)"
      url: "https://www2.census.gov/programs-surveys/acs/summary_file/2017/data/?#"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.census.gov"
    }
    value_format_name: decimal_0
  }

  measure: population_density {
    description: "People per 1000 Sq. Kilometers"
    type: number
    sql: 1000000.0*${sum_population}/coalesce(${sum_area_land_meters},0) ;;
    value_format_name: decimal_1
    link: {
      label: "Data Source - American Community Survey Data (ACS)"
      url: "https://www2.census.gov/programs-surveys/acs/summary_file/2017/data/?#"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.census.gov"
    }
  }

  measure: count_pk {
    hidden: yes
    type: count_distinct
    sql: ${pre_pk} ;;
    drill_fields: []
  }
}
