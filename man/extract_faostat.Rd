\name{extract_faostat}
\alias{extract_faostat}
\title{Trích xuất dữ liệu nông sản từ FAOSTAT}
\usage{
extract_faostat(input_rds, input_region, input_item)
}

\arguments{
  \item{input_rds}{ File data frame `QCL` chứa dữ liệu nông sản của FAOSTAT}
  \item{input_region}{ File data frame country region của FAOSTAT}
  \item{input_item}{ Tên loại nông sản cần trích xuất }
}

\description{
Function này giúp trích xuất dữ liệu nông sản từ FAOSTAT theo loại nông sản cây trồng (những item có chứa thông tin `production` và `area_harvested` trong dataset).

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
# coffee_data <- extract_faostat(input_rds = df_1,
# input_region = df_2,
# input_item = "Coffee, green")
# head(coffee_data)
#str(coffee_data)
}
