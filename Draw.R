#月相流量图
library(WeightedTreemaps)
library(dplyr)
library(colorspace)
#输入数据
df1 = read.csv("s1.csv")
df2 = read.csv("s2.csv")
df3 = read.csv("s3.csv")
df4 = read.csv("s4.csv")
df5 = read.csv("s5.csv")

df1 <- df1 %>%
  mutate(city = gsub(" ", "\n", city)) %>%
  arrange(desc(m)) %>%
  mutate(re_size = 5)
df2 <- df2 %>%
  mutate(city = gsub(" ", "\n", city)) %>%
  arrange(desc(m)) %>%
  mutate(re_size = 5)
df3 <- df3 %>%
  mutate(city = gsub(" ", "\n", city)) %>%
  arrange(desc(m)) %>%
  mutate(re_size = 5)
df4 <- df4 %>%
  mutate(city = gsub(" ", "\n", city)) %>%
  arrange(desc(m)) %>%
  mutate(re_size = 5)

df5 <- df5 %>%
  mutate(city = gsub(" ", "\n", city)) %>%
  arrange(desc(m)) %>%
  mutate(re_size = 5)

# 设置随机数种子

#设置格式
tm1 <- voronoiTreemap(
  data = df1,
  levels = c("prov", "city"),
  cell_size = "re_size",
  custom_color = "m",
  shape = "circle",
  positioning = c("regular", "clustered_by_area"),
  maxIteration = 80,
  error_tol = 0.001,
  seed = 31
)

tm2 <- voronoiTreemap(
  data = df2,
  levels = c("prov", "city"),
  cell_size = "re_size",
  custom_color = "m",
  shape = "circle",
  positioning = c("regular", "clustered_by_area"),
  maxIteration = 80,
  error_tol = 0.001,
  seed = 31
)

tm3 <- voronoiTreemap(
  data = df3,
  levels = c("prov", "city"),
  cell_size = "re_size",
  custom_color = "m",
  shape = "circle",
  positioning = c("regular", "clustered_by_area"),
  maxIteration = 80,
  error_tol = 0.001,
  seed = 31
)

tm4 <- voronoiTreemap(
  data = df4,
  levels = c("prov", "city"),
  cell_size = "re_size",
  custom_color = "m",
  shape = "circle",
  positioning = c("regular", "clustered_by_area"),
  maxIteration = 80,
  error_tol = 0.001,
  seed = 31
)

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
#设置调色板
custom_pal_1 <- sequential_hcl(
  n = 34,
  h = c(-46, 78),
  c = c(55, 70, 50),
  l = c(65, 95),
  power = c(0.8, 1),
  rev = TRUE
) 
#设置每个图的流量大小（与对照组相比）
# 创建一个新的R绘图设备，并设置大小为9.5cm x 9.5cm
png("tm1_2019.png", width = 28.2, height = 28.2, units = "cm", res = 1500)

drawTreemap(
  tm1,
  color_palette = custom_pal_1,
  color_type = "custom_color",
  color_level = 2,
  label_level = c(1,2),
  label_size = 4,  # 调整label大小
  label_color = "black",
  border_size = c(5,3),
  border_color = gray(0.6),
  position = c(1, 1)
)
dev.off()


# 创建一个新的R绘图设备，并设置大小
png("tm1_2020.png", width = 26.5, height = 26.5, units = "cm", res = 1500)

drawTreemap(
  tm2,
  color_palette = custom_pal_1,
  color_type = "custom_color",
  color_level = 2,
  label_level = c(1,2),
  label_size = 4,  # 调整label大小
  label_color = "black",
  border_size = c(5,3),
  border_color = gray(0.6),
  position = c(1, 1)
)
dev.off()

# 创建一个新的R绘图设备，并设置大小
png("tm1_2021.png", width = 18.2, height = 18.2, units = "cm", res = 1500)

drawTreemap(
  tm3,
  color_palette = custom_pal_1,
  color_type = "custom_color",
  color_level = 2,
  label_level = c(1,2),
  label_size = 3,  # 调整label大小
  label_color = "black",
  border_size = c(4,2),
  border_color = gray(0.5),
  position = c(1, 1)
)
dev.off()

# 创建一个新的R绘图设备，并设置大小
png("tm1_2022.png", width = 23.5, height = 23.5, units = "cm", res = 1500)

drawTreemap(
  tm4,
  color_palette = custom_pal_1,
  color_type = "custom_color",
  color_level = 2,
  label_level = c(1,2),
  label_size = 4,  # 调整label大小
  label_color = "black",
  border_size = c(5,3),
  border_color = gray(0.6),
  position = c(1, 1)
)
dev.off()

# 创建一个新的R绘图设备，并设置大小
png("tm1_2023.png", width = 30, height = 30, units = "cm", res = 1600)

drawTreemap(
  tm5,
  color_palette = custom_pal_1,
  color_type = "custom_color",
  color_level = 2,
  label_level = c(1,2),
  label_size = 5,  # 调整label大小
  label_color = "black",
  border_size = c(5,3),
  border_color = gray(0.6),
  position = c(1, 1)
)

dev.off()