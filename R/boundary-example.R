
library(here)
library(patchwork)
library(sf)
library(sfdep)
library(smoothr)
library(tidyverse)

# plot defaults -----------------------------------------------------------

theme_set(theme_bw())

theme_update(
  axis.text = element_blank(),
  axis.ticks = element_blank(),
  axis.title = element_blank(),
  panel.grid = element_blank(),
  plot.margin = margin(1,1,1,1),
  plot.title = element_text(size = rel(0.9), margin = margin(b = 1))
)

# data --------------------------------------------------------------------

pts <- here("data", "example-boundary-data.geojson") |> 
  read_sf() |> 
  slice(1)

short_paths <- here("data", "example-boundary-data.geojson") |> 
  read_sf() |> 
  slice(-1)

# plots -------------------------------------------------------------------

hulls <- ggplot() +
  geom_sf(
    data = pts |> st_convex_hull(),
    fill = "#8b8b8b",
    color = "#3e3e3e"
  ) +
  geom_sf(
    data = pts |> st_concave_hull(0.1),
    fill = "#f6f6f6",
    color = "#3e3e3e"
  ) +
  geom_sf(
    data = pts,
    size = 1.6,
    color = "white"
  ) +
  geom_sf(
    data = pts,
    shape = 21,
    size = 1,
    fill = "#6f6f6f",
    color = "#222222"
  ) +
  ggtitle("Hull Geometries")

paths <- ggplot() +
  geom_sf(
    data = short_paths,
    color = "#6f6f6f",
    linewidth = 0.3
  ) +
  geom_sf(
    data = pts,
    size = 1.6,
    color = "white"
  ) +
  geom_sf(
    data = pts,
    shape = 21,
    size = 1,
    fill = "#6f6f6f",
    color = "#222222"
  ) +
  ggtitle("Short Paths")

comm <- ggplot() +
  geom_sf(
    data = short_paths |> 
      st_cast("POINT") |> 
      bind_rows(pts) |> 
      st_combine() |> 
      st_concave_hull(0.5),
    fill = "#e2e2e2",
    color = "#3e3e3e"
  ) +
  geom_sf(
    data = pts,
    size = 1.6,
    color = "white"
  ) +
  geom_sf(
    data = pts,
    shape = 21,
    size = 1,
    fill = "#6f6f6f",
    color = "#222222"
  ) +
  ggtitle("Community Boundary")

hulls + paths + comm

# save --------------------------------------------------------------------

fn <- here("figures", "boundary-example.png")

ggsave(fn, width = 6, dpi = 300)

prepare_image <- function(x, dx = 2, dy = 30, color = "white") {
  
  img <- image_read(path = x)
  
  img <- image_trim(img)
  
  info <- image_info(img)
  
  new_width <- info[["width"]] + dx
  new_height <- info[["height"]] + dy
  
  img <- image_extent(
    img, 
    geometry_area(new_width, new_height), 
    color = color
  )
  
  image_write(img, path = x)
  
}

prepare_image(fn)
