
# Lunar Phase Visualisation Technology

**Hengyu Gu** ([ResearchGate](https://www.researchgate.net/profile/Hengyu-Gu)) and **Yuting Zhang** ([ResearchGate](https://www.researchgate.net/profile/Yu-Zhang-1116))     Nanjing University <br />

<p>

<img src="https://img.shields.io/badge/multi-hierarchical-ee3437">

<img src="https://img.shields.io/badge/multi-scale-0081c1">

<img src="https://img.shields.io/badge/multi-temporal-9d55a2">
 
<img src="https://img.shields.io/badge/migration-data-0bae57">
 
<img src="https://img.shields.io/badge/Lunar-phases-2e95a0">

</p>


------------------------------------------------------------------------

The **LunarVisualising** package is designed to generate visualisations of lunar phases using Voronoi diagram combinations, representing multi-level, multi-scale, and multi-period migration data.

## Introduction

This paper introduces a visualization technique for intercity population movement called Lunar Phase Visualization. By utilizing a method based on **Voronoi treemaps** [(Jahn et al., 2021)](https://github.com/m-jahn/WeightedTreemaps)and drawing inspiration from lunar phase arrangements, this innovative approach uses the moon's changing phases to represent data decreases, assigning different colors to 365 cities in China.

The maximum value within a given period serves as **the control group**. Shaded areas illustrate reductions in intercity population flow (waning phase), enabling a more intuitive comparison of changes during each year's Spring Festival.

Using this lunar phase visualization method, based on the latest location-based service data from Gaode Maps, this paper illustrates three intercity travel patterns during the Spring Festival peak from 2019 to 2023. These patterns include the return home period, the return to city period, and the overall period.

<p float="center">
  <img src="https://github.com/YutingZhang1/LunarVisualising/blob/master/Lunar_phases_Visualisation.png.jpg" width=45% height=45% />
</p>
<p align="center"><i>Intercity mobility patterns during the Spring Festival travel rush, 2019–2023.</i></p>


**Data Source** (https://report.amap.com/migrate/page.do)   
**Note:** Shaded regions indicate reduced mobility, with 2023 as the benchmark. Colour represents the intercity mobility volume of each city. Circle size represents total daily average intercity mobility for all cities in each year.

**Methods:**
1. Use the Weightedtreemaps package in R.
2. Calculate Recovery index: 
- Recovery index 2019: \(\left( \frac{\text{2019 total} - \text{2020 total}}{\text{2020 total}} \right) \times 100\%\)
 -Recovery index 2020: \(\left( \frac{\text{2023 total} - \text{2020 total}}{\text{2020 total}} \right) \times 100\%\)

These indices illustrate observed intercity mobility patterns from 2019 to 2023, covering the return home period (first 20 days), the back-to-city period (last 20 days), and the total 40 day period.

<p float="center">
  <img src="https://github.com/YutingZhang1/LunarVisualising/blob/master/Single_Lunarphases.png" width=45% height=45% />
</p>
<p align="center"><i>Single_Lunar phases Visualision_diagram, 2022.</i></p>
**Zoomed View:** Taking the return home period in 2022 as an example, the grey shaded area represents the reduced average mobility compared to 2023. Among the four municipalities, Chongqing had the largest average mobility among municipalities in 2022, with significant movement in Guangzhou, Dongguan, Foshan, Shenzhen, Suzhou, and Chengdu during the return home period.

## Installation

Use the following code in R for installation:

```r
devtools::install_github("YutingZhang1/LunarVisualising", force=TRUE)
```

## Data Format
| City                                   | Prov    | m      |
|----------------------------------------|---------|--------|
| Aba Tibetan and Qiang Autonomous Prefecture | Sichuan | 151971 |
| Aksu Area                             | Xinjiang| 59673  |
| Aral                                   | Xinjiang| 16538  |
| Alxa League                            | Inner Mor| 61437  |
| Altay Region                          | Xinjiang| 19955  |
| Ngari Area                            | Tibet   | 738    |
| Ankang                                 | Shaanxi | 498643 |
| Anqing                                 | Anhui   | 1490926|
| Anshun                                 | Guizhou | 835726 |
| Anyang                                 | Henan   | 909789 |
| Anshan                                 | Liaoning| 478499 |
| Bayannur                               | Inner Mor| 112539 |


- `city` for the first level
- `prov` for the second level
- `m` represents the population flow for each city

## Usage

### Required Parameters:

```r
# Input five years of data
df1 = read.csv("s1.csv")
# Save PNG for each year, comparing size relative to the year with maximum total flow. This step requires manual calculation in advance, e.g., 2 for 2019.
saveTreemapPNG(tm1, "tm1_2019.png", 2, sizes_matrix[1, 1], sizes_matrix[1, 2])  # 2019
```

### Optional Parameters:

- `color_level`: Input the level, e.g., 2
- `seed`: Initializes the random seed for graphical patterns. Different seed numbers produce different patterns. Setting the same seed ensures the same pattern in each iteration.
- `error_tol`: The allowable error rate between actual and theoretical polygon sizes. The smaller the value, the more precise. Default is 0.01.
- `maxIteration`: Maximum number of iterations. The higher the number, the greater the probability of convergence. Default is 10000. Lower `error_tol` and higher `maxIteration` require higher computational performance.

### Colour Palettes:

- **Lunar Shades:**

```r
custom_pal_1 <- sequential_hcl(
  n = 20,
  h = c(-46, 78),
  c = c(61, 78, 54),
  l = c(60, 91),
  power = c(0.8, 1),
  rev = TRUE
)
```

- **Black and White Shades:**

```r
custom_pal_2 <- sequential_hcl(
  n = 34,
  h = c(-46, 78),
  c = c(0, 0),
  l = c(75, 82),
  power = c(0.8, 1),
  rev = TRUE
)
```

- **Heatmap Gradient:**

```r
custom_pal_3 <- diverging_hcl(
  n = 7,
  h = c(340, 128),
  c = c(60, 80),
  l = c(75, 97),
  power = c(0.8, 1.5),
  rev = TRUE
)
```

### Example Operations:

```r
# Input data for each year
df1 = read.csv("s1.csv")
#...
df5 = read.csv("s5.csv")

# Create Voronoi treemap
create_treemap <- function(data) {
  voronoiTreemap(
    data = data,
    levels = c("prov", "city"),
    cell_size = "re_size",
    custom_color = "m",
    shape = "circle",
    positioning = c("regular", "clustered_by_area"),
    maxIteration = 80,
    error_tol = 0.001,
    seed = 31
  )
}

tm1 <- create_treemap(df1)
#...
tm5 <- create_treemap(df5)

# Save as PNG file
saveTreemapPNG <- function(treemap, filename, label_size, width, height) {
  png(filename, width = width, height = height, units = "cm", res = 1000)
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
    #legend = TRUE,
    position = c(1, 1)
  )
  dev.off()
}

# Save PNG for each year, setting relative size
saveTreemapPNG(tm1, "tm1_2019.png", 2, sizes_matrix[1, 1], sizes_matrix[1, 2])  # 2019
#...
saveTreemapPNG(tm5, "tm1_2023.png", 2.2, sizes_matrix[5, 1], sizes_matrix[5, 2])  # 2023
```

## Citation

Please cite using this form (APA for example):

Gu, H., & Zhang, Y. (2024). Visualising intercity mobility patterns during China’s Spring Festival travel rush under the COVID-19 pandemic. *Regional Studies, Regional Science, 11*(1), 471–473. https://doi.org/10.1080/21681376.2024.2375012

## Acknowledgements

This package is built on pioneering work by [Michael Jahn (2021)](https://github.com/m-jahn/WeightedTreemaps) and [Hengyu Gu (2022)](https://github.com/HengyuGu1994/MigrationKaleidoscope), which made the creation of Lunar phases visualisation possible. Based on their original treemap version, this package integrates Voronoi treemaps with innovative shaded diagrams to better illustrate the values of each component. We sincerely thank them for their generous contributions and dedication.



