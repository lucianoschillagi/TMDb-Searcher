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

*/

class MovieViewController: UIViewController {
	
	//*****************************************************************
	// MARK: - Properties
	//*****************************************************************
	
	// MARK: Movies 🎬
	// un objeto que representa a UNA película
	var movie: TMDbMovie?
	// trae las 'popular movies'
	var popularMovies: [TMDbMovie] = [TMDbMovie]()
	// trae las 'top rated movies'
	var topRatedMovies: [TMDbMovie] = [TMDbMovie]()
	// trae las 'upcoming movies'
	var upcomingMovies: [TMDbMovie] = [TMDbMovie]()

	
	// MARK: Status Bar
	override var prefersStatusBarHidden: Bool {
		return true
	}
	
	// MARK: Movie Detail VC 🔜
	var detailViewController: MovieDetailViewController? = nil // una instancia del 'movie detail view controller'
	
	// MARK: Search Controller 🔎
	let searchController = UISearchController(searchResultsController: nil)
	
	
//	// MODEL
//	// un array para contener todos los candies
//	var candies = [Candy]()
//	// un array para contener sólo los candies filtrados
//	var filteredCandies = [Candy]()
	
	
	//*****************************************************************
	// MARK: - IBOutlets
	//*****************************************************************
	
	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!

	
	//*****************************************************************
	// MARK: - VC Life Cycle
	//*****************************************************************

    override func viewDidLoad() {
        super.viewDidLoad()
			
			// search & scope bar
			configureSearchAndScopeBar()
			// detail vc
			configureDetailVC()
			// network request
			startRequest()

    }
	
	override func viewWillAppear(_ animated: Bool) {
		
		
		
		
	}
	
	//*****************************************************************
	// MARK: - Helpers
	//*****************************************************************
	
	
	func setModel() {
		
		// the model (data source)
		//			candies = [
		//				Candy(category:"Chocolate", name:"Chocolate Bar"),
		//				Candy(category:"Chocolate", name:"Chocolate Chip"),
		//				Candy(category:"Chocolate", name:"Dark Chocolate"),
		//				Candy(category:"Hard", name:"Lollipop"),
		//				Candy(category:"Hard", name:"Candy Cane"),
		//				Candy(category:"Hard", name:"Jaw Breaker"),
		//				Candy(category:"Other", name:"Caramel"),
		//				Candy(category:"Other", name:"Sour Chew"),
		//				Candy(category:"Other", name:"Gummi Bear"),
		//				Candy(category:"Other", name:"Candy Floss"),
		//				Candy(category:"Chocolate", name:"Chocolate Coin"),
		//				Candy(category:"Chocolate", name:"Chocolate Egg"),
		//				Candy(category:"Other", name:"Jelly Beans"),
		//				Candy(category:"Other", name:"Liquorice"),
		//				Candy(category:"Hard", name:"Toffee Apple")
		//			]
		
	}
	
	
	
	
	
	// task: -----
	func configureDetailVC(){
		if let splitViewController = splitViewController {
			let controllers = splitViewController.viewControllers
			detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? MovieDetailViewController
		}
	}
	

	// task: configurar la barra de búsqueda y la barra de alcance
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
		let categories = ["Popular", "Top Rated", "Uncoming"]
		searchController.searchBar.scopeButtonTitles = categories
	}

	//*****************************************************************
	// MARK: - Networking
	//*****************************************************************
	
	// task: obtener, mediante una solicitud web a la API de TMDb, el array de películas populares
	func startRequest() {
		
		// networking ⬇
		TMDbClient.getTopRatedMovies { (success, topRatedMovies, error) in
			
			// dispatch
			DispatchQueue.main.async {
				
				// si la solicitud fue exitosa
				if success {
					print("HOLA")
					
					// comprueba si el 'popularMovies' recibido contiene algún valor
					if let topRatedMovies = topRatedMovies {
						// si es así, se lo asigna a la propiedad ´popularMovies´
						self.topRatedMovies = topRatedMovies // 🔌 👏
						self.stopActivityIndicator()
						self.tableView.reloadData()
						
						debugPrint("↗️\(topRatedMovies.count)")
						
						
						
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


} // end class


//*****************************************************************
// MARK: - Table View Data Source Methods
//*****************************************************************

extension MovieViewController: UITableViewDataSource {
	
	// task: determinar cuantas filas tendrá la tabla
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		//return topRatedMovies.count
		return topRatedMovies.count
	}
	
	// task: configurar las celdas de la tabla
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cellReuseId = "cell"
		
		
		if searchBar.selectedScopeButtonIndex == 3 {
			
			debugPrint("SIIIII")
			let movie = upcomingMovies[(indexPath as NSIndexPath).row]
			
		}
		
		let movie = topRatedMovies[(indexPath as NSIndexPath).row]
		
		
		
		let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath) as UITableViewCell!
		cell?.textLabel?.text = movie.title
		let popularity = Float(movie.popularity!)
		cell?.detailTextLabel?.text = "popularity: \(String(popularity)) "
	
			// poster path
			if let posterPath = movie.posterPath {
				let _ = TMDbClient.getPosterImage(TMDbClient.ParameterValues.posterSizes[0], filePath: posterPath , { (imageData, error) in
					if let image = UIImage(data: imageData!) {
						DispatchQueue.main.async {
							cell?.imageView!.image = image
							debugPrint("👈\(image)")
						}
					} else {
						print(error ?? "empty error")
					}
				})
			}
		
		return cell!
		
	}
		
		
	
} // end class


//*****************************************************************
// MARK: - Table View Delegate Methods
//*****************************************************************

extension MovieViewController: UITableViewDelegate {
	
	// task: almacenar el nombre de la tarjeta seleccionada para su posterior uso en la solicitud web
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let storyboardId = "Detail"
		let controller = storyboard!.instantiateViewController(withIdentifier: storyboardId) as! MovieDetailViewController
		controller.selectedMovie = topRatedMovies[(indexPath as NSIndexPath).row]
		navigationController!.pushViewController(controller, animated: true)
	}
	
} // end ext




//*****************************************************************
// MARK: - Search Result Updating Method
//*****************************************************************

extension MovieViewController: UISearchResultsUpdating {
	// MARK: - UISearchResultsUpdating Delegate
	
	// task: actualizar los resultados de la búsqueda de acuerdo a la información ingresada por el usuario en le barra de búsqueda
	func updateSearchResults(for searchController: UISearchController) { // 👈
		//filterContentForSearchText(searchController.searchBar.text!)
	}
	
}

//*****************************************************************
// MARK: - Search Bar Delegate
//*****************************************************************

extension MovieViewController: UISearchBarDelegate {
	// MARK: - UISearchBar Delegate
	func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
		//filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
		
		
		debugPrint("el scope seleccionado es el: \(selectedScope)")
		
		
		// MARK: update navigation title item
		if selectedScope == 0 {
			
			self.navigationItem.title = "Popular Movies"
		}
		
		if selectedScope == 1 {
			
			self.navigationItem.title = "Top Rated Movies"
		}
		
		if selectedScope == 2 {
			
			self.navigationItem.title = "Upcoming Movies"
		}
		
		if selectedScope == 3 {
		// networking ⬇
		TMDbClient.getUpcomingMovies { (success, upcomingMovies, error) in
			
			// dispatch
			DispatchQueue.main.async {
				
				// si la solicitud fue exitosa
				if success {
					print("UPCOMING MOVIES")
					
					// comprueba si el 'popularMovies' recibido contiene algún valor
					if let upcomingMovies = upcomingMovies {
						// si es así, se lo asigna a la propiedad ´upcomingMovies´
						self.upcomingMovies = upcomingMovies // 🔌 👏
						self.stopActivityIndicator()
						self.tableView.reloadData()
						
						debugPrint("↗️\(upcomingMovies.count)")
						
						
						
					}
					
				} else {
					
				}
				
			}
			
		}
		
		} // end if
		
	}
} // end ext

