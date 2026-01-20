
# Load Data downloaded from Census website -------------------------------

### Read data file
acs_df0 <- read_csv(here("data",
                         "ACSSPP1Y2024.S0201_2026-01-20T132052",
                         "ACSSPP1Y2024.S0201-Data.csv"))

### Read data dictionary file
acs_nms0 <- read_csv(here("data",
                          "ACSSPP1Y2024.S0201_2026-01-20T132052",
                          "ACSSPP1Y2024.S0201-Column-Metadata.csv"))

### Select specific fields in data file
acs_df <- acs_df0 %>%
  select(
    id = GEO_ID,
    name = NAME,
    pop_total = S0201_001E,
    hh_total = S0201_044E,
    hh_size_avg = S0201_058E,
    pop_educ_total = S0201_090E,
    pop_educ_hs = S0201_096E,
    pop_educ_ba = S0201_099E,
    pop_disability_total = S0201_111E,
    pop_disability_with = S0201_112E,
    pop_commute_total = S0201_168E,
    commute_mean = S0201_175E,
    pop_emp_class_total = S0201_208E,
    pop_emp_class_private = S0201_209E,
    pop_emp_class_govt = S0201_210E,
    pop_emp_class_self = S0201_211E,
    pop_emp_class_family = S0201_212E,
    income_med_hh = S0201_214E,
    housing_owned_total = S0201_297E,
    housing_owned_med_value = S0201_298E,
    housing_rent_total = S0201_304E,
    housing_med_rent = S0201_305E
  )

### Remove first row of names
acs_df %<>%
  slice(-1)

### Convert column types
acs_df %<>%
  mutate(across(-c(id, name), as.numeric)) %>%
  mutate(state = str_match(name, "(.*)\\, (.*)")[,3], .after = name)

save(acs_df, file = here("data", "acs_clean.rda"))

