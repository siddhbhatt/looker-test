
view: hospital_bed_summary {
  derived_table: {
        datagroup_trigger: covid_data
    #combining NYC fips codes to match other data
    sql:  SELECT x, y, objectid, hospital_name, hospital_type, hq_address, hq_address1, hq_city, hq_state, hq_zip_code, county_name, state_name, state_fips, cnty_fips, num_licensed_beds, num_staffed_beds, num_icu_beds, bed_utilization,
            case when cast(fips as integer) in ( 36005, 36081, 36061, 36047, 36085 ) then 36125 else cast(fips as integer) end as fips
            FROM public.hospital_bed_summary
            WHERE hospital_type not in ('Rehabilitation Hospital', 'Psychiatric Hospital', 'Religious Non-Medical Health Care Institution') ;;
    distribution_style: all
  }


####################
#### Original Dimensions ####
####################

  dimension: objectid {
    primary_key: yes
    hidden: yes
    type: number
    value_format_name: id
    sql: ${TABLE}.OBJECTID ;;
  }

  dimension: bed_utilization {
    hidden: yes
    type: number
    sql: ${TABLE}.BED_UTILIZATION ;;
  }

  dimension: cnty_fips {
    hidden: yes
    type: number
    sql: ${TABLE}.CNTY_FIPS ;;
  }

  dimension: county_name {
    hidden: yes
    type: string
    sql: ${TABLE}.COUNTY_NAME ;;
  }

  dimension: fips {
    hidden: yes
    type: number
    sql: right('00000' || COALESCE(cast(${TABLE}.fips AS varchar), ''),5) ;;
  }

  dimension: hospital_name {
    group_label: "Hospital (US Only)"
    type: string
    sql: ${TABLE}.hospital_name ;;
  }

  dimension: hospital_type {
    group_label: "Hospital (US Only)"
    type: string
    sql: ${TABLE}.hospital_type ;;
  }

  dimension: hq_address {
    group_label: "Hospital (US Only)"
    label: "Hospital Address"
    type: string
    sql: ${TABLE}.hq_address ;;
  }

  dimension: hq_address1 {
    hidden: yes
    type: string
    sql: ${TABLE}.hq_address1 ;;
  }

  dimension: hq_city {
    group_label: "Hospital (US Only)"
    label: "Hospital City"
    type: string
    sql: ${TABLE}.hq_city ;;
  }

  dimension: hq_state {
    hidden: yes
    type: string
    sql: ${TABLE}.hq_state ;;
  }

  dimension: hq_zip_code {
    group_label: "Hospital (US Only)"
    label: "Hospital Zip Code"
    value_format_name: id
    type: number
    sql: ${TABLE}.hq_zip_code ;;
  }

  dimension: lat {
    hidden: yes
    type: number
    sql: ${TABLE}.y ;;
  }

  dimension: long {
    hidden: yes
    type: number
    sql: ${TABLE}.x ;;
  }

  dimension: hospital_location {
    group_label: "Hospital (US Only)"
    type: location
    sql_latitude: ${lat} ;;
    sql_longitude: ${long} ;;
  }

  dimension: state_fips {
    hidden: yes
    type: number
    sql: ${TABLE}.state_fips ;;
  }

  dimension: state_name {
    hidden: yes
    type: string
    sql: ${TABLE}.STATE_NAME ;;
  }

  dimension: num_icu_beds {
    hidden: yes
    type: number
    sql: ${TABLE}.num_icu_beds ;;
  }

  dimension: num_licensed_beds {
    hidden: yes
    type: number
    sql: ${TABLE}.num_licensed_beds ;;
  }

  dimension: num_staffed_beds {
    hidden: yes
    type: number
    sql: ${TABLE}.num_staffed_beds ;;
  }

  dimension: potential_increase_in_bed_capac {
    hidden: yes
    type: number
    sql: ${TABLE}.potential_increase_in_bed_capac ;;
  }

  dimension: county_num_icu_beds {
    hidden: yes
    type: number
    sql: select sum(num_icu_beds) from public.hospital_bed_summary where fips = ${fips};;
  }

  dimension: county_num_licensed_beds {
    hidden: yes
    type: number
    sql: select sum(num_licensed_beds) from public.hospital_bed_summary where fips = ${fips} ;;
  }

  dimension: county_num_staffed_beds {
    hidden: yes
    type: number
    sql: select sum(num_staffed_beds) from public.hospital_bed_summary where fips = ${fips} ;;
  }

#   dimension: estimated_percent_of_covid_cases_of_county_dim {
#     hidden: yes
#     type: number
#     sql: 1.0*${num_licensed_beds}/nullif(${county_num_licensed_beds},0) ;;
#   }

####################
#### Derived Dimensions ####
####################

  dimension: num_icu_beds_available {
    hidden: yes
    type: number
    sql: ${num_icu_beds} * ${bed_utilization} ;;
  }

  dimension: num_staffed_beds_available {
    hidden: yes
    type: number
    sql: ${num_staffed_beds} * ${bed_utilization} ;;
  }

####################
#### Measures ####
####################

  measure: sum_num_icu_beds {
    group_label: " Hospital Capacity (US Only)"
    label: "Count ICU Beds"
    type: sum
    sql: ${num_icu_beds} ;;
    link: {
      label: "Data Source - ESRI Hospital Beds"
      url: "https://coronavirus-resources.esri.com/datasets/definitivehc::definitive-healthcare-usa-hospital-beds?geometry=38.847%2C-16.820%2C-63.809%2C72.123"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.esri.com"
    }
  }

  measure: sum_num_licensed_beds {
    group_label: " Hospital Capacity (US Only)"
    label: "Count Licensed Beds"
    type: sum
    sql: ${num_licensed_beds} ;;
    link: {
      label: "Data Source - ESRI Hospital Beds"
      url: "https://coronavirus-resources.esri.com/datasets/definitivehc::definitive-healthcare-usa-hospital-beds?geometry=38.847%2C-16.820%2C-63.809%2C72.123"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.esri.com"
    }
  }

  measure: sum_num_staffed_beds {
    group_label: " Hospital Capacity (US Only)"
    label: "Count Staffed Beds"
    type: sum
    sql: ${num_staffed_beds} ;;
    link: {
      label: "Data Source - ESRI Hospital Beds"
      url: "https://coronavirus-resources.esri.com/datasets/definitivehc::definitive-healthcare-usa-hospital-beds?geometry=38.847%2C-16.820%2C-63.809%2C72.123"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.esri.com"
    }
  }

  measure: sum_num_icu_beds_available {
    group_label: " Hospital Capacity (US Only)"
    label: "Count ICU Beds Typically Available"
    type: sum
    sql: ${num_icu_beds_available} ;;
    value_format_name: decimal_0
    link: {
      label: "Data Source - ESRI Hospital Beds"
      url: "https://coronavirus-resources.esri.com/datasets/definitivehc::definitive-healthcare-usa-hospital-beds?geometry=38.847%2C-16.820%2C-63.809%2C72.123"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.esri.com"
    }
  }

  measure: sum_num_staffed_beds_available {
    group_label: " Hospital Capacity (US Only)"
    label: "Count Staffed Beds Typically Available"
    type: sum
    sql: ${num_staffed_beds_available} ;;
    value_format_name: decimal_0
    link: {
      label: "Data Source - ESRI Hospital Beds"
      url: "https://coronavirus-resources.esri.com/datasets/definitivehc::definitive-healthcare-usa-hospital-beds?geometry=38.847%2C-16.820%2C-63.809%2C72.123"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.esri.com"
    }
  }

  measure: sum_county_num_licensed_beds {
    hidden: yes
    type: sum
    sql: ${county_num_licensed_beds} ;;
    link: {
      label: "Data Source - ESRI Hospital Beds"
      url: "https://coronavirus-resources.esri.com/datasets/definitivehc::definitive-healthcare-usa-hospital-beds?geometry=38.847%2C-16.820%2C-63.809%2C72.123"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.esri.com"
    }
  }

  measure: force_1 {
    hidden: yes
    type: average
    sql: 1 ;;
  }

  measure: estimated_percent_of_covid_cases_of_county {
    hidden: yes
    type: number
    sql:
      {% if
                hospital_bed_summary.hospital_name._in_query
            or  hospital_bed_summary.hospital_type._in_query
            or  hospital_bed_summary.hospital_location._in_query
      %} 1.0*${sum_num_licensed_beds}/nullif(${sum_county_num_licensed_beds},0)
      {% else %}  ${force_1}
      {% endif %} ;;
    value_format_name: percent_1
    link: {
      label: "Data Source - ESRI Hospital Beds"
      url: "https://coronavirus-resources.esri.com/datasets/definitivehc::definitive-healthcare-usa-hospital-beds?geometry=38.847%2C-16.820%2C-63.809%2C72.123"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.esri.com"
    }
  }

}
