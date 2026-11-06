# ----------------------------------------
# Proyecto: Brechas de género CASEN 2024
# Script 02: Indicadores laborales
# ----------------------------------------

library(dplyr)
library(srvyr)

# 1. Participación laboral nacional por sexo

participacion_nacional <- diseno_casen %>%
  filter(edad >= 15) %>%
  group_by(sexo_grupo) %>%
  summarise(
    tasa = survey_mean(
      participa,
      na.rm = TRUE,
      vartype = "ci"
    ),
    .groups = "drop"
  ) %>%
  mutate(
    tasa = tasa * 100,
    tasa_low = tasa_low * 100,
    tasa_upp = tasa_upp * 100
  )

# Mostrar resultados
participacion_nacional

# 2. Participación laboral según sexo y zona

participacion_zona <- diseno_casen %>%
  filter(edad >= 15) %>%
  group_by(zona, sexo_grupo) %>%
  summarise(
    tasa = survey_mean(
      participa,
      na.rm = TRUE,
      vartype = "ci"
    ),
    .groups = "drop"
  ) %>%
  mutate(
    tasa = tasa * 100,
    tasa_low = tasa_low * 100,
    tasa_upp = tasa_upp * 100
  )

# Mostrar resultados
participacion_zona

# 3. Guardar indicadores de participación laboral

write.csv(
  participacion_nacional,
  "datos/02_datos_consolidados/participacion_nacional.csv",
  row.names = FALSE
)

write.csv(
  participacion_zona,
  "datos/02_datos_consolidados/participacion_zona.csv",
  row.names = FALSE
)

# 4. Explorar el universo de la pregunta o7

# Relación entre condición laboral y respuesta a o7
table(
  casen_trabajo$activ,
  !is.na(casen_trabajo$o7),
  useNA = "ifany"
)

# 5. Distribución de o7 por sexo

table(
  casen_trabajo$sexo_grupo,
  as.numeric(haven::zap_labels(casen_trabajo$o7)),
  useNA = "ifany"
)

# 6. Preparar variable de razones para no buscar empleo

diseno_casen <- diseno_casen %>%
  mutate(
    o7_num = as.numeric(haven::zap_labels(o7)),

    razon_cuidado = case_when(
      o7_num == 3 ~ "Cuidado de niños/as",
      o7_num == 4 ~ "Cuidado de personas mayores",
      o7_num == 5 ~ "Cuidado de otros familiares",
      o7_num == 10 ~ "Quehaceres del hogar",
      !is.na(o7_num) ~ "Otras razones",
      TRUE ~ NA_character_
    )
  )

# 7. Comprobar la clasificación de razones

table(
  diseno_casen$variables$razon_cuidado,
  useNA = "ifany"
)

# 8. Revisar las etiquetas originales de o7

attr(casen_2024$o7, "labels")

# 9. Mostrar las categorías de o7 de forma ordenada

etiquetas_o7 <- data.frame(
  codigo = as.numeric(attr(casen_2024$o7, "labels")),
  descripcion = names(attr(casen_2024$o7, "labels"))
)

View(etiquetas_o7)

# 10. Crear indicador de cuidados y quehaceres domésticos

diseno_casen <- diseno_casen %>%
  mutate(
    motivo_cuidados_hogar = case_when(
      o7_num %in% c(3, 4, 5, 10) ~ 1,
      !is.na(o7_num) ~ 0,
      TRUE ~ NA_real_
    )
  )

# 11. Porcentaje de personas inactivas que declaran cuidados o quehaceres domésticos

cuidados_zona <- diseno_casen %>%
  filter(edad >= 15, activ == 3) %>%
  group_by(zona, sexo_grupo) %>%
  summarise(
    porcentaje = survey_mean(
      motivo_cuidados_hogar,
      na.rm = TRUE,
      vartype = "ci"
    ),
    .groups = "drop"
  ) %>%
  mutate(
    porcentaje = porcentaje * 100,
    porcentaje_low = porcentaje_low * 100,
    porcentaje_upp = porcentaje_upp * 100
  )

# Mostrar resultados
cuidados_zona

# 12. Guardar indicadores de cuidados por zona y sexo

write.csv(
  cuidados_zona,
  "datos/02_datos_consolidados/cuidados_zona.csv",
  row.names = FALSE
)

# 13. Porcentaje por tipo de cuidado y quehaceres domésticos

tipos_cuidado <- diseno_casen %>%
  mutate(
    cuidado_ninos = as.numeric(o7_num == 3),
    cuidado_mayores = as.numeric(o7_num == 4),
    cuidado_familiares = as.numeric(o7_num == 5),
    quehaceres_hogar = as.numeric(o7_num == 10)
  ) %>%
  filter(edad >= 15, activ == 3) %>%
  group_by(zona, sexo_grupo) %>%
  summarise(
    ninos = survey_mean(cuidado_ninos, na.rm = TRUE),
    mayores = survey_mean(cuidado_mayores, na.rm = TRUE),
    familiares = survey_mean(cuidado_familiares, na.rm = TRUE),
    hogar = survey_mean(quehaceres_hogar, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  mutate(
    across(
      c(ninos, mayores, familiares, hogar,
        ninos_se, mayores_se, familiares_se, hogar_se),
      ~ .x * 100
    )
  )

# Mostrar resultados
tipos_cuidado

# 14. Guardar indicadores por tipo de cuidado

write.csv(
  tipos_cuidado,
  "datos/02_datos_consolidados/tipos_cuidado.csv",
  row.names = FALSE
)

# 15. Diferencias rural-urbana en razones para no buscar empleo
# Universo: mujeres inactivas de 15 años o más

# Crear indicadores binarios por motivo
diseno_diferencias <- diseno_casen %>%
  mutate(
    dif_ninos = as.numeric(o7_num == 3),
    dif_mayores = as.numeric(o7_num == 4),
    dif_familiares = as.numeric(o7_num == 5),
    dif_hogar = as.numeric(o7_num == 10)
  ) %>%
  filter(
    edad >= 15,
    activ == 3,
    sexo_grupo == "Mujeres"
  )

# Estimar diferencias entre zonas
diferencias_cuidado <- diseno_diferencias %>%
  group_by(zona) %>%
  summarise(
    ninos = survey_mean(dif_ninos, na.rm = TRUE),
    mayores = survey_mean(dif_mayores, na.rm = TRUE),
    familiares = survey_mean(dif_familiares, na.rm = TRUE),
    hogar = survey_mean(dif_hogar, na.rm = TRUE),
    .groups = "drop"
  )

diferencias_cuidado

# 16. Estimar proporciones y covarianzas por zona

estimaciones_zona <- survey::svyby(
  ~ dif_ninos + dif_mayores + dif_familiares + dif_hogar,
  ~ zona,
  design = diseno_diferencias,
  FUN = survey::svymean,
  na.rm = TRUE,
  covmat = TRUE
)

# Mostrar las estimaciones
estimaciones_zona

# Comprobar la matriz de covarianzas
dim(vcov(estimaciones_zona))

# 17. Revisar los nombres de los coeficientes

names(coef(estimaciones_zona))

# 18. Diferencias rural-urbana con IC del 95%

# Función para calcular la diferencia por motivo
calcular_diferencia <- function(variable, descripcion) {

  # Crear contraste: rural menos urbana
  contraste <- setNames(
    c(1, -1),
    c(
      paste0("Rural:", variable),
      paste0("Urbana:", variable)
    )
  )

  # Estimar diferencia y su incertidumbre
  resultado <- survey::svycontrast(
    estimaciones_zona,
    contraste
  )

  # Guardar resultados en puntos porcentuales
  data.frame(
    razon = descripcion,
    diferencia = as.numeric(coef(resultado)) * 100,
    error_estandar = as.numeric(survey::SE(resultado)) * 100,
    ic_inferior = as.numeric(confint(resultado)[1]) * 100,
    ic_superior = as.numeric(confint(resultado)[2]) * 100
  )
}

# Calcular las cuatro diferencias
brechas_cuidado <- dplyr::bind_rows(
  calcular_diferencia("dif_ninos", "Cuidado de niños/as"),
  calcular_diferencia("dif_mayores", "Cuidado de personas mayores"),
  calcular_diferencia("dif_familiares", "Cuidado de otros familiares"),
  calcular_diferencia("dif_hogar", "Quehaceres del hogar")
)

# Mostrar resultados
brechas_cuidado

# 19. Guardar diferencias rural-urbana

write.csv(
  brechas_cuidado,
  "datos/02_datos_consolidados/brechas_cuidado.csv",
  row.names = FALSE
)
