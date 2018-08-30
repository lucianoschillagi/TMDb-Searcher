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
						self.stopActivityIndicator()
						self.tableView.reloadData()
						
					}
					
				} else {
					
					//TODO: alert view
					print(error)
					
				}
				
			}
			
		}
		
	}
	
	// MARK: Get Top Rated Movies
	// task: obtener, mediante una solicitud web a la API de TMDb, el array de películas mejor rankeadas
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
					}
					
				} else {
					//TODO: alert view
					print(error)
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
						self.stopActivityIndicator()
						self.tableView.reloadData()
						
					}
					
				} else {
					//TODO: alert view
					print(error)
				}
			}
		}
	}
	
} // end ext
