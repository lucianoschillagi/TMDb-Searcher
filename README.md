## TMDb Searcher

### Summary:

**TMDb Searcher** es una aplicación que permite buscar películas en una de las base de datos de contenido audiovisual más importantes de la red (The Movie Database). La app permite explorar contenido por palabra clave y también filtrar contenido por categoría. Las categorías disponibles son: Explore, Popular, Top Rated y Upcoming.

### Technologies Used In Application:

* Swift
* UIKit
* Web Services (TMDb API)
* Alamofire
* Swift-Youtube-Player
* MVC

### Expected User Experience:

* Inicialmente, el usuario se encontrará en la categoría "Explore", desde donde podrá buscar cualquier tipo de contenido media alojado en TMDb.
* Opcionalmente, podrá navegar hacia las demás categorías que filtrarán su contenido específico (popular movies, top rated movies y upcoming movies).
* Una vez situado en una categoría, el usuario podrá filtrar más específicamente por palabra clave.
* Los resultados de su búsqueda aparecerán en una table view donde cada celda representa una película.
* Si tapea sobre alguna de las celdas navegará hacia la siguiente pantalla donde encontrará mayor información sobre la película (año de lanzamiento, descripción, promedio de votos), así como un botón para ver su trailer.
* Si tapea sobre ese botón navegará hacia una tercer pantalla desde donde podrá ver el trailer de la película.

## Built With

* [Swift 4](https://developer.apple.com/swift/) - The Programming Language used
* 


### Testing The App:

* Download the project to your computer from this project page.
* Once the project is downloaded, open the .xcworkspace file from the folder.
* Run the project either using the iPhone simulator or your device. I recommend running the project on the latest iPhone device. It should be compiled with the latest version of Xcode.
* If you choose to download it on your device, please plug in your device to your computer and make the device target your device model. Then click 'run'.

### Resources:

* swift-youtube-player: [https://github.com/gilesvangruisen/Swift-YouTube-Player]()
* the movie data base API: [https://developers.themoviedb.org/3/getting-started/introduction]()
