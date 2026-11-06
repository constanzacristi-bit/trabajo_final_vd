# Proyecto: Brechas de género CASEN 2024
# Script 03: Visualizaciones

# 1. Cargar paquetes
library(ggplot2)
library(dplyr)

# 2. Cargar indicadores consolidados
participacion_nacional <- read.csv(
  "datos/02_datos_consolidados/participacion_nacional.csv"
)

participacion_zona <- read.csv(
  "datos/02_datos_consolidados/participacion_zona.csv"
)

cuidados_zona <- read.csv(
  "datos/02_datos_consolidados/cuidados_zona.csv"
)

tipos_cuidado <- read.csv(
  "datos/02_datos_consolidados/tipos_cuidado.csv"
)

# 3. Gráfico 1: Brecha nacional de participación laboral

datos_g1 <- participacion_nacional %>%
  mutate(
    sexo_grupo = factor(
      sexo_grupo,
      levels = c("Mujeres", "Hombres")
    )
  )

grafico_1 <- ggplot(
  datos_g1,
  aes(x = tasa, y = sexo_grupo, color = sexo_grupo)
) +
  # Intervalos de confianza del 95%
  geom_errorbar(
    aes(xmin = tasa_low, xmax = tasa_upp),
    orientation = "y",
    width = 0.12,
    linewidth = 0.7
  ) +

  # Puntos
  geom_point(size = 4) +

  # Etiquetas
  geom_text(
    aes(label = paste0(round(tasa, 1), "%")),
    hjust = -0.5,
    color = "black",
    size = 4.2
  ) +

  scale_x_continuous(
    limits = c(0, 85),
    breaks = seq(0, 80, 20),
    labels = function(x) paste0(x, "%")
  ) +

  scale_color_manual(
    values = c(
      "Hombres" = "#347CA5",
      "Mujeres" = "#C15C86"
    )
  ) +

  labs(
    title = "La participación laboral masculina supera a la femenina",
    subtitle = "Brecha nacional: 19,6 puntos porcentuales",
    x = "Tasa de participación laboral (%)",
    y = NULL,
    caption = paste(
      "Chile, población de 15 años o más.",
      "Fuente: CASEN 2024. Elaboración propia.",
      "Intervalos de confianza del 95%."
    )
  ) +

  theme_minimal(base_size = 13) +
  theme(
    legend.position = "none",
    panel.grid.major.y = element_blank(),
    panel.grid.minor = element_blank(),
    plot.title = element_text(face = "bold"),
    plot.caption = element_text(
      size = 9,
      hjust = 0
    )
  )

# Mostrar gráfico
grafico_1

# Guardar gráfico 1

ggsave(
  filename = "resultados/01_graficos/grafico_01_participacion_nacional.png",
  plot = grafico_1,
  width = 9,
  height = 3.5,
  dpi = 300,
  bg = "white"
)

# 4. Gráfico 2: Participación laboral por sexo y zona
# Preparar los datos para conectar los puntos
brechas_zona <- participacion_zona %>%
  select(zona, sexo_grupo, tasa) %>%
  tidyr::pivot_wider(
    names_from = sexo_grupo,
    values_from = tasa
  ) %>%
  mutate(
    brecha = Hombres - Mujeres
  )

# Ordenar las zonas para destacar la mayor brecha
participacion_zona$zona <- factor(
  participacion_zona$zona,
  levels = c("Urbana", "Rural")
)

brechas_zona$zona <- factor(
  brechas_zona$zona,
  levels = c("Urbana", "Rural")
)

# Crear el gráfico
grafico_2 <- ggplot() +

  # Línea que representa la brecha
  geom_segment(
    data = brechas_zona,
    aes(
      x = Mujeres,
      xend = Hombres,
      y = zona,
      yend = zona
    ),
    color = "grey65",
    linewidth = 1.5
  ) +

  # Puntos de participación por sexo
  geom_point(
    data = participacion_zona,
    aes(
      x = tasa,
      y = zona,
      color = sexo_grupo
    ),
    size = 4
  ) +

  # Etiquetas con las tasas de participación
  geom_text(
    data = participacion_zona,
    aes(
      x = tasa,
      y = zona,
      label = paste0(sprintf("%.1f", tasa), "%"),
      color = sexo_grupo
    ),
    vjust = 2,
    size = 3.7,
    show.legend = FALSE
  ) +

  # Destacar la brecha en puntos porcentuales
  geom_text(
    data = brechas_zona,
    aes(
      x = (Mujeres + Hombres) / 2,
      y = zona,
      label = paste0(round(brecha, 1), " pp")
    ),
    vjust = -1.2,
    size = 4
  ) +

  scale_x_continuous(
    limits = c(0, 85),
    breaks = seq(0, 80, 20),
    labels = function(x) paste0(x, "%")
  ) +

  scale_color_manual(
    values = c(
      "Hombres" = "#347CA5",
      "Mujeres" = "#C15C86"
    )
  ) +

  labs(
    title = "La brecha de género en participación laboral es mayor en zonas rurales",
    subtitle = "Diferencia entre las tasas de hombres y mujeres, CASEN 2024",
    x = "Tasa de participación laboral (%)",
    y = NULL,
    color = "Sexo",
    caption = paste(
      "Chile, población de 15 años o más.",
      "Fuente: CASEN 2024. Elaboración propia."
    )
  ) +

  theme_minimal(base_size = 13) +
  theme(
    panel.grid.major.y = element_blank(),
    panel.grid.minor = element_blank(),
    legend.position = "bottom",
    plot.title = element_text(face = "bold")
  )

# Mostrar gráfico
grafico_2

# 5. Guardar gráfico 2

ggsave(
  filename = "resultados/01_graficos/grafico_02_participacion_urbano_rural.png",
  plot = grafico_2,
  width = 9,
  height = 4,
  dpi = 300,
  bg = "white"
)

# 6. Gráfico 3: Cuidados y quehaceres domésticos

datos_g3 <- cuidados_zona %>%
  mutate(
    zona = factor(zona, levels = c("Urbana", "Rural")),
    sexo_grupo = factor(
      sexo_grupo,
      levels = c("Hombres", "Mujeres")
    )
  )

grafico_3 <- ggplot(
  datos_g3,
  aes(
    x = porcentaje,
    y = zona,
    fill = sexo_grupo
  )
) +
  # Barras horizontales
  geom_col(
    position = position_dodge(width = 0.7),
    width = 0.6
  ) +

  # Intervalos de confianza
  geom_errorbar(
    aes(
      xmin = porcentaje_low,
      xmax = porcentaje_upp
    ),
    orientation = "y",
    position = position_dodge(width = 0.7),
    width = 0.12,
    linewidth = 0.5,
    color = "grey25"
  ) +

  # Etiquetas a la derecha de los intervalos
  geom_text(
    aes(
      x = porcentaje_upp + 1,
      label = paste0(
        sprintf("%.1f", porcentaje), "%"
      )
    ),
    position = position_dodge(width = 0.7),
    hjust = 0,
    size = 3.8,
    inherit.aes = TRUE
  ) +

  scale_x_continuous(
    limits = c(0, 50),
    breaks = seq(0, 50, 10),
    labels = function(x) paste0(x, "%")
  ) +

  scale_fill_manual(
    values = c(
      "Hombres" = "#347CA5",
      "Mujeres" = "#C15C86"
    )
  ) +

  labs(
    title = "El cuidado y las tareas domésticas pesan más entre las mujeres rurales",
    subtitle = "Razones declaradas para no buscar empleo por sexo y zona",
    x = "Porcentaje de personas inactivas (%)",
    y = NULL,
    fill = "Sexo",
    caption = paste(
      "Chile, personas inactivas de 15 años o más.",
      "Fuente: CASEN 2024. Elaboración propia.",
      "IC del 95%."
    )
  ) +

  theme_minimal(base_size = 13) +
  theme(
    panel.grid.major.y = element_blank(),
    panel.grid.minor = element_blank(),
    legend.position = "bottom",
    plot.title = element_text(face = "bold"),
    plot.caption = element_text(
      size = 9,
      hjust = 0
    ),
    plot.margin = margin(15, 20, 15, 15)
  )

# Mostrar gráfico
grafico_3

# 7. Guardar gráfico 3

ggsave(
  filename = "resultados/01_graficos/grafico_03_cuidados_inactividad.png",
  plot = grafico_3,
  width = 9,
  height = 4.5,
  dpi = 300,
  bg = "white"
)

# 8. Gráfico 4: Diferencias rural-urbana en razones de cuidado y quehaceres domésticos

# Cargar resultados consolidados
brechas_cuidado <- read.csv(
  "datos/02_datos_consolidados/brechas_cuidado.csv"
)

# Ordenar categorías
datos_g4 <- brechas_cuidado %>%
  mutate(
    razon = factor(
      razon,
      levels = c(
        "Cuidado de otros familiares",
        "Cuidado de personas mayores",
        "Cuidado de niños/as",
        "Quehaceres del hogar"
      )
    )
  )

# Crear gráfico divergente
grafico_4 <- ggplot(
  datos_g4,
  aes(x = diferencia, y = razon)
) +
  # Línea vertical en cero
  geom_vline(
    xintercept = 0,
    color = "grey40",
    linewidth = 0.7
  ) +

  # Barras divergentes
  geom_col(
    aes(fill = diferencia > 0),
    width = 0.55
  ) +

  # Intervalos de confianza del 95%
  geom_errorbar(
    aes(
      xmin = ic_inferior,
      xmax = ic_superior
    ),
    orientation = "y",
    width = 0.15,
    linewidth = 0.7,
    color = "grey20"
  ) +

  # Etiquetas de diferencias
  geom_text(
    aes(
      x = ifelse(
        diferencia >= 0,
        ic_superior + 0.3,
        ic_inferior - 0.3
      ),
      label = sprintf("%+.2f pp", diferencia),
      hjust = ifelse(diferencia >= 0, 0, 1)
    ),
    size = 3.8
  ) +

  scale_fill_manual(
    values = c(
      "TRUE" = "#C15C86",
      "FALSE" = "#347CA5"
    ),
    guide = "none"
  ) +

  scale_x_continuous(
    limits = c(-4, 12),
    breaks = seq(-4, 12, 2)
  ) +

  labs(
    title = "Los quehaceres del hogar destacan en la brecha territorial",
    subtitle = "Razones para no buscar empleo: mujeres rurales menos urbanas",
    x = "Diferencia en puntos porcentuales",
    y = NULL,
    caption = paste0(
      "Valores positivos: mayor proporción rural; negativos: mayor proporción urbana.\n",
      "Chile, mujeres inactivas de 15 años o más. ",
      "Fuente: CASEN 2024. Elaboración propia. IC del 95%."
    )
  ) +

  theme_minimal(base_size = 13) +
  theme(
    panel.grid.major.y = element_blank(),
    panel.grid.minor = element_blank(),
    plot.title = element_text(face = "bold"),
    plot.caption = element_text(
      size = 9,
      hjust = 0
    )
  )

# Mostrar gráfico
grafico_4

# 9. Guardar gráfico 4

ggsave(
  filename = "resultados/01_graficos/grafico_04_diferencias_cuidado.png",
  plot = grafico_4,
  width = 10,
  height = 5,
  dpi = 300,
  bg = "white"
)

