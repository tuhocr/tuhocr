
<!-- README.md is generated from README.Rmd. Please edit that file -->

# tuhocr <img src="man/figures/logo.png" align="right" alt="" width="120" />

<!-- badges: start -->

[![R-CMD-check](https://github.com/tuhocr/tuhocr/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/tuhocr/tuhocr/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

Package này tập hợp các function giúp giải quyết công việc xử lý dữ liệu
thường ngày. Để biết cách viết function, thân mời bạn tham gia khóa học
R ở **`www.tuhocr.com`** giúp trang bị kiến thức R vững chắc.

## Hướng dẫn cài đặt

Cài đặt package `tuhocr` theo cách sau:

``` r
# install.packages("devtools")
devtools::install_github("tuhocr/tuhocr", force = TRUE)
```

Trước mắt trong package này có function `clean_spss()` giúp import file
SPSS (.sav) vào trong R. Sau đó các cột có label sẽ được chuyển thành
factor, cũng như làm sạch các thông tin liên quan đến SPSS để ta có data
frame sạch.

``` r
# Các bạn download các file SPSS (.sav) example này về.
# http://spss.allenandunwin.com.s3-website-ap-southeast-2.amazonaws.com/data-files.html
# Thực hiện dòng lệnh. Ta thu được data frame sạch để phân tích dữ liệu.
```

``` r
library(tuhocr)
data <- clean_spss("https://tuhocr.netlify.app/experim.sav")
head(data[, 1:6])
#>   id  sex age               group fost1 confid1
#> 1  4 male  23 confidence building    50      15
#> 2 10 male  21 confidence building    47      14
#> 3  9 male  25        maths skills    44      12
#> 4  3 male  30        maths skills    47      11
#> 5 12 male  45 confidence building    46      16
#> 6 11 male  22        maths skills    39      13
str(data)
#> 'data.frame':    30 obs. of  18 variables:
#>  $ id      : num  4 10 9 3 12 11 6 5 8 13 ...
#>  $ sex     : Factor w/ 2 levels "male","female": 1 1 1 1 1 1 1 1 1 1 ...
#>  $ age     : num  23 21 25 30 45 22 22 26 23 21 ...
#>  $ group   : Factor w/ 2 levels "maths skills",..: 2 2 1 1 2 1 2 1 2 1 ...
#>  $ fost1   : num  50 47 44 47 46 39 32 44 40 47 ...
#>  $ confid1 : num  15 14 12 11 16 13 21 17 22 20 ...
#>  $ depress1: num  44 42 40 43 44 43 37 46 37 50 ...
#>  $ fost2   : num  48 45 39 42 45 40 33 37 40 45 ...
#>  $ confid2 : num  16 15 18 16 16 20 22 20 23 25 ...
#>  $ depress2: num  44 42 40 43 45 42 36 47 37 48 ...
#>  $ fost3   : num  45 44 36 41 43 39 32 32 40 46 ...
#>  $ confid3 : num  14 18 19 20 20 22 23 26 26 27 ...
#>  $ depress3: num  40 40 38 43 43 38 35 42 35 46 ...
#>  $ exam    : num  52 55 58 60 58 62 59 70 60 70 ...
#>  $ mah_1   : num  0.57 1.659 3.54 2.454 0.944 ...
#>  $ DepT1gp2: Factor w/ 2 levels "not depressed",..: 1 1 1 1 1 1 1 2 1 2 ...
#>  $ DepT2Gp2: Factor w/ 2 levels "not depressed",..: 1 1 1 1 2 1 1 2 1 2 ...
#>  $ DepT3gp2: Factor w/ 2 levels "not depressed",..: 1 1 1 1 1 1 1 1 1 2 ...
```

## Làm bài tập R

Mình định kỳ có upload các bài tập củng cố kiến thức R ở chuyên mục [Bài
Tập R](https://www.tuhocr.com/r-courses/code-base-for-r). Các file này
chạy online trên server RStudio (Shiny app) tuy nhiên đôi khi sẽ bị
chậm, vì vậy bạn có thể render local trên máy tính bằng dòng lệnh
`learnr::run_tutorial(name = "hack1", package = "tuhocr")` với `hack1`
là codename tương ứng của từng bài tập.

## Liên hệ

``` r
Email: tuhocr.com@gmail.com

Facebook: www.facebook.com/tuhocr

Fanpage: www.facebook.com/Huong.Dan.Tu.Hoc.R

Group: www.facebook.com/groups/tuhocr
```
