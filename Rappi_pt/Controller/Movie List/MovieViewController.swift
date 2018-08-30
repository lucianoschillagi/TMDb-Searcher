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
	
	// MARK: Movie Detail VC 🔜
	var detailViewController: MovieDetailViewController? = nil // una instancia del 'movie detail view controller'
	
	// MARK: Search Controller 🔎
	let searchController = UISearchController(searchResultsController: nil)
	
	// MARK: Las categorías disponibles
	let category = ["Popular Movies": "Popular Movies", "Top Rated Movies": "Top Rated Movies", "Upcoming Movies": "Upcoming Movies"]
	
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
	// MARK: - IBActions
	//*****************************************************************
	
	// task: ejecutarse cuando el botón ´refrescar´ es tapeado
	@IBAction func refreshButtonPressed(_ sender: UIBarButtonItem) {
		
		switch navigationItem.title {
			
		// si el título de la barra de navegación es "Popular Movies", contar ´popularMoviesArray´
		case category["Popular Movies"]:
			getPopularMovies()
			
		// si el título de la barra de navegación es "Top Rated Movies", contar ´topRatedMoviesArray´
		case category["Top Rated Movies"]:
			getTopRatedMovies()
			
		// si el título de la barra de navegación es "Upcoming Movies", contar ´upcomingMoviesArray´
		case category["Upcoming Movies"]:
			getUpcomingMovies()
			
		default:
			print("")
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

	
	// MARK: Status Bar
	override var prefersStatusBarHidden: Bool {
		return true
	}

} // end class







