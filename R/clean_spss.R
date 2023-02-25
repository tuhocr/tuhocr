clean_spss <- function(input_data, ...) {

    requireNamespace("haven", quietly = TRUE)

    spss_file <- haven::read_sav(input_data, ...)

    data_ok <- as.data.frame(spss_file)

    # extract label
    sapply(data_ok, class) -> class_ok
    vi_tri_cot <- grep(pattern = "labelled", class_ok, fixed = TRUE)

    # check value not labelled

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

        print("\u0046\u0069\u006c\u0065\u0020\u0053\u0050\u0053\u0053\u0020\u0028\u002e\u0073\u0061\u0076\u0029\u0020\u006e\u00e0\u0079\u0020\u0063\u00f3\u0020\u006e\u0068\u1eef\u006e\u0067\u0020\u0063\u1ed9\u0074\u0020\u0073\u0061\u0075\u0020\u0063\u0068\u1ee9\u0061\u0020\u006e\u0068\u1eef\u006e\u0067\u0020\u0067\u0069\u00e1\u0020\u0074\u0072\u1ecb\u0020\u006b\u0068\u00f4\u006e\u0067\u0020\u0063\u00f3\u0020\u006c\u0061\u0062\u0065\u006c\u002e\u0020\u0042\u1ea1\u006e\u0020\u006b\u0069\u1ec3\u006d\u0020\u0074\u0072\u0061\u0020\u006c\u1ea1\u0069\u002e")

        return(check_6)
    }

    # convert label
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

    # find others
    sapply(data_ok, class) -> class_spss
    vi_tri_cot_spss <- setdiff(seq_along(data_ok), grep(pattern = "factor", class_spss))

    # clean spss
    for (j in vi_tri_cot_spss) {
        attributes(data_ok[, j]) <- NULL
    }

    return(data_ok)
}


