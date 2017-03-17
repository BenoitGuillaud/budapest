## sales_data_prep.R
## Goal: prepare the dataset: clean and recode the variables 


# Set case identifier
rownames(sales) <- sales$listing
sales <- dplyr::select(sales,-listing)

# Find duplicates against features selected simultaneously
feat <- c(2,3,4,7,10,15,16) # price, area, rooms, district, floor, lat, long
dupl <- duplicated(sales[,feat])
sales = subset(sales,!dupl)

# Remove spurious data
sales <- dplyr::filter(sales, district=='5. ker'|district=='6. ker'|district=='7. ker')

# Clean the "nincs megadva"
sales <- within(sales, {
  condition[condition == "nincs megadva"] <- NA
  lift[lift == "nincs megadva"] <- NA
  heating[heating == "nincs megadva"] <- NA
  view[view == "nincs megadva"] <- NA
  orient[orient == "nincs megadva"] <- NA
  floor[floor == "nincs megadva"] <- NA
  storeys[storeys == "nincs megadva"] <- NA
  parking[parking == "nincs megadva"] <- NA
  aircon[aircon == "nincs megadva"] <- NA
  ceiling[ceiling == "nincs megadva"] <- NA
  utility[utility == "nincs megadva"] <- NA
  bathtoil[bathtoil == "nincs megadva"] <- NA
  garcess[garcess == "nincs megadva"] <- NA
})

# Recode the categories of the factor variable "varos":
sales <- within(sales, {
  # using simple assignments
  varos[varos == ""] <- NA
  varos[varos == "Terézváros"] <- NA
  varos[varos == "Erzsébetváros"] <- NA
})

# Drop unused levels
sales <- droplevels(sales)