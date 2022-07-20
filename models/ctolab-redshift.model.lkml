# Define the database connection to be used for this model.
connection: "ctolab-redshift"

# include all the views
include: "/views/**/*.view"
# include: "//covid19-1/views/country_region.view"

include: "/dashboards/*"
include: "/explores/*"

include: "//covid19-1/assets/*"


persist_with: covid_data

### PDT Timeframes

datagroup: covid_data {
  max_cache_age: "12 hours"
  sql_trigger:SELECT MAX(id) FROM etl_log;;
}



explore: state_region {}
#explore: open_data_main {}
#explore: covid_tracking_project {}
explore: hospital_bed_summary {}
explore: country_region {}
explore: policies_by_state {}

# explore: italy_province {}

# explore: italy_region {}

explore: population_demographics {}



explore: nyt_data {}
