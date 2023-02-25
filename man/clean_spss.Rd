\name{clean_spss}
\alias{clean_spss}
\title{Làm sạch file SPSS (.sav) thành data frame}
\usage{
clean_spss(input_data, ...)
}

\arguments{
  \item{input_data}{ File SPSS (.sav) }
  \item{...}{ Tham số này của lệnh haven::read_sav }
}

\description{
Function này giúp import file SPSS (.sav) vào trong R. Sau đó các cột có label sẽ được chuyển thành factor, cũng như làm sạch các thông tin liên quan đến SPSS để ta có data frame sạch.

Báo lỗi function: tuhocr.com@gmail.com
}
\examples{
# Các bạn download các file SPSS (.sav) example này về.
# http://spss.allenandunwin.com.s3-website-ap-southeast-2.amazonaws.com/data-files.html
# Thực hiện dòng lệnh. Ta thu được data frame sạch để phân tích dữ liệu.
data <- clean_spss("https://tuhocr.netlify.app/experim.sav")
head(data[, 1:6])
str(data)
}
