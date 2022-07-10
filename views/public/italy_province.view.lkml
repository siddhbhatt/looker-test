# The name of this view in Looker is "Italy Province"
view: italy_province {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: public.italy_province ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Codice Provincia" in Explore.

  dimension: codice_provincia {
    type: number
    sql: ${TABLE}.codice_provincia ;;
  }

  dimension: codice_regione {
    type: number
    sql: ${TABLE}.codice_regione ;;
  }

  dimension: data {
    type: string
    sql: ${TABLE}.data ;;
  }

  dimension: denominazione_provincia {
    type: string
    sql: ${TABLE}.denominazione_provincia ;;
  }

  dimension: denominazione_regione {
    type: string
    sql: ${TABLE}.denominazione_regione ;;
  }

  dimension: lat {
    type: number
    sql: ${TABLE}.lat ;;
  }

  dimension: long {
    type: number
    sql: ${TABLE}.long ;;
  }

  dimension: sigla_provincia {
    type: string
    sql: ${TABLE}.sigla_provincia ;;
  }

  dimension: stato {
    type: string
    sql: ${TABLE}.stato ;;
  }

  dimension: totale_casi {
    type: number
    sql: ${TABLE}.totale_casi ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
