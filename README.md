# Brechas de género en la participación laboral y las responsabilidades de cuidado: diferencias entre zonas urbanas y rurales de Chile.
Las brechas de género en la participación laboral constituyen un desafío crucial para la equidad económica en Chile. Si bien la evidencia nacional muestra que la distribución desigual del trabajo no remunerado y de cuidados restringe la inserción laboral de las mujeres, los promedios nacionales pueden ocultar diferencias importantes entre zonas urbanas y rurales del país.  ¿Qué ocurre cuándo comparamos estas diferencias territoriales?  ¿Se mantienen las mismas brechas? 

Este proyecto es una exploración inicial de los datos de la Encuesta de Caracterización Socioeconómica Nacional (Casen) del 2024, con el propósito de profundizar en cómo estas brechas se manifiestan en distintos contextos territoriales. 
## Pregunta principal
¿Cómo varía la brecha de género en la participación laboral entre zonas urbanas y rurales de Chile, y qué importancia tienen las responsabilidades de cuidado entre las razones declaradas para no buscar empleo?
## Preguntas exploratorias
1.	¿Qué revelan los promedios nacionales sobre las brechas de género en la participación laboral?
2.	¿Cómo varían estas brechas entre zonas urbanas y rurales?
3.	¿Existen diferencias de género y territoriales en las razones declaradas para no buscar empleo?
4.	¿Qué importancia tienen las responsabilidades de cuidado y los quehaceres domésticos entre estas razones?
## Organización del Repositorio: 
El repositorio está organizado para facilitar el desarrollo y la reproducibilidad del análisis, siguiendo las distintas etapas del procesamiento y visualización de datos.
Estructura de carpetas
1. datos/
Contiene los datos utilizados en el proyecto, organizados en:
01_datos_crudos/: bases de datos originales, incluyendo CASEN 2024.
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
El análisis se desarrolla en R utilizando datos de la Encuesta CASEN 2024.
Los códigos se encuentran organizados en la carpeta scripts/, siguiendo las etapas del proyecto:
1.	01_cargar_librerias/: cargar las librerías necesarias.
2.	02_cargar_datos/: importar y preparar las bases de datos.
3.	03_graficos/: generar las visualizaciones del análisis.
Los resultados se almacenarán en la carpeta resultados/, separados en gráficos y tablas.
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
