# Autor: Ramos-Mayoral, Ayla Gabriela
# Fecha: 27/05/2000

                         
                              
                            ### Obtener los datos geoespaciales del Noroeste Atlántico ###

# Instalar los paquetes necesarios
install.packages("ggplot2")
install.packages("maptools")
install.packages("leaflet")
install.packages("sp")
install.packages("rgdal")
install.packages("sf")
install.packages("RColorBrewer")


# Cargar los paquetes
library(ggplot2)
library(sf)
library(rgdal)
library(leaflet)
library(sp)
library(RColorBrewer)

                           
#NOTA: para usar este script debes tener instalado Rtools https://cran.r-project.org/bin/windows/Rtools/
#Descarga los datos geoespaciales del mapa que gustes en formato shapefile https://www.efrainmaps.es/descargas-gratuitas/m%C3%A9xico/
#Descomprime el archivo descargado y guarda el archivo winrar para despues descargar todos los archivos. Guarda el shapefile (con extensión .shp) en tu directorio de trabajo de R.
#como es un mapa universal no es necesario bajar shapefields para cada localidad, con bajar un shapefield universal se puede modificar


# 1. Establecer el directorio de trabajo
setwd("~/R/Shape files") # Asegúrate de ajustar la ruta al directorio correcto

# 2. Verificar el directorio de trabajo actual
getwd()

# 3. Mostrar el contenido del directorio actual
list.files()

# Obtén la lista de capas disponibles en el shapefile
capas <- ogrListLayers(dsn = "~/R/Shape files")
print(capas)

# 5. Leer el shapefile (No olvides quitar el shp.)
Datos <- readOGR(dsn = ".", layer = "América")


# Crear un data frame con las coordenadas de muestreo y una variable para los colores
coordenadas <- data.frame(
  longitud = c(-100.123, -98.456, -32.789,-67.672,-130.765,-104.675),
  latitud = c(20.234, 45.567, 68.890,87.965,34.576,45.823),
  muestreo = c("Brasil", "MAN", "prueba","estaca","tecata","mariano"),
  variable_color = c("A", "B", "C", "D", "E","F")
)

# Definir una paleta de colores
colores <- c("red", "blue", "green", "pink", "purple","yellow")

map <- leaflet() %>%
  addTiles(options = providerTileOptions(noWrap = TRUE, minZoom = 1, maxZoom = 18,
                                         attribution = 'Tiles &copy; <a href="http://leafletjs.com">Leaflet</a> contributors')) %>%
  addProviderTiles("CartoDB.PositronNoLabels", group = "variable color") %>%
  addCircleMarkers(data = coordenadas, lng = ~longitud, lat = ~latitud,
                   color = ~colorFactor(palette = colores, domain = variable_color)(variable_color),
                   fill = TRUE, fillOpacity = 1, radius = 10) %>% 
  addLayersControl(baseGroups = c("CartoDB.PositronNoLabels"), overlayGroups = c("Localidades"),
                   options = layersControlOptions(collapsed = FALSE))
#Observar el mapa
map

#Listo para guardar el mapa solo hay que exportar el mapa en formato JPG.

# Autor: Ramos-Mayoral, Ayla Gabriela
# Fecha: 27/05/2000
#ENES, UNIDAD MORELIA

