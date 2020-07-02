# Instalación Cucumberish
En primer lugar se debe instalar el administrador de dependencias **Cocoapods**:
https://guides.cocoapods.org/

```
sudo gem install cocoapods
```

A continuación se instala **Xcfit** (XCUI, Cucumberish and Fitnesse Integration Tests) para la automatización y ejecución de pruebas con swift:
https://github.com/XCTEQ/XCFit
 ```
gem install xcfit
 ```
 **Nota:** Puede validar la existencia de las gemas con el comando "gem query --local"
 
Finalmente se adicioNota: Puede validar la existencia de las gemas con el comando "gem query --local"nan las plantillas al Xcode:
 ```
xcfit setup_xcode_templates
 ```

# Creación del Proyecto

* Crear Proyecto Nuevo (Single View App)
* Crear un Target asociado con cucumber:
    File -> New Target -> XCFit -> Cucumberish Bundle
* Cerrar el proyecto
* Ir a directorio de trabajo del proyecto
* Ejecutar en consola para la creación del **Podfile** (o crearlo desde ceros):
 ```
pod init 
 ```
* Editar el Podfile
 ```
use_frameworks!
target 'DIDAcceptanceTestsIOSCucumberTests' do
  pod 'Cucumberish'
end
 ```
* Ejecutar en consola para la instalación de dependencias:
 ```
pod install
 ```
* Abrir proyecto desde el Workspace
* Crear respectivos archivos para las pruebas: .feature.
 
 
 ###Notas:
* Si se tienen problemas de duplicación de tareas:
  File -> Workspace Settings -> Build System: Legacy Build System
* Si se tiene problemas con la importación cucumberish o no se encuentra el módulo: En el Xcode dirigirse a Product -> Scheme -> Manage Schemes y agregar los esquemas relacionados con cucumber y los pods del target de pruebas:
* Mayor información en: https://medium.com/@himalbandara84/quick-guide-to-setup-cucumberish-on-xcode-7db935d67a69

#Estructura Proyecto de Pruebas
* **Features**: Carpeta de almacenamiento de los archivos .feature para la ejecución de los escenarios.
* **Runner.swift**: Clase para la ejecución de los escenarios, levanta la aplicación, configura el directorio Features y las clases para ejecución de los Steps Definitions.
* **StepDefinitions.swift**: Clases para ejecución de los Steps Definitions.
* **DIDAcceptanceTestsIOSCucumberTests.m**: Configura la clase Runner para la ejecución de los escenarios por medio de la función **CucumberishSwiftInit**.
* **DIDAcceptanceTestsIOSCucumberTests-Bridging-Header.h**: Creada por defecto.
* **Info.plist**: Creada por defecto.


# Listado de Dispositivos:
 ```
 instruments -s devices
 ```

# Ejecución de las pruebas
Desde Xcode: Product -> Test
 ```
command + U
 ```
Desde Consola en múltiples dispositivos emulados (destination por dispositivo): (https://www.mokacoding.com/blog/running-tests-from-the-terminal/)
 ```
xcodebuild \
-workspace automationCucumberish.xcworkspace \
-scheme automationCucumberish \
-destination 'platform=iOS Simulator,name=iPhone 11 Pro Max,OS=13.3' \
-destination 'platform=iOS Simulator,name=OTHER DEVICE,OS=13.3' \
test
 ```
 Desde Consola con Dispositivo Físico:
  ```
 xcodebuild \
 -workspace automationCucumberish.xcworkspace \
 -scheme automationCucumberish \
 -destination 'name=NAME_DEVICE' \
 test
  ```
# Generación de Reportes

En primer lugar se debe instalar **xcpretty** para generar reportes y **xcpretty-json-formatter** para generar un reporte en formato json (https://github.com/xcpretty/xcpretty, https://github.com/marcelofabri/xcpretty-json-formatter):

 ```
 sudo gem install xcpretty
 sudo gem install xcpretty-json-formatter
 ```

Para generar los reportes de la ejecución de las pruebas ejecutar por dispositivo:
 ```
 xcodebuild \
 -workspace automationCucumberish.xcworkspace \
 -scheme automationCucumberish \
 -destination 'platform=iOS Simulator,name=iPhone 11 Pro Max,OS=13.3' \
 test| xcpretty -f `xcpretty-json-formatter`  \
 -r html -r junit
 ```
De esta manera en el directorio raíz se crea la carpeta **build/reports** con los archivos:

* junit.xml
* tests.html
* erros.json
Si se desea seleccionar un PATH y nombres de archivos diferentes por dispositivo:

 ```
 xcodebuild \
 -workspace automationCucumberish.xcworkspace \
 -scheme automationCucumberish \
 -destination 'platform=iOS Simulator,name=iPhone 11 Pro Max,OS=13.3' \
 test|XCPRETTY_JSON_FILE_OUTPUT=PATH/NAME.json xcpretty -f `xcpretty-json-formatter`  \
 -r html -o PATH/NAME.html  \
 -r junit -o PATH/NAME.xml
 ```
# Ejecución Pipeline
El pipeline (**Jenkinsfile**) se encarga de:
* Establecer las variables de ambiente como, puerto de configuración del mock, adicionalmente, se indica donde serán ejecutadas las pruebas, si en simuladores, dispositivos físicos o en ambos.
* Copiar las librerías de los proyectos asociados al SDK (authenticator, tokens, data y encryptor) tanto para dispositivos físicos como para los emuladores, con ayuda del plugin de Jenkins **Copy Artifacts** y dentro del stage **Copy Artifacts**.
* Ejecutar el Wiremock con los stubs previamente definidos en el proyecto ( http://wiremock.org/docs/running-standalone/): 
```
java -jar wiremock-standalone-2.25.1.jar -port ${WIREMOCK_PORT} --root-dir stubs
```
* Instalación de las dependencias definidas en el archivo **Podfile**
* Generar lista de dispositivos a partir de la selección previa (emulador/físico), para definir los dispositivos en los cuales serán ejecutadas las pruebas.
```
instruments -s devices | grep "^iPhone.*Simulator)$" >> simulatorList.txt
instruments -s devices | grep "^QA" >> connectedDevicesList.txt
```
* Ejecutar las pruebas y generar los reportes de cada dispositivo a partir de la(s) lista(s) generada(s)
* En las acciones post: Exportar los archivos **json** y **html** de los reportes de prueba generados dentro de cada ejecución dentro del pipeline  y eliminar directorios/archivos no requeridos.
