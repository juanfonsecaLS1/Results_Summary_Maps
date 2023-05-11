my_map = function(city) {
  library(tidyverse)
  library(tmap)
  library(geojsonsf)
  library(sf)
  library(sysfonts)
  
  polygon = geojson_sf(paste0("../OSM_metrics/03_maps/polygon_", city, ".geojson"))
  
  st_crs(polygon) = 27700
  
  sf_locations = geojson_sf(paste0("../OSM_metrics/03_maps/points_", city, ".geojson"))
  
  st_crs(sf_locations) = 27700
  
  my_selected_roads = geojson_sf(paste0("../OSM_metrics/03_maps/roads_", city, ".geojson"))
  
  st_crs(my_selected_roads) = 27700
  
  my_types = c("residential","unclassified","tertiary","secondary","primary","trunk","motorway")
  
  my_selected_roads$highway = factor(my_selected_roads$highway,
                                     levels = str_to_title(rev(my_types)),
                                     labels = str_to_title(rev(my_types)),
                                     ordered = T)
  
  

  
  tmap_mode("view")
  my_map = tm_shape(polygon) +
    tm_fill(alpha = 0.3, col = "darkblue") +
    tm_shape(my_selected_roads) +
    tm_lines(
      title.col = "Road type:",
      col = "highway",
      palette = rev(c("#ffb703",
                             "#fd9e02",
                             "#fb8500",
                             "#8ecae6",
                             "#219ebc",
                             "#126782",
                             "#023047"))) +
    tm_shape(sf_locations) +
    tm_dots(col = "#3f3f3f")
  
  return(my_map)
}
