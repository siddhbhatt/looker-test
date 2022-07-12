# # The name of this view in Looker is "State Region"
# view: state_region {
#   # The sql_table_name parameter indicates the underlying database table
#   # to be used for all fields in this view.
#   sql_table_name: public.state_region ;;
#   # No primary key is defined for this view. In order to join this view in an Explore,
#   # define primary_key: yes on a dimension that has no repeated values.

#   # Here's what a typical dimension looks like in LookML.
#   # A dimension is a groupable field that can be used to filter query results.
#   # This dimension will be called "Division" in Explore.

#   dimension: division {
#     type: string
#     sql: ${TABLE}.division ;;
#   }

#   dimension: region {
#     type: string
#     sql: ${TABLE}.region ;;
#   }

#   dimension: state {
#     type: string
#     sql: ${TABLE}.state ;;
#   }

#   dimension: state_code {
#     type: string
#     sql: ${TABLE}.state_code ;;
#   }

#   measure: count {
#     type: count
#     drill_fields: []
#   }
# }

view: state_region {
  sql_table_name: public.state_region;;

  dimension: division {
    hidden: yes
    type: string
    sql: ${TABLE}.Division ;;
  }

  dimension: region {
    group_label: "Location"
    label: "Region (US-Only)"
    type: string
    sql: ${TABLE}.Region ;;
  }

  dimension: state {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.State ;;
    drill_fields: [covid_combined.province_state]
  }

  dimension: state_code {
    hidden: yes
    type: string
    sql: ${TABLE}.StateCode ;;
  }
}
