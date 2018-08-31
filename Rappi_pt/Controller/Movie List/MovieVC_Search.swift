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

// UISearchResultsUpdating protocol
extension MovieViewController: UISearchResultsUpdating {
	// MARK: - UISearchResultsUpdating Delegate
	
	// task: actualizar los resultados de la búsqueda de acuerdo a la información ingresada por el usuario en le barra de búsqueda
	func updateSearchResults(for searchController: UISearchController) {
		let searchBar = searchController.searchBar
		let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
		filterContentForSearchText(searchController.searchBar.text!, scope: scope)
	}
	
}



//*****************************************************************
// MARK: - Search Bar Delegate
//*****************************************************************

extension MovieViewController: UISearchBarDelegate {
	
	// task: decirle al delegado que el índice del botón de ´scope´ cambió
	func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
		
		debugPrint("decirle al controller que el índice del botón de ´scope´ cambió")
		debugPrint("😠 el scope seleccionado es el: \(selectedScope)")
		
		// MARK: update navigation title item
		switch selectedScope {
			
		case 0:
			self.navigationItem.title = "Explore"
			getSearchTextMovies() // TODO: LUEGO CAMBIAR
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
	func filterContentForSearchText(_ searchText: String, scope: String = "All") {
		
		
		debugPrint("El texto ingresado por el ususario es: \(searchText)")
		
		
		//			//filteredCandies = candies.filter({( candy : Candy) -> Bool in
		//			let doesCategoryMatch = (scope == "All") || (candy.category == scope)
		//
		//			if searchBarIsEmpty() {
		//				return doesCategoryMatch
		//			} else {
		//				return doesCategoryMatch && candy.name.lowercased().contains(searchText.lowercased())
		//			}
		//		})
		//		tableView.reloadData()
		
//					filteredMovies = popularMoviesArray.filter({( movie : TMDbMovie) -> Bool in
//					let doesCategoryMatch = (scope == "All") || (movie.category == scope)
//		
//					if searchBarIsEmpty() {
//						return doesCategoryMatch
//					} else {
//						return doesCategoryMatch && movie.name.lowercased().contains(searchText.lowercased())
//					}
//				})
//				tableView.reloadData()
	
		
	}
	
	// task: determinar si actualmente se están filtrando resultados o no
	func isFiltering() -> Bool {
		let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
		return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
	}
	
	
	
} // end ext
