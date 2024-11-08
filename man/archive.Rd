\name{archive}
\alias{archive}
\title{Chia sẻ file hoặc folder qua Google Drive thuận tiện và bảo mật}
\usage{
archive(type)
}

\arguments{
  \item{type}{ Chọn kiểu chia sẻ `file` hoặc `folder` }
}

\description{
Function này giúp nén file hoặc folder với mật khẩu tự động khởi tạo hoặc nhập thủ công, sau đó tải lên Goole Drive và thu được dãy số mã hóa dùng để chia sẻ cá nhân. Để đọc được file thì ta cũng sử dụng function này để mở ra Shiny app, file sẽ được tải về ở thư mục working directory mặc định. Function hoạt động tốt trên Windows, chưa kiểm tra trên Linux và MacOS.

Báo lỗi function: tuhocr.com@gmail.com
}
\examples{
# archive(type = "file")
# archive(type = "folder")
}
