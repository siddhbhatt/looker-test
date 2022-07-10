# The name of this view in Looker is "Italy Region"
view: italy_region {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: public.italy_region ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Codice Regione" in Explore.

  dimension: codice_regione {
    type: number
    sql: ${TABLE}.codice_regione ;;
  }

  dimension: data {
    type: string
    sql: ${TABLE}.data ;;
  }

  dimension: deceduti {
    type: number
    sql: ${TABLE}.deceduti ;;
  }

  dimension: denominazione_regione {
    type: string
    sql: ${TABLE}.denominazione_regione ;;
  }

  dimension: dimessi_guariti {
    type: number
    sql: ${TABLE}.dimessi_guariti ;;
  }

  dimension: isolamento_domiciliare {
    type: number
    sql: ${TABLE}.isolamento_domiciliare ;;
  }

  dimension: lat {
    type: number
    sql: ${TABLE}.lat ;;
  }

  dimension: long {
    type: number
    sql: ${TABLE}.long ;;
  }

  dimension: note_en {
    type: string
    sql: ${TABLE}.note_en ;;
  }

  dimension: note_it {
    type: string
    sql: ${TABLE}.note_it ;;
  }

  dimension: nuovi_positivi {
    type: number
    sql: ${TABLE}.nuovi_positivi ;;
  }

  dimension: ricoverati_con_sintomi {
    type: number
    sql: ${TABLE}.ricoverati_con_sintomi ;;
  }

  dimension: stato {
    type: string
    sql: ${TABLE}.stato ;;
  }

  dimension: tamponi {
    type: number
    sql: ${TABLE}.tamponi ;;
  }

  dimension: terapia_intensiva {
    type: number
    sql: ${TABLE}.terapia_intensiva ;;
  }

  dimension: totale_casi {
    type: number
    sql: ${TABLE}.totale_casi ;;
  }

  dimension: totale_ospedalizzati {
    type: number
    sql: ${TABLE}.totale_ospedalizzati ;;
  }

  dimension: totale_positivi {
    type: number
    sql: ${TABLE}.totale_positivi ;;
  }

  dimension: variazione_totale_positivi {
    type: number
    sql: ${TABLE}.variazione_totale_positivi ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
