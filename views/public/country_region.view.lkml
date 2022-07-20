# # The name of this view in Looker is "Country Region"
# view: country_region {
#   # The sql_table_name parameter indicates the underlying database table
#   # to be used for all fields in this view.
#   sql_table_name: public.country_region ;;
#   # No primary key is defined for this view. In order to join this view in an Explore,
#   # define primary_key: yes on a dimension that has no repeated values.

#   # Here's what a typical dimension looks like in LookML.
#   # A dimension is a groupable field that can be used to filter query results.
#   # This dimension will be called "Country" in Explore.

#   dimension: country {
#     type: string
#     map_layer_name: countries
#     sql: ${TABLE}.country ;;
#   }

#   dimension: global_south {
#     type: string
#     sql: ${TABLE}.global_south ;;
#   }

#   dimension: population {
#     type: number
#     sql: ${TABLE}.population ;;
#   }

#   dimension: region {
#     type: string
#     sql: ${TABLE}.region ;;
#   }

#   measure: count {
#     type: count
#     drill_fields: []
#   }
# }

view: country_region {
  sql_table_name: public.country_region ;;

  dimension: country {
    hidden: yes
    primary_key: yes
    type: string
    map_layer_name: countries
    sql: ${TABLE}.Country ;;
  }

  dimension: region {
    group_label: "Location"
    label: "Region (World)"
    type: string
    sql: ${TABLE}.Region ;;
    drill_fields: [covid_combined.country_region]
  }
}
