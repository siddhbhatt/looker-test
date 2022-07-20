project_name: "ctolab-redshift"

# # # Use local_dependency: To enable referencing of another project
# # # on this instance with include: statements
# #
remote_dependency: covid19-1 {
  url: "https://github.com/looker-open-source/covid19-1.git"
  ref: "master"
}

constant: MAPBOX_API_KEY {
  value: "pk.eyJ1IjoibG9va2VyLW1hcHMiLCJhIjoiY2sxODBsbnBiMWx1aDNndGpieGtxN2p3NiJ9.hmqB9XRdFX29m1U6sOffLw"
}
