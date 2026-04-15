# =============================
# Resultados - TDM
# =============================

# Librerías
library(dplyr)
library(tidyr)

# Definir condiciones
grupos <- c("TCC", "TCC+ISRS")
tiempos <- c("Pre", "Post")
emociones <- c("Feliz", "Triste", "Ira", "Miedo", "Neutral")

# Datos clínicos (HDRS y BDI-II)
hdrs_means <- list(
  TCC = c(22, 16),
  "TCC+ISRS" = c(22, 12)
)
bdi_means <- list(
  TCC = c(28, 21),
  "TCC+ISRS" = c(28, 16)
)

hdrs_sds <- list(
  TCC = c(3, 2),
  "TCC+ISRS" = c(3, 2)
)
bdi_sds <- list(
  TCC = c(4, 3),
  "TCC+ISRS" = c(4, 3)
)

# Datos psicofisiológicos SCR (amplitud en µS)
scr_base <- c(
  Feliz = 0.35,
  Triste = 0.25,
  Ira = 0.30,
  Miedo = 0.40,
  Neutral = 0.20
)

# Función para asignar medias según grupo y tiempo
scr_mean <- function(grupo, tiempo, emocion) {
  base <- scr_base[emocion]
  if (grupo == "TCC" & tiempo == "Pre") {
    return(base)
  } else if (grupo == "TCC" & tiempo == "Post") {
    return(base + 0.05)
  } else if (grupo == "TCC+ISRS" & tiempo == "Pre") {
    return(base)
  } else {
    return(base + 0.15) # TCC+ISRS Post
  }
}

# -----------------------------
# Construir tabla de resultados
# -----------------------------
rows <- data.frame()

# HDRS y BDI
for (g in grupos) {
  for (i in 1:2) {
    t <- tiempos[i]
    rows <- rbind(rows, data.frame(
      Grupo = g, Tiempo = t, Medida = "HDRS",
      Media = hdrs_means[[g]][i], Desvio = hdrs_sds[[g]][i]
    ))
    rows <- rbind(rows, data.frame(
      Grupo = g, Tiempo = t, Medida = "BDI-II",
      Media = bdi_means[[g]][i], Desvio = bdi_sds[[g]][i]
    ))
  }
}

# SCR amplitudes
for (g in grupos) {
  for (t in tiempos) {
    for (e in emociones) {
      mean_val <- round(scr_mean(g, t, e), 2)
      sd_val <- 0.08
      rows <- rbind(rows, data.frame(
        Grupo = g, Tiempo = t, Medida = paste0("SCR_", e),
        Media = mean_val, Desvio = sd_val
      ))
    }
  }
}

# Tabla final
tabla_resultados <- rows
print(tabla_resultados)
