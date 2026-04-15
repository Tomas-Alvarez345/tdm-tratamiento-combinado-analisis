# =============================
# Análisis de datos - TDM
# =============================

# Librerías
library(tidyverse)

set.seed(123)  # para reproducibilidad

# -----------------------------
# 1. Parámetros de la muestra
# -----------------------------
n <- 40
grupo <- rep(c("TCC", "TCC+ISRS"), each = n/2)
id <- 1:n

# -----------------------------
# 2. Escalas clínicas (HDRS y BDI-II)
# -----------------------------
# HDRS baseline (ambos grupos ~22)
HDRS_pre <- rnorm(n, mean = 22, sd = 3)

# HDRS post (mejora mayor en combinado)
HDRS_post <- ifelse(grupo == "TCC",
                    HDRS_pre - rnorm(n, mean = 6, sd = 2),
                    HDRS_pre - rnorm(n, mean = 10, sd = 2))

# BDI-II baseline (~28)
BDI_pre <- rnorm(n, mean = 28, sd = 4)

# BDI-II post
BDI_post <- ifelse(grupo == "TCC",
                   BDI_pre - rnorm(n, mean = 7, sd = 3),
                   BDI_pre - rnorm(n, mean = 12, sd = 3))

# -----------------------------
# 3. Medidas psicofisiológicas (EDA)
# -----------------------------
emociones <- c("Feliz", "Triste", "Ira", "Miedo", "Neutral")

# Función para simular amplitud y número de SCR
sim_EDA <- function(grupo, tiempo, emocion) {
  # valores base inspirados en la literatura (µS)
  base_amp <- case_when(
    emocion == "Feliz"   ~ 0.35,
    emocion == "Triste"  ~ 0.25,
    emocion == "Ira"     ~ 0.30,
    emocion == "Miedo"   ~ 0.40,
    emocion == "Neutral" ~ 0.20
  )
  
  # efecto grupo/tiempo inspirado en Pineau (2022):
  # más reactividad en combinados post
  amp <- ifelse(grupo == "TCC" & tiempo == "Pre", rnorm(1, base_amp, 0.08),
                ifelse(grupo == "TCC" & tiempo == "Post", rnorm(1, base_amp+0.05, 0.08),
                       ifelse(grupo == "TCC+ISRS" & tiempo == "Pre", rnorm(1, base_amp, 0.08),
                              rnorm(1, base_amp+0.15, 0.08))))
  
  count <- ifelse(amp < 0.25, rpois(1, 4), rpois(1, 6))
  
  return(c(amp, count))
}

# Expandir dataset
df_EDA <- expand.grid(id=id, grupo=unique(grupo),
                      tiempo=c("Pre","Post"),
                      emocion=emociones)

# Simular
df_EDA <- df_EDA %>%
  rowwise() %>%
  mutate(vals = list(sim_EDA(grupo, tiempo, emocion))) %>%
  unnest_wider(vals, names_sep = "_") %>%
  rename(SCR_amplitude = vals_1,
         SCR_count = vals_2)

# -----------------------------
# 4. Juntar todo
# -----------------------------
df_clinico <- data.frame(id, grupo, HDRS_pre, HDRS_post, BDI_pre, BDI_post)

# Mostrar primeras filas
head(df_clinico)
head(df_EDA)

# -----------------------------
# 5. Visualización rápida
# -----------------------------
# Evolución HDRS
df_clinico %>%
  pivot_longer(cols = c(HDRS_pre, HDRS_post),
               names_to = "tiempo", values_to = "HDRS") %>%
  mutate(tiempo = ifelse(tiempo=="HDRS_pre","Pre","Post")) %>%
  ggplot(aes(x=tiempo, y=HDRS, group=id, color=grupo)) +
  geom_line(alpha=0.5) +
  stat_summary(fun=mean, geom="line", aes(group=grupo), size=1.5) +
  theme_minimal() +
  labs(title="Evolución HDRS por grupo", y="HDRS")

# SCR amplitudes por emoción
df_EDA %>%
  ggplot(aes(x=emocion, y=SCR_amplitude, fill=grupo)) +
  geom_boxplot() +
  facet_wrap(~tiempo) +
  theme_minimal() +
  labs(title="SCR amplitud según emoción y grupo",
       y="Amplitud (µS)")
