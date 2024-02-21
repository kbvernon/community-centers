
library(here)
library(sf)
library(terra)
library(tidyterra)
library(tidyverse)
library(tigris)

gpkg <- here("data", "community-centers.gpkg")

theme_set(theme_void(12))

region_labels <- c(
  "cmv" = "Central Mesa Verde",
  "nrg" = "Northern Rio Grande",
  "cib" = "Cibola"
)

# spatial data ------------------------------------------------------------

regions <- read_sf(gpkg, layer = "regions")

# original bbox was warped, adjusting this just for this visualization
regions[["geom"]][1] <- regions[["geom"]][1] |> 
  st_bbox() |> 
  st_as_sfc()

bb8 <- regions |> 
  st_buffer(10000) |> 
  st_bbox()

four_corners <- states() |> 
  rename_with(tolower) |> 
  filter(name %in% c("Utah", "Colorado", "New Mexico", "Arizona")) |> 
  select(name) |> 
  st_transform(4326)

# basemap -----------------------------------------------------------------

req <- file.path(
  "https://services.arcgisonline.com/",
  "arcgis/rest/services",
  "World_Imagery",
  "MapServer/export"
) |> httr2::request()

dx <- bb8[["xmax"]] - bb8[["xmin"]]
dy <- bb8[["ymax"]] - bb8[["ymin"]]

# which.max(c(dx, dy))

# max width is 4096
width <- 1000
height <- width * (dy/dx)

req <- httr2::req_body_form(
  req,
  bbox = paste0(bb8, collapse = ","),
  bboxSR = 4326L,
  format = "tiff",
  size = paste0(c(width, height), collapse = ","),
  outSR = 4326L,
  f = "json"
)

resp <- httr2::req_perform(req)

resp_meta <- RcppSimdJson::fparse(httr2::resp_body_string(resp))

imagery <- terra::rast(resp_meta[["href"]])

imagery <- imagery[[1:3]]

names(imagery) <- c("red", "green", "blue")

coord_ref <- paste0(
  "EPSG:", resp_meta[["extent"]][["spatialReference"]][["latestWkid"]]
)

crs(imagery) <- coord_ref

ext(imagery) <- unlist(resp_meta[["extent"]][c("xmin", "xmax", "ymin", "ymax")])

RGB(imagery) <- 1:3

# the connection to this image times out
# so we write it to a temporary file
fn <- tempfile(fileext = ".tif")

writeRaster(imagery, fn)

imagery <- rast(fn)

remove(req, resp, resp_meta, coord_ref, fn)

# labels madness ----------------------------------------------------------

suppressWarnings({
  
  region_labels_xy <- regions |> 
    st_cast("POINT") |> 
    slice(3, 9, 13) |> 
    st_coordinates() |> 
    as_tibble() |> 
    rename_with(tolower) |> 
    mutate(
      region = names(region_labels),
      label = unname(region_labels)
    )
  
})

x <- bb8[["xmax"]]

y <- four_corners |> 
  filter(name == "Colorado") |> 
  st_bbox()

y <- y[["ymin"]]

state_labels <- tibble(
  x = x - 0.05,
  y = y + c(0.07, -0.07),
  label = c("Colorado", "New Mexico")
)

landform_labels <- bind_rows(
  tibble(
    xs = -108.55170,
    ys = 37.55836,
    x = -108.22973,
    y = 37.42356,
    label = "Dolores River",
    hjust = 0
  ),
  tibble(
    xs = -108.48029,
    ys = 37.18730,
    x = -108.22973,
    y = 37.18730,
    label = "Mesa Verde NP",
    hjust = 0
  ),
  tibble(
    xs = -108.58796,
    ys = 37.34772,
    x = -108.58796,
    y = 36.90000,
    label = "Cortez",
    hjust = 0
  ),
  tibble(
    xs = -108.80312,
    ys = 37.25547,
    x = -108.80312,
    y = 36.58000,
    label = "Ute Mountain",
    hjust = 0
  ),
  tibble(
    xs = -108.71978,
    ys = 37.53321,
    x = -108.71978,
    y = 36.74000,
    label = "Yellow Jacket",
    hjust = 0
  ),
  tibble(
    xs = -106.06021,
    ys = 36.08472,
    x = -106.06021,
    y = 36.68664,
    label = "Rio Grande",
    hjust = 1
  ),
  tibble(
    xs = -105.76874,
    ys = 35.79290,
    x = -105.76874,
    y = 35.31012,
    label = "Sangre de Cristos",
    hjust = 1
  ),
  tibble(
    xs = -106.47031,
    ys = 36.03000,
    x = -106.62031,
    y = 36.03000,
    label = "Jemez Mountains",
    hjust = 1
  ),
  tibble(
    xs = -106.32063,
    ys = 35.80212,
    x = -106.62031,
    y = 35.80212,
    label = "Bandelier NM",
    hjust = 1
  ),
  tibble(
    xs = -106.22200,
    ys = 36.19475,
    x = -106.22200,
    y = 36.51664,
    label = "Rio Chama",
    hjust = 1
  ),
  tibble(
    xs = -105.94354,
    ys = 35.68533,
    x = -105.94354,
    y = 35.50000,
    label = "Santa Fe",
    hjust = 1
  ),
  tibble(
    xs = -108.34242,
    ys = 35.03788,
    x = -108.16500,
    y = 35.00788,
    label = "El Morro",
    hjust = 0
  ),
  tibble(
    xs = -108.74764,
    ys = 35.52534,
    x = -108.68000,
    y = 35.52534,
    label = "Gallup",
    hjust = 0
  ),
  tibble(
    xs = -108.49354,
    ys = 35.13384,
    x = -108.16500,
    y = 35.16384,
    label = "Ramah",
    hjust = 0
  ),
  tibble(
    xs = -108.85052,
    ys = 35.06641,
    x = -108.85052,
    y = 35.68000,
    label = "Zuni",
    hjust = 0
  ),
  tibble(
    xs = -108.99508,
    ys = 35.41781,
    x = -108.99508,
    y = 35.84000,
    label = "Manuelito",
    hjust = 0
  ),
  tibble(
    xs = -109.058124,
    ys = 34.81859,
    x = -108.16500,
    y = 34.81859,
    label = "Jaralosa Draw",
    hjust = 0
  )
)

remove(x, y)

# map ---------------------------------------------------------------------

cover <- st_sym_difference(st_union(regions), st_as_sfc(bb8))

ggplot() +
  geom_spatraster_rgb(
    data = imagery,
    maxcell = Inf
  ) +
  geom_sf(
    data = cover,
    fill = alpha("white", 0.75)
  ) +
  geom_sf(
    data = four_corners,
    fill = "transparent",
    linewidth = 0.2
  ) +
  geom_sf(
    data = regions,
    color = "black",
    fill = "transparent",
    linewidth = 0.5
  ) +
  geom_segment(
    data = landform_labels,
    aes(x, y, xend = xs, yend = ys),
    linewidth = 0.6,
    color = "white"
  ) +
  geom_segment(
    data = landform_labels,
    aes(x, y, xend = xs, yend = ys),
    linewidth = 0.2,
    color = "gray20"
  ) +
  geom_point(
    data = landform_labels,
    aes(xs, ys),
    color = "white",
    size = 0.75
  ) +
  geom_label(
    data = landform_labels,
    aes(x, y, label = label),
    size = 11/.pt,
    color = "gray20",
    hjust = landform_labels[["hjust"]]
  ) +
  geom_text(
    data = region_labels_xy,
    aes(x, y, label = label),
    color = "black",
    size = 16/.pt,
    hjust = c(0, 1, 0),
    vjust = 1,
    nudge_x = c(0.05, -0.05, 0.05),
    nudge_y = -0.01
  ) +
  geom_text(
    data = state_labels,
    aes(x, y, label = label),
    color = "gray20",
    size = 11/.pt,
    hjust = 1
  ) +
  geom_sf(
    data = st_as_sfc(bb8),
    color = "black",
    fill = "transparent",
    linewidth = 0.5
  ) +
  coord_sf(
    crs = 4326,
    datum = 4326,
    xlim = bb8[c("xmin", "xmax")],
    ylim = bb8[c("ymin", "ymax")],
    expand = FALSE
  )

ggsave(
  filename = here("figures", "labeled-overview-map.png"),
  width = 6.5,
  height = 6.5 * (dy/dx),
  dpi = 600
)
