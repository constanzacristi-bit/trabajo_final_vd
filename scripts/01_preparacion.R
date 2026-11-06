# -------------------------------------------
# Proyecto: Brechas de género CASEN 2024
# Script 01: Preparación de los datos
# Fuente: Encuesta CASEN 2024
# -------------------------------------------

# 1. Cargar la base original
load("datos/01_datos_crudos/casen_2024.rdata")

# 2. Identificar los objetos cargados
ls()

# 3. Revisar dimensiones de la base
dim(casen_2024)

# 4. Comprobar las variables del proyecto
variables <- c("sexo", "edad", "area", "activ",
               "o7", "expr", "varstrat", "varunit")

variables %in% names(casen_2024)

# 5. Revisar las primeras observaciones
head(casen_2024[variables])


# 7. Revisar la población de 15 años o más

# Cantidad de personas de 15 años o más
sum(casen_2024$edad >= 15, na.rm = TRUE)

# Condición de actividad en personas de 15 años o más
table(
  casen_2024$activ[casen_2024$edad >= 15],
  useNA = "ifany"
)

# Revisar edades de personas sin clasificación laboral
summary(casen_2024$edad[is.na(casen_2024$activ)])

# 8. Cargar paquetes
library(dplyr)
library(haven)

# 9. Crear base de trabajo

casen_trabajo <- casen_2024 %>%
  mutate(
    # Convertir variables etiquetadas a numéricas
    sexo = as.numeric(haven::zap_labels(sexo)),
    area = as.numeric(haven::zap_labels(area)),
    activ = as.numeric(haven::zap_labels(activ)),

    # Crear categorías de sexo
    sexo_grupo = case_when(
      sexo == 1 ~ "Hombres",
      sexo == 2 ~ "Mujeres",
      TRUE ~ NA_character_
    ),

    # Crear categorías territoriales
    zona = case_when(
      area == 1 ~ "Urbana",
      area == 2 ~ "Rural",
      TRUE ~ NA_character_
    ),

    # Crear indicador de participación laboral
    participa = case_when(
      edad >= 15 & activ %in% c(1, 2) ~ 1,
      edad >= 15 & activ == 3 ~ 0,
      TRUE ~ NA_real_
    )
  )

# 10. Comprobar las variables creadas

table(casen_trabajo$sexo_grupo)

table(casen_trabajo$zona)

table(casen_trabajo$participa, useNA = "ifany")

# 11. Configurar el diseño muestral CASEN 2024

library(srvyr)

diseno_casen <- casen_trabajo %>%
  as_survey_design(
    ids = varunit,
    strata = varstrat,
    weights = expr,
    nest = TRUE
  )
class(diseno_casen)
