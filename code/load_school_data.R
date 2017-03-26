# Read files --------------------------------------------------------------
schools <- read_csv("./data/school_list.csv")
enrolments <- read_csv("./data/school_enrolment.csv")

# Combine -----------------------------------------------------------------
schools <- schools %>% 
  full_join(enrolments, by = c("school_code" = "School_Code")) %>% 
  mutate(name = coalesce(school_name, School_Name)) %>% 
  select(-c(date_extracted, school_name, School_Name))

# Properly parse columns --------------------------------------------------
# parse school list
for(col_name in c(
  "student_number",
  "indigenous_pct",
  "lbote_pct",
  "ICSEA_Value"
)){
  schools[ , col_name] <- parse_double(schools[[col_name]], na = "np")
}

# parse head count data, SP = NA
for(col_name in grep("20", names(schools), value = TRUE)){
  schools[ , col_name] <- parse_integer(schools[[col_name]], na = "SP")
}

# Filter only traditional schools -----------------------------------------
schools <- schools %>%
  filter(grepl("[0-9]", school_subtype))

# Save and clean up -------------------------------------------------------
rm(col_name, enrolments)
