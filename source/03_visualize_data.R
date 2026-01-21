##########################
# Visualize Data
##########################


# Filter Data to Analysis Variables ---------------------------------------

acs_analysis <- acs_df %>%
  select(name, id, state, commute_mean, all_of(acs_reg_vars))

# Scatterplots ------------------------------------------------------------

# Make facet-wrapped scatterplots of all variables in analysis with commute time
acs_scatter <- acs_analysis %>%
  pivot_longer(-c(name, id, state, commute_mean), names_to = "var_name") %>%
  ggplot(aes(x = value, y = commute_mean, color = var_name)) +
  geom_point(alpha = 0.5) +
  facet_wrap(~var_name, scales = "free_x") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  guides(color = "none") +
  labs(x = "Variable", y = "Commute Time (Minutes)")

# Correlation Plot --------------------------------------------------------

# Make a correlation plot of all predictors
acs_corr <- acs_analysis %>%
  select(-c(name, id, state, commute_mean)) %>%
  as.matrix() %>%
  cor()

