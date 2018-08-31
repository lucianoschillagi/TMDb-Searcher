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
	
	
	// task: comprobar si la barra de búsqueda está vacía o no
	func searchBarIsEmpty() -> Bool {
		// Returns true if the text is empty or nil
		return searchController.searchBar.text?.isEmpty ?? true
	}
	
	
} // end ext
