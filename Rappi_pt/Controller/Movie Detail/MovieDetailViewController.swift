//
//  MovieDetailViewController.swift
//  Rappi_pt
//
//  Created by Luciano Schillagi on 19/08/2018.
//  Copyright © 2018 luko. All rights reserved.
//

/* Controller */

import UIKit

/* Abstract:
Una pantalla que muestra el detalle de la película seleccionada en la pantalla anterior.
*/

class MovieDetailViewController: UIViewController {
	
	//*****************************************************************
	// MARK: - Properties
	//*****************************************************************
	
	// la película seleccionada en la pantalla anterior
	var selectedMovie: TMDbMovie?
	
	// el trailer que se mostrará en la siguiente pantalla
	var movieTrailers = [TMDbMovie]()
	
	// esconde la barra de estado
	override var prefersStatusBarHidden: Bool { return true }
	
	//*****************************************************************
	// MARK: - IBOutlets
	//*****************************************************************
	
	@IBOutlet weak var moviePoster: UIImageView!
	@IBOutlet weak var movieOverview: UITextView!
	@IBOutlet weak var movieVoteAverage: UILabel!
	@IBOutlet weak var trailerButton: UIButton!
	
	//*****************************************************************
	// MARK: - VC Life Cycle
	//*****************************************************************

    override func viewDidLoad() {
        super.viewDidLoad()
			getTitleAndYear(); configureUIDetail(); getPosterImage()
    }
	
	// task: obtener la imagen del poster y ponerla en el image view
	func getPosterImage() {
		
		if let posterPath = selectedMovie?.posterPath {
			let _ = TMDbClient.getPosterImage(TMDbClient.ParameterValues.posterSizes[2], filePath: posterPath , { (imageData, error) in
				if UIImage(data: imageData!) != nil {
					DispatchQueue.main.async {
						self.moviePoster.contentMode = UIView.ContentMode.scaleAspectFit
						self.moviePoster.image = UIImage(data: imageData!)
					}
				} else {
					print(error ?? "empty error")
				}
			})
		}
	}
	
	//*****************************************************************
	// MARK: - IBActions
	//*****************************************************************
	
	@IBAction func trailerButtonPressed(_ sender: UIButton) {
		
		var movieId: String = String()
		
		if let selectedMovieId = selectedMovie?.movieId { movieId = String(selectedMovieId) }
		
		let videoMethod = TMDbClient.Methods.SearchMovie + movieId + TMDbClient.Methods.SearchVideo
		
		// networking 🚀
		TMDbClient.getMovieTrailer (videoMethod){ (success, movieTrailers, error) in
			
			DispatchQueue.main.async {
				
				if success {
					// comprueba si la película tiene un trailer disponible
					if movieTrailers?.count == 0 {
						self.displayAlertView("Trailer No Disponible", "Esta película aún no tiene trailer 😕")
					} else {
						// si tiene trailers disponbiles
						for item in movieTrailers! {
							// los agrega en el array 'firstTrailer'...
							self.movieTrailers.append(item)
						}
						// ... y los envía a la siguiente pantalla
						self.performSegue(withIdentifier: "toTrailer", sender: nil)
					}
				} else {
					debugPrint(error ?? "")
				}
			}
		} // end trailing closure
	}
	
	//*****************************************************************
	// MARK: - Configure UI Elements
	//*****************************************************************
	
	// task: obtener el título y el año de lanzamiento de la película
	func getTitleAndYear() {
		
		var title = selectedMovie?.title
		var releaseYear = selectedMovie?.releaseYear
		
		if let titleString = title, let yearString = releaseYear {
			title = titleString
			releaseYear = yearString
			var titleReleaseYear = titleString + " (\(yearString))"
			self.title = titleReleaseYear
		}
	}
	
	// task: configurar los elementos que componene la interfaz de usuario del detalle de la película
	func configureUIDetail() {
		
		// pone el overview
		movieOverview.text = selectedMovie?.overview
		// el promedio de votos
		let voteAverage = "Vote Average: \(Float((selectedMovie?.voteAverage)!))"
		movieVoteAverage.text = String(voteAverage)
		
	}
	
	//*****************************************************************
	// MARK: - Alert View
	//*****************************************************************
	
	/**
	Muestra al usuario un mensaje acerca de porqué la solicitud falló.
	
	- Parameter title: El título del error.
	- Parameter message: El mensaje acerca del error.
	
	*/
	func displayAlertView(_ title: String?, _ error: String?) {
		
		// si ocurre un error en la solicitud, mostrar una vista de alerta!
		if error != nil {
			
			let alertController = UIAlertController(title: title, message: error, preferredStyle: .alert)
			let OKAction = UIAlertAction(title: "OK", style: .default) { action in
			}
			
			alertController.addAction(OKAction)
			self.present(alertController, animated: true) {}
		}
	}
	
} // end class

//*****************************************************************
// MARK: - Segue
//*****************************************************************

extension MovieDetailViewController {
	
	// task: inyectar a 'MovieTrailerViewController' los objetos 'selected movie' y 'movieTrailers' 
	override func prepare(for segue: UIStoryboardSegue,sender: Any?) {

		if segue.identifier == "toTrailer" {

			// el destino de la transición, el 'MovieTrailerViewController'
			let trailerVC = segue.destination as! MovieTrailerViewController

			// los datos a pasar
			trailerVC.selectedMovie = selectedMovie
			trailerVC.movieTrailersArray = movieTrailers

		}
	}
}
