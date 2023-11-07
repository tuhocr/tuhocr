## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  message = FALSE, 
  warning = FALSE,
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
# install.packages("FAOSTAT")
# library(FAOSTAT)

# search_dataset(dataset_code = "QCL",
#                latest = TRUE, 
#                reset_cache = FALSE)
# 
# crop_production <- get_faostat_bulk(code = "QCL", 
#                                     data_folder = "./")

# bạn có thể lưu file này ra dạng .RDS để sau này đọc lại từ R sẽ nhanh hơn,
# không cần download lại từ FAOSTAT.

# saveRDS(crop_production, "crop_production.rds")

# crop_production <- readRDS("crop_production.rds")

## -----------------------------------------------------------------------------
# chọn Country/Region ở link này https://www.fao.org/faostat/en/#definitions

## ----setup--------------------------------------------------------------------
# df_1 <- readRDS("crop_production.rds")
# df_2 <- read.csv("FAOSTAT_data_2023.csv")

crop_production <- system.file("extdata",
                               "crop_production_all_data.rds",
                               package = "tuhocr")

df_1 <- readRDS(crop_production)

FAOSTAT_data_2023 <- system.file("extdata",
                                 "FAOSTAT_data_3-21-2023.csv", 
                                 package = "tuhocr")

df_2 <- read.csv(FAOSTAT_data_2023)

library(tuhocr)

# Thực hiện dòng lệnh sẽ thu được danh sách các quốc gia
# sản xuất cà phê trên thế giới được sắp xếp theo
# thứ hạng và năm.

coffee_data <- filter_faostat(data_rds = df_1,
data_region = df_2,
item_filter = "Coffee, green",
rank_filter = 1:10,
year_filter = c(2021))

coffee_data
str(coffee_data)

## -----------------------------------------------------------------------------
soya_data <- extract_faostat(input_rds = df_1,
                             input_region = df_2,
                             input_item = "Soya beans")

head(soya_data, n = 30)

## -----------------------------------------------------------------------------
crop_full <- df_1
ok <- as.data.frame(table(crop_full$item, crop_full$element))
ok_1 <- ok |> subset(Freq != 0)
ok_2 <- reshape(data = ok_1,
                idvar = c("Var1"),
                v.names = "Freq",
                timevar = "Var2",
                direction = "wide")
ok_2[!is.na(ok_2$Freq.area_harvested) & !is.na(ok_2$Freq.production), ] -> ok_3
as.character(ok_3$Var1) -> crop_item
crop_item

## ---- fig.width=9, fig.height=4-----------------------------------------------
coffee_data <- filter_faostat(data_rds = df_1,
                              data_region = df_2,
                              item_filter = "Coffee, green",
                              rank_filter = 1:10,
                              year_filter = 2021)

## vì kết quả trả về ở dạng factor cho danh sách các quốc gia
## bạn cần reset lại giá trị factor này để reorder lại theo đúng ý bạn muốn
## giúp việc vẽ đồ thị được thuận lợi.

coffee_data$area <- as.character(coffee_data$area)

coffee_data$area <- reorder(coffee_data$area, coffee_data$production, decreasing = TRUE)

coffee_data$production <- coffee_data$production / 1000000

label <- coffee_data$production

names(label) <- coffee_data$area

round(label, digits = 3) -> label

par(mar = c(4, 5, 3, 3))
par(cex = 0.8)
par(font.axis = 2)
par(font.lab = 2)

b <- barplot(production ~ area,
             coffee_data,
             xaxs = "i",
             yaxs = "i",
             las = 1,
             xlim = c(0, 10),
             ylim = c(0, 4),
             width = c(0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5),
             space = c(1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
             beside = TRUE,
             horiz = FALSE,
             xlab = "",
             ylab = "Sản lượng (triệu tấn)",
             col = terrain.colors(n = 10),
             border = "black")

text(b, label + 0.2, label, font = 2, col = "black")

title(main = "Top 10 quốc gia sản xuất cà phê trên thế giới năm 2021 ")

## ---- fig.width=7, fig.height=4-----------------------------------------------
rice_data <- extract_faostat(input_rds = df_1,
                             input_region = df_2,
                             input_item = "Rice")

rice_data |> subset(area == "Viet Nam") -> rice_vietnam

head(rice_vietnam)

library(ggplot2)

ggplot(data = rice_vietnam, mapping = aes(x = year, y = production / 1000000)) +
    geom_line(color = "blue", linewidth = 1.5) +
    scale_x_continuous(expand = c(0, 0), 
                     limits = c(1955, 2025), 
                     breaks = c(1961, 1970, 1980, 1990, 2000, 2010, 2021)) +
    scale_y_continuous(expand = c(0, 0), 
                     limits = c(0, 50), 
                     breaks = c(0, 10, 20, 30, 40, 50)) +
    labs(x = "Năm", 
         y = "Sản lượng (triệu tấn)", 
         title = "Tình hình sản xuất lúa gạo ở Việt Nam giai đoạn 1961–2021",
         subtitle = "Nguồn: FAOSTAT") + 
    theme_classic()

## ---- out.width = '100%'------------------------------------------------------
knitr::include_graphics("rice_sea.png")

## ---- out.width = '100%'------------------------------------------------------
knitr::include_graphics("coffee_boxplot.png")

