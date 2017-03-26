search_lpi <- function(search_text){
  base_url <- "http://maps.six.nsw.gov.au/arcgis/rest/services/sixmaps/LPIMap/MapServer/find"
  params <- list(
    searchText = search_text,
    contains = "true",
    searchFields = "poiname",
    layers = 7,
    returnGeometry = "true",
    returnZ = "true",
    returnM = "true",
    f = "pjson"
  )
  mod_url <- modify_url(base_url, query = params)
  httr::GET(mod_url)
}

get_lpi_property <- function(search_text){
  base_url <- "http://maps.six.nsw.gov.au/arcgis/rest/services/sixmaps/LPIMap/MapServer/63/query"
  params <- list(
    geometry = search_text,
    geometryType = "esriGeometryPoint",
    spatialRel = "esriSpatialRelWithin",
    outFields = "OBJECTID,shape,createdate,gurasid,principaladdresssiteoid,propertytype,valnetpropertystatus,valnetpropertytype,dissolveparcelcount,valnetlotcount,valnetworkflowid,propid,uuid,urbanity,superlot,housenumber,address,_x_centroid,_y_centroid,shape_Length,shape_Area",
    returnGeometry = "true",
    returnTrueCurves = "true",
    returnIdsOnly = "false",
    returnCountOnly = "false",
    returnZ = "false",
    returnM = "false",
    returnDistinctValues = "false",
    f = "pjson"
  )
  mod_url <- modify_url(base_url, query = params)
  httr::GET(mod_url)
}

get_lpi_school <- function(search_text){
  search_result <- search_lpi(search_text)
  if(length(fromJSON(content(search_result))$results) > 0){
    x <- fromJSON(content(search_result))$results[[1]]$geometry$x
    y <- fromJSON(content(search_result))$results[[1]]$geometry$y
    return(get_lpi_property(paste(x, y, sep = ",")))
  } else {
    return('')
  }
}

for(n in 1:nrow(schools)){
  school_name <- schools$name[n]
  school_geo <- get_lpi_school(school_name)
  if(typeof(school_geo) == "list") write_file(content(school_geo), paste0("./data/lpi/", school_name, ".json"))
  Sys.sleep(2)
}
