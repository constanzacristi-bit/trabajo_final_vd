# Brechas de género en la participación laboral y las responsabilidades de cuidado: diferencias entre zonas urbanas y rurales de Chile.
Las brechas de género en la participación laboral constituyen un desafío crucial para la equidad económica en Chile. Si bien la evidencia nacional muestra que la distribución desigual del trabajo no remunerado y de cuidados restringe la inserción laboral de las mujeres, los promedios nacionales pueden ocultar diferencias importantes entre zonas urbanas y rurales del país.  ¿Qué ocurre cuándo comparamos estas diferencias territoriales?  ¿Se mantienen las mismas brechas? 

Este proyecto es una exploración inicial de los datos de la Encuesta de Caracterización Socioeconómica Nacional (CASEN) 2024, con el propósito de profundizar en cómo estas brechas se manifiestan en distintos contextos territoriales y examinar la importancia de las responsabilidades de cuidado y los quehaceres domésticos entre las razones declaradas para no buscar empleo. 
## Pregunta principal
¿Cómo varía la brecha de género en la participación laboral entre zonas urbanas y rurales de Chile, y qué importancia tienen las responsabilidades de cuidado entre las razones declaradas para no buscar empleo?
## Preguntas exploratorias
1.	¿Qué revelan los promedios nacionales sobre las brechas de género en la participación laboral?
2.	¿Cómo varían estas brechas entre zonas urbanas y rurales?
3.	¿Existen diferencias de género y territoriales en las razones declaradas para no buscar empleo?
4.	¿Qué importancia tienen las responsabilidades de cuidado y los quehaceres domésticos entre estas razones?
## Resultados y visualizaciones

1. La brecha nacional en la participación laboral
En Chile, la participación laboral masculina alcanza el 73,1%, mientras que la femenina llega al 53,5%, lo que representa una diferencia de 19,6 puntos porcentuales.

A partir de este resultado, se establece una base para el análisis. Aunque la brecha nacional es amplia, su magnitud no necesariamente es homogénea entre territorios.

2. La brecha de género es mayor en las zonas rurales
Al incorporar en el análisis la dimensión territorial, se puede observar una diferencia de 28,3 puntos en la participación laboral en zonas rurales, en comparación con un 18,7 en zonas urbanas.

Estos resultados muestran que los promedios nacionales ocultan diferencias de participación laboral entre territorios rurales y urbanos.  Las mujeres que viven en territorios rurales tienen una tasa de participación laboral del 38,7%, lo que es inferior al 55,3% que se puede observar en mujeres que viven en territorios urbanos.

3. Cuidados y quehaceres domésticos entre las razones para no buscar empleo
Al examinar los motivos declarados para no buscar empleo, también surgen diferencias importantes.  Entre las mujeres inactivas de 15 años o más, el 40,6% en zonas rurales atribuye a las responsabilidades de cuidado o quehaceres domésticos la razón principal para estar fuera del mercado laboral, en comparación con el 32,4% de mujeres que zonas urbanas.  Entre los hombres inactivos, en cambio, estas cifras caen al 5,0% en zonas rurales y al 3,5% en zonas urbanas.

Por lo tanto se pueden evidenciar diferencias relevantes por sexo y por territorio en las razones declaradas para no buscar empleo. 

4. ¿Qué responsabilidades presentan las mayores diferencias territoriales?
Al examinar los motivos indicados por las mujeres inactivas, se aprecia que la brecha entre zonas rurales y urbanas no es homogénea. La mayor divergencia se registra en las tareas del hogar, cuya importancia relativa es 8,66 puntos porcentuales más alta entre las mujeres rurales inactivas.  En el cuidado de niños y niñas, la brecha es de −1,82 puntos porcentuales, evidenciando una mayor prevalencia en las zonas urbanas.  Respecto al cuidado de personas adultas mayores, las diferencias vuelven a inclinarse hacia las zonas rurales, con +0,95 puntos porcentuales.  Al estudiar el cuidado de otros familiares, se observa una diferencia en la variación de +0,37 puntos, que no resulta estadísticamente significativa, ya que su intervalo de confianza incluye el cero.

Estos resultados permiten acotar la evidencia previa, la principal diferencia territorial entre las razones examinadas corresponde a los quehaceres del hogar.

## Metodología


## Organización del Repositorio 
El repositorio está organizado para facilitar el desarrollo y la reproducibilidad del análisis, siguiendo las distintas etapas del procesamiento y visualización de datos.

trabajo_final_vd/
│
├── datos/
│   ├── 01_datos_crudos/
│   └── 02_datos_consolidados/
│
├── scripts/
│   ├── 01_preparacion.R
│   ├── 02_indicadores.R
│   └── 03_visualizaciones.R
│
├── resultados/
│   ├── 01_graficos/
│   └── 02_tablas/
│
├── informe_final/
├── README.md
├── .gitignore
└── trabajo_final_vd.Rproj

datos/01_datos_crudos/: destinada a las bases originales. Los microdatos de CASEN no se publican en el repositorio.
datos/02_datos_consolidados/: contiene los cinco archivos CSV con indicadores y diferencias estimadas.
scripts/: contiene los códigos R de preparación de datos, estimación de indicadores y generación de visualizaciones.
resultados/01_graficos/: contiene los cuatro gráficos elaborados con ggplot2.
resultados/02_tablas/: carpeta destinada a tablas de resultados.
informe_final/: carpeta destinada al informe del proyecto.
README.md: presenta las preguntas, los resultados, la metodología y la estructura del proyecto.
## Reproducibilidad
El análisis se desarrolla en R utilizando datos de la Encuesta CASEN 2024. Para reproducir el análisis, se requiere descargar la base original de CASEN 2024 y guardarla como datos/01_datos_crudos/casen_2024.rdata.

Los códigos se encuentran organizados en la carpeta scripts/. Se ejecutan en el siguiente orden:
source("scripts/01_preparacion.R")
source("scripts/02_indicadores.R")
source("scripts/03_visualizaciones.R")
Para realizar el análisis se utilizan paquetes dplyr, haven, srvyr, survey, tidyr y ggplot2. El detalle está especificado en los scripts.  Al ejectuar se reconstruyen los indicadores y se generan 4 visualizaciones a partir de los datos originales. 

El proyecto se encuentra en desarrollo, por lo que los análisis y visualizaciones se incorporarán prontamente. 
## Fuentes de Datos
La investigación va a utilizar la Encuesta de Caracterización Socioeconómica Nacional (CASEN 2024) como fuente de información, ya que permite analizar las brechas de género en la participación laboral y las tareas de cuidado desde una perspectiva territorial.

Encuesta CASEN 2024: elaborada por el Ministerio de Desarrollo Social y Familia de Chile. Esta encuesta proporciona información socioeconómica de los hogares y sus integrantes. Para este proyecto se utilizarán variables relacionadas con:
Sexo de las personas.
Participación en el mercado laboral.
Realización de tareas de cuidado, según las variables disponibles.
Comuna de residencia.

Se considerarán los factores de expansión y las limitaciones de representatividad de CASEN para realizar e interpretar las comparaciones territoriales. 

La base de datos de CASEN 2024 se puede descargar en el siguiente enlace https://bidat.gob.cl/details/ficha/dataset/base-de-datos-casen-2024
