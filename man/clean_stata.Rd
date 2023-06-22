\name{clean_stata}
\alias{clean_stata}
\title{Làm sạch file Stata (.dta) thành data frame}
\usage{
clean_stata(input_data, ...)
}

\arguments{
  \item{input_data}{ File Stata (.dta) }
  \item{...}{ Tham số này của lệnh haven::read_dta() }
}

\description{
Function này giúp import file Stata (.dta) vào trong R. Sau đó các cột có label sẽ được chuyển thành factor, cũng như làm sạch các thông tin liên quan đến Stata để ta có data frame sạch.

Báo lỗi function: tuhocr.com@gmail.com
}
\examples{
# Các bạn download các file Stata (.dta) example này về.
# https://www.principlesofeconometrics.com/stata.htm
# Thực hiện dòng lệnh. Ta thu được data frame sạch để phân tích dữ liệu.
data <- clean_stata("https://tuhocr.netlify.app/housing.dta")
head(data)
str(data)
}
