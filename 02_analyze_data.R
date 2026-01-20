##########################
# Analyze Data
##########################


# Summarize by State ------------------------------------------------------

acs_state <- acs_df %>%
  group_by(state) %>%
  summarize(
    commute = weighted.mean(commute_mean, pop_commute_total),
    hh_size = weighted.mean(hh_size_avg, hh_total),
    pop_educ_hs = weighted.mean(pop_educ_hs, pop_educ_total),
    pop_educ_ba = weighted.mean(pop_educ_ba, pop_educ_total),
    pop_disability = weighted.mean(pop_disability_with, pop_disability_total),
    pop_emp_private = weighted.mean(pop_emp_class_private, pop_emp_class_total),
    pop_emp_govt = weighted.mean(pop_emp_class_govt, pop_emp_class_total),
    pop_emp_self = weighted.mean(pop_emp_class_self, pop_emp_class_total),
    pop_emp_family = weighted.mean(pop_emp_class_family, pop_emp_class_total),
    income_hh = weighted.mean(income_med_hh, hh_total),
    housing_owned_val = weighted.mean(housing_owned_med_value, housing_owned_total),
    housing_rent_val = weighted.mean(housing_med_rent, housing_rent_total)
    ) %>%
  ungroup() %>%
  arrange(desc(commute))

# Run Univariate Regressions ----------------------------------------------

# ##Identify all variables to include in regression
acs_reg_vars <- acs_df %>%
  select(-c(id, name, state, commute_mean, state, matches("total"))) %>%
  names()

### Create dataset of nested regressions

acs_reg_uni <- tibble(var = acs_reg_vars) %>%
  mutate(model = map(var, ~lm(formula(paste("commute_mean ~ ", .x)),
                              data = acs_df)),
         coeff = map_dbl(model, ~coef(.x)[2]),
         p_val = map_dbl(model, ~summary(.x)$coefficients[2,4]),
         p_signif = stars.pval(p_val))

# Remove model to make this table easy to print
acs_reg_uni_tbl <- acs_reg_uni %>%
  select(-model) %>%
  arrange(p_val)

# Identify which variables are significant
acs_uni_signif_vars <- acs_reg_uni %>%
  filter(p_signif != " ") %$%
  unique(var)

### Run multivariate regression

# Create formula using only variables found to be significant
acs_reg_form <- paste0(
  "commute_mean ~ ",
  paste(acs_uni_signif_vars, collapse = " + ")
)

# Run multivariate regression with all univariate significant variables
acs_reg <- lm(formula(acs_reg_form), data = acs_df)

# Perform stepwise selection to reduce this
acs_reg_sparse <- step(acs_reg, trace = 0)

