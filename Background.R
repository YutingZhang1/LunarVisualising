  #就是月相图的底图，五个对照组（一样的大小）排列
  library(WeightedTreemaps)
  library(dplyr)
  library(colorspace)
  
  df5 = read.csv("s15.csv")#对照组数据
  df5 <- df5 %>%
    mutate(city = gsub(" ", "\n", city)) %>%
    arrange(desc(m)) %>%
    mutate(re_size = 5)
  
  tm5 <- voronoiTreemap(
    data = df5,
    levels = c("prov", "city"),
    cell_size = "re_size",
    custom_color = "m",
    shape = "circle",
    positioning = c("regular", "clustered_by_area"),
    maxIteration = 80,
    error_tol = 0.001,
    seed = 31
  )
  #调色板：采用了黑白调色代替月相变化
  custom_pal_1 <- sequential_hcl(
    n = 34,
    h = c(-46, 78),
    c = c(0, 0),
    l = c(75, 82),
    power = c(0.8, 1),
    rev = TRUE
  )
  
  # 创建一个新的R绘图设备，并设置大小
  png("tm0_overall.png", width = 30, height = 30, units = "cm", res = 500)
  #进行绘图
  drawTreemap(
    tm5,
    color_palette = custom_pal_1,
    color_type = "custom_color",
    color_level = 2,
    label_size = 2,  # 调整label大小
    border_size = 2,
    border_color = gray(0.9),
    add = TRUE,
    layout = c(3, 3),
    position = c(2, 2)
  )
  
  
  drawTreemap(
    tm5,
    color_palette = custom_pal_1,
    color_type = "custom_color",
    color_level = 2,
    label_size = 2,  # 调整label大小
    border_size = 2,
    border_color = gray(0.9),
    add = TRUE,
    layout = c(3, 3), position = c(1, 2)
  )
  
  drawTreemap(
    tm5,
    color_palette = custom_pal_1,
    color_type = "custom_color",
    color_level = 2,
    label_size = 2,  # 调整label大小
    border_size = 2,
    border_color = gray(0.9),
    add = TRUE,
    layout = c(3, 3), position = c(2, 3)
  )
  
  drawTreemap(
    tm5,
    color_palette = custom_pal_1,
    color_type = "custom_color",
    color_level = 2,
    label_size = 2,  # 调整label大小
    border_size = 2,
    border_color = gray(0.9),
    add = TRUE,
    layout = c(3, 3), position = c(3, 2)
  )
  
  drawTreemap(
    tm5,
    color_palette = custom_pal_1,
    color_type = "custom_color",
    color_level = 2,
    label_size = 2,  # 调整label大小
    border_size = 2,
    border_color = gray(0.9),
    add = TRUE,
    layout = c(3, 3), position = c(2, 1)
  )
  
  
  dev.off()
