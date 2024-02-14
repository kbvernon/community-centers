
# get elevation data
library(here)
library(purrr)
library(sf)
library(terra)

download_dem <- function(x){
  
  # location of the virtual raster pointing to the
  # USGS one arc second elevation data (~30 m resolution)
  elevation_source <- file.path(
    "https://prd-tnm.s3.amazonaws.com/StagedProducts",
    "Elevation/1/TIFF",
    "USGS_Seamless_DEM_1.vrt"
  )

  # connect to vrt
  rr <- terra::rast(elevation_source, vsi = TRUE)

  feature <- terra::vect(x)
  feature <- terra::project(feature, terra::crs(rr))
  feature <- terra::ext(feature)
  feature <- terra::vect(feature, crs = terra::crs(rr))

  fn <- paste0("dem-", x[["region"]], ".tif")

  rr <- terra::crop(
    rr,
    feature,
    snap = "out",
    mask = TRUE,
    filename = here("data", fn),
    datatype = "FLT4S",
    gdal = c("COMPRESS=DEFLATE", "ZLEVEL=9"),
    overwrite = TRUE
  )
  
}

here("data", "community-centers.gpkg") |> 
  read_sf(layer = "regions") |> 
  split(1:3) |> 
  walk(download_dem)
