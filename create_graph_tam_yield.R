####LOADING PACKAGES AND READING IN FILE LISTS####
# loading required packages
pkgs <-
  c(
    "renv",
    "readxl",
    "lubridate",
    "tidyr",
    "dplyr",
    "readr",
    "forcats",
    "ggplot2",
    "ggthemes",
    "svglite"
  )

# installs missing packages
nu_pkgs <- pkgs[!(pkgs %in% installed.packages()[, "Package"])]
if (length(nu_pkgs))
  install.packages(nu_pkgs)

# loading required packages
lapply(pkgs, library, character.only = TRUE)
rm(pkgs, nu_pkgs)

df <-
  read_csv("clean_tam_yield_datasheet.csv",
           col_types = c("ff?????fff?fD"))
ggplot(data = df,
       mapping = aes(plant, tam_ct, fill = plant)) +
  ggtitle(
    substitute(
      ~ italic(tam) ~ 'reared from' ~ italic(dcit) ~ 'colonies with different hosts, 2021-2022',
      list(tam = 'T. radiata', dcit = 'D. citri')
    )
  ) +
  theme_tufte(base_size = 15) +
  theme(
    legend.position = "none",
    axis.title.x = element_blank(),
    axis.title.y = element_blank()
  ) +
  geom_boxplot(notch = T) +
  geom_violin() +
  coord_flip(ylim = c(0, 1250))
# annotate(
#   geom = "text",
#   size = 15,
#   x = 2,
#   y = 100,
#   label = "***",
#   color = "black")

# saving the file
ggsave(
  'tam_mixed_hosts.svg',
  plot = last_plot(),
  width = 16,
  height = 9,
  scale = 1,
)