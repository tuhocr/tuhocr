filter_faostat <- function(item_filter,
                           data_rds,
                           data_region,
                           rank_filter = "all",
                           year_filter = "all") {

    requireNamespace("stats", quietly = TRUE)

    requireNamespace("dplyr", quietly = TRUE)

    country_1 <- extract_faostat(input_item = item_filter,
                                 input_rds = data_rds,
                                 input_region = data_region)


    if(all(rank_filter %in% "all")) {

        rank_filter <- 1:500

    } else { rank_filter }

    if(all(year_filter %in% "all")) {

        year_filter <- 1900:2080

    } else { year_filter }



    #######################

    country_1 -> country_2

    filter_ok <- data.frame()

    for(i in 1:length(year_filter)){

        country_2 |> subset(year %in% year_filter[i]) -> country_2_2021

        row.names(country_2_2021) <- NULL

        country_2_2021$area <- as.character(country_2_2021$area)

        country_2_2021$area <- stats::reorder(country_2_2021$area, country_2_2021$production)

        country_2_2021 <- country_2_2021 |> dplyr::arrange(desc(year), desc(area), item, production, area_harvested)

        ###

        country_2_2021 -> country_3

        country_3[country_3$area %in% unique(country_3$area)[rank_filter], ] -> country_4

        country_4$rank <- row.names(country_4)

        country_4[, c(7, 1:6)] -> final_filter

        ###

        final_filter <- final_filter |> dplyr::arrange(desc(year), desc(area), item, production, area_harvested)

        filter_ok <- rbind(final_filter, filter_ok)

    }

    return(filter_ok)

}
