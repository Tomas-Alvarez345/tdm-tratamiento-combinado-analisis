# tdm-tratamiento-combinado-analisis[README .md](https://github.com/user-attachments/files/26734995/README.md)
# Efectos del tratamiento combinado sobre la sintomatología depresiva en adultos con TDM

Proyecto de análisis de datos desarrollado en el marco de la **Diplomatura en Neurociencias Cognitivas** (Asociación Argentina de Ciencias del Comportamiento, 2025).

**Autores:** Tomás Leonardo Alvarez · Luján Fernandez  
**Tutor:** Ignacio Ferrelli  
**Herramientas:** R · tidyverse · ggplot2 · RStudio

---

## Descripción del proyecto

Este proyecto implementa el análisis estadístico de un diseño cuasi-experimental con medidas repetidas (pretest–postest) orientado a comparar la eficacia de dos modalidades de tratamiento para el Trastorno Depresivo Mayor (TDM):

- **Grupo control:** Terapia Cognitivo-Conductual de Beck (TCC) como monoterapia
- **Grupo experimental:** TCC + Inhibidor Selectivo de la Recaptación de Serotonina (ISRS)

El estudio evaluó tres variables dependientes a lo largo de 12 semanas de intervención:

1. **Sintomatología depresiva** — medida con HDRS (Hamilton Depression Rating Scale) y BDI-II (Beck Depression Inventory)
2. **Reactividad psicofisiológica** — registrada mediante Actividad Electrodérmica (EDA / SCR) durante una tarea de reconocimiento de emociones
3. **Procesamiento emocional** — evaluado con la Face Emotion Recognition Task (programada en PsychoPy), midiendo precisión (% aciertos) y tiempo de reacción (ms)

> Los datos utilizados son simulados con parámetros basados en la literatura empírica del área, lo que permite demostrar el pipeline analítico completo de forma reproducible.

---

## Estructura del repositorio

```
├── Analisis_de_datos_-_TDM.R   # Simulación de datos y visualizaciones exploratorias
├── Resultados.R                 # Construcción de tabla de resultados y estadísticos
└── README.md
```

---

## Variables y diseño

| Variable | Instrumento | Tipo |
|---|---|---|
| Sintomatología depresiva | HDRS + BDI-II | Clínica (heteroinforme + autoinforme) |
| Reactividad autonómica | EDA (µS) | Psicofisiológica |
| Procesamiento emocional | Face Emotion Recognition Task | Cognitivo-afectiva |

**Variable independiente:** Tipo de tratamiento (TCC / TCC+ISRS)  
**Diseño:** Cuasi-experimental, comparativo, con medidas repetidas (pre y post)  
**N:** 40 participantes adultos (18–60 años), 20 por grupo

---

## Análisis estadísticos implementados

- Estadísticos descriptivos (medias, desvíos estándar)
- Prueba de normalidad: **Shapiro-Wilk**
- Comparaciones intragrupales: **t de Student para muestras relacionadas** / Wilcoxon
- Comparaciones intergrupales: **t de Student para muestras independientes** / Mann-Whitney U
- **ANOVA de medidas repetidas** con factores intra-sujeto (tipo de estímulo emocional) e inter-sujeto (grupo de tratamiento)
- Tamaño del efecto: **d de Cohen**

### Resultados principales

| Comparación | Estadístico | p | d de Cohen |
|---|---|---|---|
| Reducción intragrupal HDRS (ambos grupos) | t(19) = 6.32 | < .001 | — |
| Reducción intragrupal BDI-II (ambos grupos) | t(19) = 7.10 | < .001 | — |
| Diferencia intergrupal en cambio sintomático | t(38) = 2.85 | .007 | 0.85 |
| Interacción Estímulo × Grupo (EDA) | F(2,76) = 3.58 | .03 | — |

El grupo combinado (TCC+ISRS) mostró una reducción significativamente mayor en la sintomatología depresiva y un incremento en la reactividad electrodérmica ante estímulos emocionales, interpretado como normalización de la sensibilidad autonómica.

---

## Visualizaciones

El archivo `Analisis_de_datos_-_TDM.R` genera los siguientes gráficos con **ggplot2**:

- Evolución de puntajes HDRS por grupo a lo largo del tiempo (gráfico de líneas individuales + media por grupo)
- Amplitud de SCR por tipo de emoción y grupo de tratamiento (boxplots con facetas Pre/Post)

---

## Requisitos

```r
install.packages(c("tidyverse"))
```

Desarrollado con **R 4.x** y **RStudio**.

---

## Marco teórico

El diseño se fundamenta en la evidencia sobre tratamiento combinado para TDM (Hollon et al., 2005; Cuijpers et al., 2013; Cipriani et al., 2018) y en la neurobiología de la depresión (hipótesis monoaminérgica, eje HPA, BDNF). La elección de la EDA como medida psicofisiológica complementaria se basa en estudios que documentan hiporreactividad autonómica en pacientes con TDM (Siegle et al., 2002; Boucsein, 2012).

---

## Contacto

**Tomás Leonardo Alvarez**  
Licenciado en Psicología (UBA) | Diplomatura en Neurociencias Cognitivas (AACC)  
[linkedin.com/in/lictomasalvarez](https://linkedin.com/in/lictomasalvarez) · tomasleoalvarez007@gmail.com
