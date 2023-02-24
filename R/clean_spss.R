# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

clean_spss <- function(input_data, ...) {
    spss_file <- haven::read_sav(input_data, ...)
    data_ok <- as.data.frame(spss_file)
    
    # lấy tên những cột có label
    sapply(data_ok, class) -> class_ok
    vi_tri_cot <- grep(pattern = "labelled", class_ok, fixed = TRUE)
    
    # check xem có những cột nào dùng giá trị không có trong label
    
    check_3 <- vector("list", length(data_ok))
    names(check_3) <- names(data_ok)
    
    for (bbb in vi_tri_cot) {
        
        ok <- setdiff(unclass(data_ok[, bbb]), attributes(data_ok[, bbb])$labels)
        
        if(length(ok) == 0){
            ok <- 0
        } else {
            ok
        }
        
        check_3[[bbb]] <- ok
        
    }
    
    check_4 <- check_3[lengths(check_3) != 0]
    
    check_5 <- lapply(check_4, function(x) x[which(x != 0)])
    
    check_6 <- check_5[sapply(check_5, length) > 0]
    
    if(length(check_6) > 0){
        
        print("File SPSS (.sav) này có những cột sau chứa những giá trị không có label. Bạn kiểm tra lại.")
        
        return(check_6) 
    }
    
    # convert các cột label
    for (i in vi_tri_cot) {
        if (length(setdiff(attributes(data_ok[, i])$labels, unclass(data_ok[, i]))) != 0) {
            setdiff(attributes(data_ok[, i])$labels, unclass(data_ok[, i])) -> vec_1
            data_ok[, i] <- factor(data_ok[, i],
                                   labels = names(attributes(data_ok[, i])$labels)[-vec_1]
            )
        } else {
            data_ok[, i] <- factor(data_ok[, i],
                                   labels = names(attributes(data_ok[, i])$labels)
            )
        }
    }
    
    # chọn những cột còn lại
    sapply(data_ok, class) -> class_spss
    vi_tri_cot_spss <- setdiff(seq_along(data_ok), grep(pattern = "factor", class_spss))
    
    # làm sạch chữ spss
    for (j in vi_tri_cot_spss) {
        attributes(data_ok[, j]) <- NULL
    }
    
    return(data_ok)
}


