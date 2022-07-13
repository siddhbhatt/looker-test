# # The name of this view in Looker is "Hospital Bed Summary"
# view: hospital_bed_summary {
#   # The sql_table_name parameter indicates the underlying database table
#   # to be used for all fields in this view.
#   sql_table_name: public.hospital_bed_summary ;;
#   # No primary key is defined for this view. In order to join this view in an Explore,
#   # define primary_key: yes on a dimension that has no repeated values.

#   # Here's what a typical dimension looks like in LookML.
#   # A dimension is a groupable field that can be used to filter query results.
#   # This dimension will be called "Bed Utilization" in Explore.

#   dimension: bed_utilization {
#     type: string
#     sql: ${TABLE}.bed_utilization ;;
#   }

#   dimension: cnty_fips {
#     type: number
#     sql: ${TABLE}.cnty_fips ;;
#   }

#   dimension: county_name {
#     type: string
#     sql: ${TABLE}.county_name ;;
#   }

#   dimension: fips {
#     type: number
#     sql: ${TABLE}.fips ;;
#   }

#   dimension: hospital_name {
#     type: string
#     sql: ${TABLE}.hospital_name ;;
#   }

#   dimension: hospital_type {
#     type: string
#     sql: ${TABLE}.hospital_type ;;
#   }

#   dimension: hq_address {
#     type: string
#     sql: ${TABLE}.hq_address ;;
#   }

#   dimension: hq_address1 {
#     type: string
#     sql: ${TABLE}.hq_address1 ;;
#   }

#   dimension: hq_city {
#     type: string
#     sql: ${TABLE}.hq_city ;;
#   }

#   dimension: hq_state {
#     type: string
#     sql: ${TABLE}.hq_state ;;
#   }

#   dimension: hq_zip_code {
#     type: string
#     sql: ${TABLE}.hq_zip_code ;;
#   }

#   dimension: num_icu_beds {
#     type: number
#     sql: ${TABLE}.num_icu_beds ;;
#   }

#   dimension: num_licensed_beds {
#     type: number
#     sql: ${TABLE}.num_licensed_beds ;;
#   }

#   dimension: num_staffed_beds {
#     type: number
#     sql: ${TABLE}.num_staffed_beds ;;
#   }

#   dimension: objectid {
#     type: number
#     value_format_name: id
#     sql: ${TABLE}.objectid ;;
#   }

#   dimension: potential_increase_in_bed_capac {
#     type: string
#     sql: ${TABLE}.potential_increase_in_bed_capac ;;
#   }

#   dimension: state_fips {
#     type: number
#     sql: ${TABLE}.state_fips ;;
#   }

#   dimension: state_name {
#     type: string
#     sql: ${TABLE}.state_name ;;
#   }

#   dimension: x {
#     type: string
#     sql: ${TABLE}.x ;;
#   }

#   dimension: y {
#     type: string
#     sql: ${TABLE}.y ;;
#   }

#   measure: count {
#     type: count
#     drill_fields: [state_name, county_name, hospital_name]
#   }
# }


#This view calculates thing like how many beds are available in different geograhies and estimates how many beds are being utilized

#source: defitinitve healthcare, https://opendata.arcgis.com/datasets/1044bb19da8d4dbfb6a96eb1b4ebf629_0.csv

view: hospital_bed_summary {
  derived_table: {
    distribution_style: all
    datagroup_trigger: covid_data
    #combining NYC fips codes to match other data
    sql:  SELECT x, y, objectid, hospital_name, hospital_type, hq_address, hq_address1, hq_city, hq_state, hq_zip_code, county_name, state_name, state_fips, cnty_fips, num_licensed_beds, num_staffed_beds, num_icu_beds, bed_utilization,
            case when cast(fips as integer) in ( 36005, 36081, 36061, 36047, 36085 ) then 36125 else cast(fips as integer) end as fips
            FROM public.hospital_bed_summary
            WHERE hospital_type not in ('Rehabilitation Hospital', 'Psychiatric Hospital', 'Religious Non-Medical Health Care Institution') ;;
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
    sql: SUBSTR('00000' || IFNULL(SAFE_CAST(${TABLE}.fips AS varchar), ''), -5) ;;
  }

  dimension: hospital_name {
    group_label: "Hospital (US Only)"
    type: string
    sql: ${TABLE}.HOSPITAL_NAME ;;
  }

  dimension: hospital_type {
    group_label: "Hospital (US Only)"
    type: string
    sql: ${TABLE}.HOSPITAL_TYPE ;;
  }

  dimension: hq_address {
    group_label: "Hospital (US Only)"
    label: "Hospital Address"
    type: string
    sql: ${TABLE}.HQ_ADDRESS ;;
  }

  dimension: hq_address1 {
    hidden: yes
    type: string
    sql: ${TABLE}.HQ_ADDRESS1 ;;
  }

  dimension: hq_city {
    group_label: "Hospital (US Only)"
    label: "Hospital City"
    type: string
    sql: ${TABLE}.HQ_CITY ;;
  }

  dimension: hq_state {
    hidden: yes
    type: string
    sql: ${TABLE}.HQ_STATE ;;
  }

  dimension: hq_zip_code {
    group_label: "Hospital (US Only)"
    label: "Hospital Zip Code"
    value_format_name: id
    type: number
    sql: ${TABLE}.HQ_ZIP_CODE ;;
  }

  dimension: lat {
    hidden: yes
    type: number
    sql: ${TABLE}.Y ;;
  }

  dimension: long {
    hidden: yes
    type: number
    sql: ${TABLE}.X ;;
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
    sql: ${TABLE}.STATE_FIPS ;;
  }

  dimension: state_name {
    hidden: yes
    type: string
    sql: ${TABLE}.STATE_NAME ;;
  }

  dimension: num_icu_beds {
    hidden: yes
    type: number
    sql: ${TABLE}.NUM_ICU_BEDS ;;
  }

  dimension: num_licensed_beds {
    hidden: yes
    type: number
    sql: ${TABLE}.NUM_LICENSED_BEDS ;;
  }

  dimension: num_staffed_beds {
    hidden: yes
    type: number
    sql: ${TABLE}.NUM_STAFFED_BEDS ;;
  }

  dimension: potential_increase_in_bed_capac {
    hidden: yes
    type: number
    sql: ${TABLE}.Potential_Increase_In_Bed_Capac ;;
  }

  dimension: county_num_icu_beds {
    hidden: yes
    type: number
    sql: select sum(num_icu_beds) from `lookerdata.covid19_block.hospital_bed_summary` where fips = ${fips};;
  }

  dimension: county_num_licensed_beds {
    hidden: yes
    type: number
    sql: select sum(num_licensed_beds) from `lookerdata.covid19_block.hospital_bed_summary` where fips = ${fips} ;;
  }

  dimension: county_num_staffed_beds {
    hidden: yes
    type: number
    sql: select sum(num_staffed_beds) from `lookerdata.covid19_block.hospital_bed_summary` where fips = ${fips} ;;
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
