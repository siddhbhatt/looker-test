# Define the database connection to be used for this model.
connection: "ctolab-redshift"

# include all the views
include: "/views/*/*.view"
# include: "//covid19-1/views/country_region.view"

include: "/dashboards/*"
include: "/explores/*"

include: "//covid19-1/assets/*"

# Datagroups define a caching policy for an Explore. To learn more,
# use the Quick Help panel on the right to see documentation.

# datagroup: ctolab_redshift_default_datagroup {
#   # sql_trigger: SELECT MAX(id) FROM etl_log;;
#   max_cache_age: "1 hour"
# }

# persist_with: ctolab_redshift_default_datagroup

############ Caching Logic ############

persist_with: covid_data

### PDT Timeframes

datagroup: covid_data {
  max_cache_age: "12 hours"
  sql_trigger:SELECT MAX(id) FROM etl_log;;
}

# datagroup: covid_data {
#   max_cache_age: "12 hours"
#   sql_trigger:
#     SELECT min(max_date) as max_date
#     FROM
#     (
#       SELECT max(cast(date as date)) as max_date FROM `bigquery-public-data.covid19_nyt.us_counties`
#       UNION ALL
#       SELECT max(cast(date as date)) as max_date FROM `bigquery-public-data.covid19_open_data.compatibility_view`
#     ) a
#   ;;
# }

# Explores allow you to join together different views (database tables) based on the
# relationships between fields. By joining a view into an Explore, you make those
# fields available to users for data analysis.
# Explores should be purpose-built for specific use cases.

# To see the Explore you’re building, navigate to the Explore menu and select an Explore under "Ctolab-redshift"

# To create more sophisticated Explores that involve multiple views, you can use the join parameter.
# Typically, join parameters require that you define the join type, join relationship, and a sql_on clause.
# Each joined view also needs to define a primary key.

# explore: connection_reg_r3 {}

explore: country_region {}

explore: hospital_bed_summary {}

# explore: italy_province {}

# explore: italy_region {}

explore: population_demographics {}

explore: state_region {}

explore: nyt_data {}
