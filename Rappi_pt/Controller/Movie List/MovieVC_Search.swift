//
//  MovieVC_Search.swift
//  Rappi_pt
//
//  Created by Luciano Schillagi on 30/08/2018.
//  Copyright © 2018 luko. All rights reserved.
//

/* Controller */

import UIKit

/* Abstract:
Contiene métodos concernientes a las búsquedas.
*/

//*****************************************************************
// MARK: - Search Result Updating Method
//*****************************************************************

extension MovieListViewController: UISearchResultsUpdating {
	// MARK: - UISearchResultsUpdating Delegate
	
	// task: actualizar los resultados de la búsqueda de acuerdo a la información ingresada por el usuario en le barra de búsqueda
	func updateSearchResults(for searchController: UISearchController) {
		let searchBar = searchController.searchBar
		let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
		// si la barra de búsqueda está vacía, no hacer nada...
		if searchBar.text == "" {
		} else {
		// ... si tiene algún texto, tomarlo para usarlo como ´query´ del método
		filterContentForSearchText(searchController.searchBar.text!, scope: scope)
		}
	}
}

//*****************************************************************
// MARK: - Search Bar Delegate
//*****************************************************************

extension MovieListViewController: UISearchBarDelegate {

	// task: le dice al controlador que el usuario cambió el texto de la barra de búsqueda
	// cada vez que el texto de búsqueda cambia se cancela la descarga actual y empieza una nueva 👈
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		

		// cancel the last task
		if let task = searchTask {
			task.cancel()
		}

		// if the text is empty we are done
		if searchText == "" {
			filteredMoviesArray = [TMDbMovie]()
			movieTableView?.reloadData()
			return
		}

		// si buscador tiene algún texto, pasarlo 
		if !searchText.isEmpty {
		getSearchTextMovies(searchText)
		}
	}
	
	
	// task: decirle al delegado que el index del botón de ´scope´ cambió
	func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
		
		// MARK: update navigation title item
		switch selectedScope {
			
		case 0:
			self.navigationItem.title = "Explore"
		case 1:
			self.navigationItem.title = "Popular Movies"
			getPopularMovies()
		case 2:
			self.navigationItem.title = "Top Rated Movies"
			getTopRatedMovies()
		case 3:
			self.navigationItem.title = "Upcoming Movies"
			getUpcomingMovies()
			
		default:
			print("")
		}
	}
	
	// task: comprobar si la barra de búsqueda está vacía o no
	func searchBarIsEmpty() -> Bool {
		// Returns true if the text is empty or nil
		debugPrint("LA BARRA DE BÚSQUEDA TIENE TEXTO")
		return searchController.searchBar.text?.isEmpty ?? true
	}
	
	// task: filtrar las películas de acuerdo al texto de búsqueda ingresado por el usuario 👈
	func filterContentForSearchText(_ searchText: String, scope: String = "Explore") {
		
			filteredMoviesArray = filteredMoviesArray.filter({( movie : TMDbMovie) -> Bool in
					let doesCategoryMatch = (scope == "Explore") 
		
					if searchBarIsEmpty() {
						return doesCategoryMatch
					} else {
						return doesCategoryMatch && movie.title!.lowercased().contains(searchText.lowercased())
					}
				})
				movieTableView.reloadData()
	}
	
	// task: determinar si actualmente se están filtrando resultados o no
	func isFiltering() -> Bool {
		let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
		return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
	}
	
	
	
} // end ext
