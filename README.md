# Brechas de género en la participación laboral y el trabajo no remunerado y de cuidados: un análisis territorial de las comunas de Chile.
Las brechas de género en la participación laboral constituyen un desafío crucial para la equidad económica en Chile.  Si bien la evidencia nacional muestra que la distribución desigual del trabajo no remunerado y de cuidados restringe la inserción laboral de las mujeres, resulta fundamental profundizar en cómo estas desigualdades se manifiestan en distintos contextos territoriales.  Con el propósito de aportar evidencia empírica que contribuya al diseño de políticas públicas e investigaciones con enfoque de género y territorial, este proyecto busca analizar las brechas de género en la participación laboral y el trabajo no remunerado y de cuidados a escala comunal, considerando las diferencias entre comunas rurales, urbanas y mixtas.  
## Pregunta principal
¿Existen diferencias en las brechas de género en la participación laboral y las tareas de cuidado entre comunas rurales, urbanas y mixtas de Chile?
## Preguntas exploratorias
1. ¿Cómo varía la participación laboral de mujeres y hombres entre comunas rurales, urbanas y mixtas?
2. ¿Existen diferencias territoriales en la distribución de las tareas de cuidado entre mujeres y hombres?
3. ¿Se observa una asociación entre la realización de tareas de cuidado y la participación laboral femenina?
## Organización del Repositorio: 
El repositorio está organizado para facilitar el desarrollo y la reproducibilidad del análisis, siguiendo las distintas etapas del procesamiento y visualización de datos.
Estructura de carpetas
1. datos/
Contiene los datos utilizados en el proyecto, organizados en:
01_datos_crudos/: bases de datos originales, incluyendo CASEN 2024 y la clasificación territorial PNDR.
02_datos_consolidados/: bases de datos procesadas e integradas para el análisis.
2. scripts/
Contiene los códigos desarrollados en R, organizados según las etapas del análisis:
01_cargar_librerias/: carga de las librerías necesarias para el proyecto.
02_cargar_datos/: importación, preparación e integración de las bases de datos.
03_graficos/: elaboración de gráficos y visualizaciones.
3. resultados/
Contiene los productos generados durante el análisis exploratorio:
01_graficos/: visualizaciones de las brechas de género y diferencias territoriales.
02_tablas/: tablas descriptivas y comparativas de los indicadores analizados.
4. informe_final/
Contiene el informe del proyecto, donde se presentan las preguntas de investigación, la metodología, los resultados y las principales conclusiones del análisis.
5. README.md
Presenta el objetivo del proyecto, las fuentes de datos, la metodología y la organización del repositorio.
## Reproducibilidad
El análisis se desarrolla en R utilizando datos de la Encuesta CASEN 2024 y la clasificación territorial PNDR.
Los códigos se encuentran organizados en la carpeta scripts/, siguiendo las etapas del proyecto:
1.	01_cargar_librerias/: cargar las librerías necesarias.
2.	02_cargar_datos/: importar y preparar las bases de datos.
3.	03_graficos/: generar las visualizaciones del análisis.
Los resultados se almacenarán en la carpeta resultados/, separados en gráficos y tablas.
El proyecto se encuentra en desarrollo, por lo que los análisis y visualizaciones se incorporarán prontamente. 
## Fuentes de Datos
La investigación va a utilizar 2 fuentes de información que permiten analizar las brechas de género en la participación laboral y las tareas de cuidado desde una perspectiva territorial.
1. Encuesta de Caracterización Socioeconómica Nacional (CASEN 2024)
Elaborada por el Ministerio de Desarrollo Social y Familia de Chile.
Esta encuesta proporciona información socioeconómica de los hogares y sus integrantes. Para este proyecto se utilizarán variables relacionadas con:
Sexo de las personas.
Participación en el mercado laboral.
Realización de tareas de cuidado, según las variables disponibles.
Comuna de residencia.
2. Clasificación de comunas de la Política Nacional de Desarrollo Rural (PNDR)
La clasificación PNDR permite identificar las comunas de Chile según su carácter rural, urbano o mixto.
Esta información se utilizará para incorporar la dimensión territorial al análisis y comparar las brechas de género según el tipo de comuna.

Integración de las fuentes: ambas bases se vincularán mediante el código de comuna, permitiendo asociar la información de CASEN 2024 con la clasificación territorial PNDR.
Se considerarán los factores de expansión y las limitaciones de representatividad de CASEN para realizar e interpretar las comparaciones territoriales.
