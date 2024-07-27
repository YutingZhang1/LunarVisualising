#'@title Data Convert to LunarVisualise
#'@description data convert to LunarVisualise
#'@param prepared_data
#'@return NULL
#'@examples LunarVisualise('prepared_data')
#'@export

LunarVisualise<-function(prepared_data)
{


#月相底图
library(WeightedTreemaps)
library(dplyr)
library(colorspace)

df5 = read.csv("s5.csv")#对照组数据
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
  error_tol = 0.1,
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
png("月相底图.png", width = 30, height = 30, units = "cm", res = 500)
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

#月相图
#加载库
library(WeightedTreemaps)
library(dplyr)
library(colorspace)
library(gridExtra)
library(grid)
library(png)

# 输入每年数据
df1 = read.csv("s1.csv")
df2 = read.csv("s2.csv")
df3 = read.csv("s3.csv")
df4 = read.csv("s4.csv")
df5 = read.csv("s5.csv")

# 数据处理
process_data <- function(df) {
  df %>%
    mutate(city = gsub(" ", "\n", city)) %>%
    arrange(desc(m)) %>%
    mutate(re_size =1)
}

df1 <- process_data(df1)
df2 <- process_data(df2)
df3 <- process_data(df3)
df4 <- process_data(df4)
df5 <- process_data(df5)

# 创建Voronoi树图
create_treemap <- function(data) {
  voronoiTreemap(
    data = data,
    levels = c("prov", "city"),
    cell_size = "re_size",
    custom_color = "m",
    shape = "circle",
    positioning = c("regular", "clustered_by_area"),
    maxIteration = 80,
    error_tol = 0.1,
    seed = 31
  )
}

tm1 <- create_treemap(df1)
tm2 <- create_treemap(df2)
tm3 <- create_treemap(df3)
tm4 <- create_treemap(df4)
tm5 <- create_treemap(df5)

# 设置自定义调色板
custom_pal_1 <- sequential_hcl(
  n = 34,
  h = c(-46, 78),
  c = c(55, 70, 50),
  l = c(65, 95),
  power = c(0.8, 1),
  rev = TRUE
)

# 保存每个树图为PNG文件
saveTreemapPNG <- function(treemap, filename, label_size, width, height) {
  png(filename, width = width, height = height, units = "cm", res = 500)  # 降低分辨率
  drawTreemap(
    treemap,
    color_palette = custom_pal_1,
    color_type = "custom_color",
    color_level = 2,
    label_level = c(1, 2),
    label_size = label_size,
    label_color = "black",
    border_size = c(3, 1.5),
    border_color = gray(0.6),
    #legend = TURE,
    position = c(1, 1)
  )
  dev.off()
}

# 保存每个图的 PNG，设置对应的大小
saveTreemapPNG(tm1, "tm1_2019.png", 2, 9.4, 9.4)  # 2019
saveTreemapPNG(tm2, "tm1_2020.png", 1.8, 8.8, 8.8)  # 2020
saveTreemapPNG(tm3, "tm1_2021.png", 1.2, 6.0, 6.0)  # 2021
saveTreemapPNG(tm4, "tm1_2022.png", 1.6, 7.8, 7.8)  # 2022
saveTreemapPNG(tm5, "tm1_2023.png", 2.2, 10.0, 10.0) # 2023

# 生成组合图并设置高分辨率
png("combined_treemap.png", width = 30, height = 30, units = "cm", res = 1000)

# 使用grid来绘制组合图
grid.newpage()

# 读取每个图像
img1 <- png::readPNG("tm1_2019.png")
img2 <- png::readPNG("tm1_2020.png")
img3 <- png::readPNG("tm1_2021.png")
img4 <- png::readPNG("tm1_2022.png")
img5 <- png::readPNG("tm1_2023.png")

# 设置均匀间隔的布局
pushViewport(viewport(layout = grid.layout(3, 3,
                                           widths = unit(rep(1/3, 3), "npc"),
                                           heights = unit(rep(1/3, 3), "npc"))))

# 在指定位置绘制每个图，保持相对比例
grid.raster(img1, width = unit(9.4 / 10, "npc"), height = unit(9.4 / 10, "npc"),
            vp = viewport(layout.pos.row = 2, layout.pos.col = 2))  # 2019 (2,2)

grid.raster(img2, width = unit(8.8 / 10, "npc"), height = unit(8.8 / 10, "npc"),
            vp = viewport(layout.pos.row = 2, layout.pos.col = 3))  # 2020 (2,3)

grid.raster(img3, width = unit(6.0 / 10, "npc"), height = unit(6.0 / 10, "npc"),
            vp = viewport(layout.pos.row = 1, layout.pos.col = 2))  # 2021 (1,2)

grid.raster(img4, width = unit(7.8 / 10, "npc"), height = unit(7.8 / 10, "npc"),
            vp = viewport(layout.pos.row = 2, layout.pos.col = 1))  # 2022 (2,1)

grid.raster(img5, width = unit(10.0 / 10, "npc"), height = unit(10.0 / 10, "npc"),
            vp = viewport(layout.pos.row = 3, layout.pos.col = 2))  # 2023 (3,2)

dev.off()
}
