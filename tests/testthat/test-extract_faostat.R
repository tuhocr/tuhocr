extract_faostat <- function(input_rds, input_region, input_item){

    requireNamespace("dplyr", quietly = TRUE)

    #### SUBSET CROP ITEM ####

    crop_full <- input_rds

    crop_full_clean <- crop_full[ , c(3, 6, 8, 10, 11, 12)]

    rice_all <- subset(crop_full_clean, item == input_item)

    ## CLEAN COUNTRY REGION

    input_region -> country_group

    region_name <- unique(country_group$Country.Group)

    country_name <- unique(rice_all$area)

    country_1 <- country_name[!(country_name %in% region_name)]

    rice_country <- rice_all[rice_all$area %in% country_1, ]

    ## ARRANGE

    rice_country <- rice_country |> dplyr::arrange(area,
                                                   desc(year),
                                                   desc(element),
                                                   desc(value)
    )

    #### CHECK DATA AND CLEAN ####

    ## FIND COUNTRY ZERO IN PRODUCTION AND AREA HARVESTED

    check_1 <- tapply(rice_country$value,
                      list(rice_country$area, rice_country$element),
                      FUN = sum, na.rm = TRUE)

    check_2 <- as.data.frame(check_1)

    check_2$area <- row.names(check_2)

    check_2[, c("area", "production", "area_harvested")] -> check_2

    row.names(check_2) <- NULL

    check_2 |> dplyr::arrange(area_harvested, production, area) -> check_3

    country_check <- check_3 |> subset(area_harvested == 0 & production == 0)

    ## SUBSET COUNTRY HAVE PRODUCTION AND AREA HARVESTED

    country_name_1 <- unique(rice_country$area)

    country_2 <- country_name_1[!(country_name_1 %in% country_check$area)]

    rice_country_2 <- rice_country[rice_country$area %in% country_2, ]

    #### RESHAPE DATA ####

    rice_country_2 <- rice_country_2 |> subset(select = -unit)

    rice_ready <- stats::reshape(data = rice_country_2,
                                 idvar = c("year", "area"),
                                 v.names = "value",
                                 timevar = "element",
                                 direction = "wide")

    ## REMOVE YIELD

    grep(pattern = "value.", names(rice_ready), value = TRUE) -> change_order_1

    change_order_1[order(change_order_1)] -> change_order_2

    setdiff(names(rice_ready), change_order_2) -> keep_1

    rice_ready[, c(keep_1, change_order_2)] -> rice_ready

    rice_ready <- rice_ready[, c("area", "item", "year", "value.production", "value.area_harvested")]

    ## REMOVE MISSING VALUES

    rice_ready <-  stats::na.omit(rice_ready)

    names(rice_ready)[names(rice_ready) == "value.production"] <- "production"
    names(rice_ready)[names(rice_ready) == "value.area_harvested"] <- "area_harvested"

    row.names(rice_ready) <- NULL


    ## RENAME DATASET

    rice_ready -> item_ready

    ## CALCULATE YIELD, IF NAN OR INF IN RESULT, SET IT ZERO

    item_ready$yield <- round(item_ready$production / item_ready$area_harvested, digits = 2)

    item_ready$yield[is.nan(item_ready$yield)] <- 0

    item_ready$yield[is.infinite(item_ready$yield)] <- 0

    item_ready$area <- stats::reorder(item_ready$area, item_ready$production)

    item_ready <- item_ready |> dplyr::arrange(desc(area),
                                               desc(year),
                                               desc(production),
                                               desc(area_harvested),
                                               desc(yield))

    return(item_ready)

}
