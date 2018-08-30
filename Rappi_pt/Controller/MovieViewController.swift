//
//  MasterViewController.swift
//  Rappi_pt
//
//  Created by Luciano Schillagi on 27/08/2018.
//  Copyright © 2018 luko. All rights reserved.
//

/* Controller */

import UIKit

/* Abstract:
Una pantalla con un listado de películas ordenadas por categorías. También contiene un buscador para filtrar por nombre.
*/

class MovieViewController: UIViewController {
	
	//*****************************************************************
	// MARK: - Properties
	//*****************************************************************
	
	// MARK: Movies 🎬
	// un objeto que representa a UNA película
	var movie: TMDbMovie?
	// trae las 'popular movies'
	var popularMoviesArray = [TMDbMovie]()
	// trae las 'top rated movies'
	var topRatedMoviesArray = [TMDbMovie]()
	// trae las 'upcoming movies'
	var upcomingMoviesArray = [TMDbMovie]()
	
	// MARK: Status Bar
	override var prefersStatusBarHidden: Bool {
		return true
	}
	
	// MARK: Movie Detail VC 🔜
	var detailViewController: MovieDetailViewController? = nil // una instancia del 'movie detail view controller'
	
	// MARK: Search Controller 🔎
	let searchController = UISearchController(searchResultsController: nil)
	
	//*****************************************************************
	// MARK: - IBOutlets
	//*****************************************************************
	
	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!

	//*****************************************************************
	// MARK: - VC Life Cycle
	//*****************************************************************
	
	// task: ejecutarse una vez que la pantalla se carga
    override func viewDidLoad() {
        super.viewDidLoad()
		
			// search & scope bar
			configureSearchAndScopeBar()
			// detail vc
			configureDetailVC()
			// network request 🚀
			getPopularMovies()

    }
	
	//*****************************************************************
	// MARK: - Networking
	//*****************************************************************
	
	func getPopularMovies() {
		// networking ⬇ : Popular Movies
		TMDbClient.getPopularMovies { (success, popularMovies, error) in
			
			// dispatch
			DispatchQueue.main.async {
				
				// si la solicitud fue exitosa
				if success {
					
					// comprueba si el 'popularMovies' recibido contiene algún valor
					if let popularMovies = popularMovies {
						// si es así, se lo asigna a la propiedad ´popularMovies´
						self.popularMoviesArray = popularMovies // 🔌 👏
						self.stopActivityIndicator()
						self.tableView.reloadData()
						
						debugPrint("POPULAR MOVIES: \(popularMovies.count)")
						
						
						
					}
					
				} else {
					
				}
				
			}
			
		}
		
	}
	
	// task: obtener, mediante una solicitud web a la API de TMDb, el array de películas populares
	func getTopRatedMovies() {
		
		debugPrint("📞getTopRatedMovies")
		// networking ⬇ : Top Rated Movies
		TMDbClient.getTopRatedMovies { (success, topRatedMovies, error) in
			
			// dispatch
			DispatchQueue.main.async {
				
				// si la solicitud fue exitosa
				if success {
					
					// comprueba si el 'popularMovies' recibido contiene algún valor
					if let topRatedMovies = topRatedMovies {
						// si es así, se lo asigna a la propiedad ´popularMovies´
						self.topRatedMoviesArray = topRatedMovies // 🔌 👏
						self.stopActivityIndicator()
						self.tableView.reloadData()
						
						debugPrint("↗️\(topRatedMovies.count)")

					}
					
				} else {
					
				}
				
			}
			
		}
		
	}


	func getUpcomingMovies() {
		// networking ⬇ : Upcoming Movies
		TMDbClient.getUpcomingMovies { (success, upcomingMovies, error) in
			
			// dispatch
			DispatchQueue.main.async {
				
				// si la solicitud fue exitosa
				if success {
					
					// comprueba si el 'popularMovies' recibido contiene algún valor
					if let upcomingMovies = upcomingMovies {
						// si es así, se lo asigna a la propiedad ´popularMovies´
						self.upcomingMoviesArray = upcomingMovies // 🔌 👏
						self.stopActivityIndicator()
						self.tableView.reloadData()
						
						debugPrint("↗️\(upcomingMovies.count)")
						
						
						
					}
					
				} else {
					
				}
				
			}
			
		}
	}
	
	//*****************************************************************
	// MARK: - Activity Indicator
	//*****************************************************************
	
	func startActivityIndicator() {
		activityIndicator.alpha = 1.0
		activityIndicator.startAnimating()
	}
	
	func stopActivityIndicator() {
		activityIndicator.alpha = 0.0
		self.activityIndicator.stopAnimating()
	}

	//*****************************************************************
	// MARK: - Helpers
	//*****************************************************************
	
	// task: -----
	func configureDetailVC(){
		if let splitViewController = splitViewController {
			let controllers = splitViewController.viewControllers
			detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? MovieDetailViewController
		}
	}
	
	
	// task: configurar la barra de búsqueda y la barra de alcance (search & scope bar)
	func configureSearchAndScopeBar() {
		
		// MARK: Configurando el 'Search Controller'
		// conforma el search controller con el protocolo 'UISearchResultsUpdating'
		searchController.searchResultsUpdater = self
		// no oscurecer el fondo cuando se presentan los resultados
		searchController.obscuresBackgroundDuringPresentation = false
		// agrega la barra de búsqueda dentro de la barra de navegación
		navigationItem.searchController = searchController
		// para que no permanezca la barra de búsqueda si el usuario navega hacia otro vc
		definesPresentationContext = true
		
		// MARK: Configurando el 'Scope Bar'
		searchController.searchBar.delegate = self
		let categories = ["Popular", "Top Rated", "Upcoming"]
		searchController.searchBar.scopeButtonTitles = categories
	}


} // end class


//*****************************************************************
// MARK: - Table View Data Source Methods
//*****************************************************************

extension MovieViewController: UITableViewDataSource {
	
	// task: determinar cuantas filas tendrá la tabla
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		switch navigationItem.title {
			
		// si el título de la barra de navegación es "Popular Movies", contar ´popularMoviesArray´
		case "Popular Movies":
			debugPrint("contando el array de popular movies \(popularMoviesArray.count)")
			return popularMoviesArray.count
			
		// si el título de la barra de navegación es "Top Rated Movies", contar ´topRatedMoviesArray´
		case "Top Rated Movies":
			debugPrint("contando el array de top rated movies \(topRatedMoviesArray.count)")
			return topRatedMoviesArray.count

		// si el título de la barra de navegación es "Upcoming Movies", contar ´upcomingMoviesArray´
		case "Upcoming Movies":
			debugPrint("contando el array de upcoming movies \(upcomingMoviesArray.count)")
			return upcomingMoviesArray.count
			
		default:
			print("")
		}
		
		return 0
	}
	
	// task: configurar las celdas de la tabla
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		var movie: TMDbMovie?
		
		switch navigationItem.title {
			
			// si el título de la barra de navegación es "Popular Movies", contar ´popularMoviesArray´
			case "Popular Movies":
				movie = popularMoviesArray[(indexPath as NSIndexPath).row]
			debugPrint("🧛🏻‍♂️\(movie)")
			
			// si el título de la barra de navegación es "Top Rated Movies", contar ´topRatedMoviesArray´
			case "Top Rated Movies":
				movie = topRatedMoviesArray[(indexPath as NSIndexPath).row]
			debugPrint("🧛🏻‍♂️\(movie)")
			
			// si el título de la barra de navegación es "Upcoming Movies", contar ´upcomingMoviesArray´
			case "Upcoming Movies":
				movie = upcomingMoviesArray[(indexPath as NSIndexPath).row]
			debugPrint("🧛🏻‍♂️\(movie)")
			
			default:
				print("")
		}
		
			let cellReuseId = "cell"
			let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath) as UITableViewCell
			cell.textLabel?.text = movie?.title
			//let popularity = Float((movie?.popularity!)!)
			//cell?.detailTextLabel?.text = "popularity: \(String(popularity)) "
			
			// poster path
			if let posterPath = movie?.posterPath {
				let _ = TMDbClient.getPosterImage(TMDbClient.ParameterValues.posterSizes[0], filePath: posterPath , { (imageData, error) in
					if let image = UIImage(data: imageData!) {
						DispatchQueue.main.async {
							cell.imageView!.image = image
							debugPrint("👈\(image)")
						}
					} else {
						print(error ?? "empty error")
					}
				})
			}
		
		// devuelve la celda ya configurada
		return cell
			
		}
	
	
} // end class


//*****************************************************************
// MARK: - Table View Delegate Methods
//*****************************************************************

//extension MovieViewController: UITableViewDelegate {
//
//	// task: guardar el nombre de la tarjeta seleccionada para su posterior uso en la solicitud web 💳 👈
//	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//		let storyboardId = "Detail"
//		let controller = storyboard!.instantiateViewController(withIdentifier: storyboardId) as! MovieDetailViewController
//		controller.selectedMovie = topRatedMoviesArray[(indexPath as NSIndexPath).row]
//		navigationController!.pushViewController(controller, animated: true)
//	}
//
//} // end ext


//*****************************************************************
// MARK: - Search Result Updating Method
//*****************************************************************

extension MovieViewController: UISearchResultsUpdating {
	
	
	// task: actualizar los resultados de la búsqueda de acuerdo a la información ingresada por el usuario en la barra de búsqueda
	func updateSearchResults(for searchController: UISearchController) { // 👈
		//filterContentForSearchText(searchController.searchBar.text!)
	}
	
}

//*****************************************************************
// MARK: - Search Bar Delegate
//*****************************************************************

extension MovieViewController: UISearchBarDelegate {

	// task: decirle al delegado que el índice del botón de ´scope´ cambió
	func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
		
		//filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
		
		debugPrint("😠 el scope seleccionado es el: \(selectedScope)")
		
		// MARK: update navigation title item
		
		switch selectedScope {
			
		case 0:
			self.navigationItem.title = "Popular Movies"
			getPopularMovies()
		case 1:
				self.navigationItem.title = "Top Rated Movies"
				debugPrint("título de la barra de navegación: \(navigationItem.title)")
				// networking 🚀
				getTopRatedMovies()
			
			
		case 2:
				self.navigationItem.title = "Upcoming Movies"
			getUpcomingMovies()
			
		default:
			print("")
		}
	}
	
	
} // end ext

