\name{filter_faostat}
\alias{filter_faostat}
\title{Lọc dữ liệu nông sản từ FAOSTAT}
\usage{
filter_faostat(item_filter, data_rds, data_region,
rank_filter = "all", year_filter = "all")
}

\arguments{
  \item{data_rds}{ File data frame `QCL` chứa dữ liệu nông sản của FAOSTAT}
  \item{data_region}{ File data frame country region của FAOSTAT}
  \item{item_filter}{ Tên loại nông sản cần trích xuất }
  \item{rank_filter}{ Thứ hạng quốc gia sản xuất nông sản }
  \item{year_filter}{ Năm sản xuất nông sản }
}

\description{
Function này giúp lọc dữ liệu nông sản từ FAOSTAT theo loại nông sản cây trồng (những item có chứa thông tin `production` và `area_harvested` trong dataset).

Báo lỗi function: tuhocr.com@gmail.com
}
\examples{
# Sử dụng package FAOSTAT để download dataset về máy tính.
# Ở đây là dataset ở thời điểm 3/2023 dùng làm ví dụ.
# crop_production_all_data <- system.file("extdata",
# "crop_production_all_data.rds", package = "tuhocr")
# df_1 <- readRDS(crop_production_all_data)
# FAOSTAT_data_2023 <- system.file("extdata",
# "FAOSTAT_data_3-21-2023.csv", package = "tuhocr")
# df_2 <- read.csv(FAOSTAT_data_2023)
# Thực hiện dòng lệnh sẽ thu được danh sách các quốc gia
# sản xuất cà phê trên thế giới được sắp xếp theo năng suất và năm.
# coffee_data <- filter_faostat(data_rds = df_1,
# data_region = df_2,
# item_filter = "Coffee, green",
# rank_filter = 1:10,
# year_filter = 2021)
# head(coffee_data)
#str(coffee_data)
}
