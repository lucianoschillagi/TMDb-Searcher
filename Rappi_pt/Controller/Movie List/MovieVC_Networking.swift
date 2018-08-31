//
//  MovieVC_Networking.swift
//  Rappi_pt
//
//  Created by Luciano Schillagi on 30/08/2018.
//  Copyright © 2018 luko. All rights reserved.
//

/* Controller */

import UIKit

/* Abstract:
Contiene métodos concernientes a las solicitudes web.
*/

extension MovieViewController {
	
	//*****************************************************************
	// MARK: - Networking
	//*****************************************************************
	
	// MARK: Get Popular Movies
	// task: obtener, mediante una solicitud web a la API de TMDb, el array de películas populares
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
						//self.stopActivityIndicator()
						self.movieTableView.reloadData()
						
					}
					
				} else {
					// si devuelve un error
					self.displayAlertView("Error Request", error)
				}
				
			}
			
		}
		
	}
	
	// MARK: Get Top Rated Movies
	// task: obtener, mediante una solicitud web a la API de TMDb, el array de películas mejor rankeadas
	func getTopRatedMovies() {

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
						//self.stopActivityIndicator()
						self.movieTableView.reloadData()
					}
					
				} else {
					// si devuelve un error
					self.displayAlertView("Error Request", error)
				}
				
			}
			
		}
		
	}
	
	// MARK: Get Upcoming Movies
	// task: obtener, mediante una solicitud web a la API de TMDb, el array de películas por venir
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
					//	self.stopActivityIndicator()
						self.movieTableView.reloadData()
						
					}
					
				} else {
					// si devuelve un error
					self.displayAlertView("Error Request", error)
				}
			}
		}
	}
	
	// MARK: Get Search Text Movies
	// task: obtener, mediante una solicitud web a la API de TMDb, el array de películas filtradas por texto
	func getSearchTextMovies(_ searchText: String) {
		
		// networking ⬇ : Upcoming Movies
		TMDbClient.getMoviesForSearchString(searchText) { (success, searchTextMovies, error) in
			
			//test
			//debugPrint("😡 ->\(self.searchUserText)")
			
			// dispatch
			DispatchQueue.main.async {
				
				
				// si la solicitud fue exitosa
				if success {
					// comprueba si el 'popularMovies' recibido contiene algún valor
					if let searchTextMovies = searchTextMovies {
						// si es así, se lo asigna a la propiedad ´popularMovies´
						debugPrint("🧙🏽‍♀️\(searchTextMovies)")
						self.filteredMoviesArray = searchTextMovies // 🔌 👏
						//self.stopActivityIndicator()
						self.movieTableView.reloadData()
						
					}
					
				} else {
					// si devuelve un error
					self.displayAlertView("Error Request", error)
				}
			}
		}
		
		
		
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
} // end ext
