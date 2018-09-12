//
//  ViewController.swift
//  Intive_Challenge
//
//  Created by Luciano Schillagi on 04/09/2018.
//  Copyright © 2018 luko. All rights reserved.
//

/* Controller */

import UIKit

/* Abstract:

*/

class MediaListViewContoller: UIViewController {
	

	//*****************************************************************
	// MARK: - Properties
	//*****************************************************************
	
	var musicArray = [iTunesMusic]()
	var tvShowArray = [iTunesTVShow]()
	var movieArray = [iTunesMovie]()
	var music: iTunesMusic?
	var tvShow: iTunesTVShow?
	var movie: iTunesMovie?
	
	// MARK: Search Controller 🔎
	let searchController = UISearchController(searchResultsController: nil)
	
	// MARK: Las categorías disponibles
	let category = ["Music": "Music", "TV Show": "TV Show", "Movie": "Movie"]
	
	//*****************************************************************
	// MARK: - IBOutlets
	//*****************************************************************
	
	@IBOutlet var mediaTableView: UITableView!
	
	//*****************************************************************
	// MARK: - VC Life Cycle
	//*****************************************************************

	override func viewDidLoad() {
		
		// navigation item
		self.navigationController?.navigationBar.prefersLargeTitles = true
		navigationItem.title = "Music"

		
		// delegación
		configureSearchAndScopeBar()
		mediaTableView.dataSource = self
		mediaTableView.delegate = self

		getMusic()
	
	}
	
	
	//*****************************************************************
	// MARK: - Networking
	//*****************************************************************
	
	func getTVShows() {
		// networking ⬇ : TV Shows (async)
		iTunesApiClient.getTVShows { (success, tvShow, error) in
			
			DispatchQueue.main.async {
				
				if success {
					// comprueba si el 'popularMovies' recibido contiene algún valor
					if let tvShow = tvShow {
						// si es así, se lo asigna a la propiedad ´popularMovies´
						self.tvShowArray = tvShow  // 🔌 👏
						//self.stopActivityIndicator()
						self.mediaTableView.reloadData()
					}
				} else {
					// si devuelve un error
					//self.displayAlertView("Error Request", error)
				}
			}
		}
	}
	
	
	
	func getMusic() {
		// networking ⬇ : Music (async)
		iTunesApiClient.getMusic { (success, music, error) in
			
			DispatchQueue.main.async {
				
				if success {
					// comprueba si el 'popularMovies' recibido contiene algún valor
					if let music = music {
						// si es así, se lo asigna a la propiedad ´popularMovies´
						self.musicArray = music // 🔌 👏
						//self.stopActivityIndicator()
						self.mediaTableView.reloadData()
					}
				} else {
					// si devuelve un error
					//self.displayAlertView("Error Request", error)
				}
			}
		}
	}
	
	func getMovies() {
		// networking ⬇ : Movies (async)
		iTunesApiClient.getMovies { (success, movies, error) in
			
			DispatchQueue.main.async {
				
				if success {
					// comprueba si el 'popularMovies' recibido contiene algún valor
					if let movies = movies {
						// si es así, se lo asigna a la propiedad ´popularMovies´
						self.movieArray = movies // 🔌 👏
						//self.stopActivityIndicator()
						self.mediaTableView.reloadData()
					}
				} else {
					// si devuelve un error
					//self.displayAlertView("Error Request", error)
				}
			}
		}
	}
	
	
	//*****************************************************************
	// MARK: - Configure UI Elements
	//*****************************************************************
	
	
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
		let categories = ["Music", "TV Show", "Movie"]
		searchController.searchBar.scopeButtonTitles = categories
	}
	
	// MARK: Status Bar
	override var prefersStatusBarHidden: Bool { return true }

}

//*****************************************************************
// MARK: - Table View Data Source Methods
//*****************************************************************


	extension MediaListViewContoller: UITableViewDataSource {
	
		// task: determinar cuantas filas tendrá la tabla
		func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
			
			switch navigationItem.title {
				
			// si el título de la barra de navegación es "Explore", contar ´filteredMoviesArray´
			case category["Music"]:
				return musicArray.count
				
			// si el título de la barra de navegación es "Popular Movies", contar ´popularMoviesArray´
			case category["TV Show"]:
				return tvShowArray.count
				
			// si el título de la barra de navegación es "Top Rated Movies", contar ´topRatedMoviesArray´
			case category["Movie"]:
				return movieArray.count
				
			default:
				print("")
			}
			
			return 0
		}
	
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cellReuseId = "cell"
		let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath) as UITableViewCell
		
			switch navigationItem.title {
				
				
		
			// si el título de la barra de navegación es "Music", mostrar ese grupo en las celdas de la tabla
			case category["Music"]:
				music = musicArray[(indexPath as NSIndexPath).row]
				cell.textLabel?.text = music?.tituloCancion
				cell.detailTextLabel?.text = music?.nombreArtista
				// imagen del disco
				if (music?.imagenDelDisco) != nil {
						let _ = iTunesApiClient.getArtworkImage { (imageData, error) in
							if let image = UIImage(data: imageData!) {
								DispatchQueue.main.async {
									cell.imageView!.image = image
									debugPrint("👈\(image)")
								}
							} else {
								print(error ?? "empty error")
							}
						}
					}
				
		
			// si el título de la barra de navegación es "TV Show", mostrar ese grupo en las celdas de la tabla
			case category["TV Show"]:
				tvShow = tvShowArray[(indexPath as NSIndexPath).row]
				cell.textLabel?.text = tvShow?.tituloDelPrograma
				cell.detailTextLabel?.text = tvShow?.nombreDelEpisodio
				// imagen de la serie
				if (tvShow?.imagenDelPrograma) != nil {
					let _ = iTunesApiClient.getArtworkImage { (imageData, error) in
						if let image = UIImage(data: imageData!) {
							DispatchQueue.main.async {
								cell.imageView!.image = image
								debugPrint("👈\(image)")
							}
						} else {
							print(error ?? "empty error")
						}
					}
				}
		
			// si el título de la barra de navegación es "Movie", mostrar ese grupo en las celdas de la tabla
			case category["Movie"]:
				movie = movieArray[(indexPath as NSIndexPath).row]
				cell.textLabel?.text = movie?.tituloDePelicula
				cell.detailTextLabel?.text = movie?.descripcionPelicula
				// imagen de la pelíucla
				if (movie?.imagenDePelicula) != nil {
					let _ = iTunesApiClient.getArtworkImage { (imageData, error) in
						if let image = UIImage(data: imageData!) {
							DispatchQueue.main.async {
								cell.imageView!.image = image
								debugPrint("👈\(image)")
							}
						} else {
							print(error ?? "empty error")
						}
					}
				}
		
			default:
				print("")
			}
		
		
		// devuelve la celda ya configurada
		return cell
		
		}
	
	}


//*****************************************************************
// MARK: - Table View Delegate Methods
//*****************************************************************

	extension MediaListViewContoller: UITableViewDelegate {
	
	// task: navegar hacia el detalle de la película (de acuerdo al listado de películas actual)
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		// test
		debugPrint("la fila \(indexPath) ha sido seleccionada")
		
		let storyboardId = "media detail"
		let controller = storyboard!.instantiateViewController(withIdentifier: storyboardId) as! DetailMediaViewController
		navigationController!.pushViewController(controller, animated: true)
	}
	

}

//*****************************************************************
// MARK: - Search Methods
//*****************************************************************

extension MediaListViewContoller:  UISearchResultsUpdating, UISearchBarDelegate  {

	
	
	func updateSearchResults(for searchController: UISearchController) {
		
	
	}
	
	// task: decirle al delegado que el index del botón de ´scope´ cambió
	func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
		
		// test
		debugPrint("decirle al controller que el índice del botón de ´scope´ cambió")
		debugPrint("😠 el scope seleccionado es el: \(selectedScope)")
		
		// MARK: update navigation title item
		switch selectedScope {
			
		case 0:
			self.navigationItem.title = "Music"
			debugPrint("la scope de Music actualmente")
			getMusic()
			
		case 1:
			self.navigationItem.title = "TV Show"
			debugPrint("la scope de TV Shows actualmente")
			getTVShows()
		case 2:
			self.navigationItem.title = "Movie"
			debugPrint("la scope de Movie actualmente")
			getMovies()
			
		default:
			print("")
		}
	}

}
