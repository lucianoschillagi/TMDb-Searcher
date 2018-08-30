//
//  MovieVC_Table.swift
//  Rappi_pt
//
//  Created by Luciano Schillagi on 30/08/2018.
//  Copyright © 2018 luko. All rights reserved.
//

/* Controller */

import UIKit

/* Abstract:
Contiene métodos concernientes a la tabla.
*/

	
	extension MovieViewController: UITableViewDataSource {
		
		//*****************************************************************
		// MARK: - Table View Data Source Methods
		//*****************************************************************
		
		// task: determinar cuantas filas tendrá la tabla
		func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
			
			switch navigationItem.title {
				
			// si el título de la barra de navegación es "Popular Movies", contar ´popularMoviesArray´
			case category["Popular Movies"]:
				debugPrint("contando el array de popular movies \(popularMoviesArray.count)")
				return popularMoviesArray.count
				
			// si el título de la barra de navegación es "Top Rated Movies", contar ´topRatedMoviesArray´
			case category["Top Rated Movies"]:
				debugPrint("contando el array de top rated movies \(topRatedMoviesArray.count)")
				return topRatedMoviesArray.count
				
			// si el título de la barra de navegación es "Upcoming Movies", contar ´upcomingMoviesArray´
			case category["Upcoming Movies"]:
				debugPrint("contando el array de upcoming movies \(upcomingMoviesArray.count)")
				return upcomingMoviesArray.count
				
			default:
				print("")
			}
			
			return 0
		}
		
		// task: configurar las celdas de la tabla de acuerdo a la categoría a la que pertenece el listado actual
		func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
			
			var movie: TMDbMovie?
			
			switch navigationItem.title {
				
			// si el título de la barra de navegación es "Popular Movies", mostrar ese grupo en las celdas de la tabla
			case category["Popular Movies"]:
				movie = popularMoviesArray[(indexPath as NSIndexPath).row]
				debugPrint("🧛🏻‍♂️\(movie)")
				
			// si el título de la barra de navegación es "Top Rated Movies", mostrar ese grupo en las celdas de la tabla
			case category["Top Rated Movies"]:
				movie = topRatedMoviesArray[(indexPath as NSIndexPath).row]
				debugPrint("🧛🏻‍♂️\(movie)")
				
			// si el título de la barra de navegación es "Upcoming Movies", mostrar ese grupo en las celdas de la tabla
			case category["Upcoming Movies"]:
				movie = upcomingMoviesArray[(indexPath as NSIndexPath).row]
				debugPrint("🧛🏻‍♂️\(movie)")
				
			default:
				print("")
			}
			
			// configura la celda
			let cellReuseId = "cell"
			let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath) as UITableViewCell
			cell.textLabel?.text = movie?.title
			let popularity = Float((movie?.popularity!)!)
			cell.detailTextLabel?.text = "popularity: \(String(popularity)) "
			
			// poster path (image)
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
	
	extension MovieViewController: UITableViewDelegate {
		
		// task: navegar hacia el detalle de la película (de acuerdo al listado de películas actual)
		func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
			
			let storyboardId = "Detail"
			let controller = storyboard!.instantiateViewController(withIdentifier: storyboardId) as! MovieDetailViewController
			
			switch navigationItem.title {
				
			case category["Popular Movies"]:
				controller.selectedMovie = popularMoviesArray[(indexPath as NSIndexPath).row]
				navigationController!.pushViewController(controller, animated: true)
				
			case category["Top Rated Movies"]:
				controller.selectedMovie = topRatedMoviesArray[(indexPath as NSIndexPath).row]
				navigationController!.pushViewController(controller, animated: true)
				
			case category["Upcoming Movies"]:
				controller.selectedMovie = upcomingMoviesArray[(indexPath as NSIndexPath).row]
				navigationController!.pushViewController(controller, animated: true)
				
			default:
				print("")
			}
			
		}
		
	} // end ext
	
	

