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
	
	// esconde la barra de estado
	override var prefersStatusBarHidden: Bool {
		return true
	}
	
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
			
			debugPrint("😆\(selectedMovie)")
			
			getTitleAndYear()
			configureUIDetail()
			
			
			
			//TODO: obtener la imagen del poster y ponerla en el image view
			// poster path
			if let posterPath = selectedMovie?.posterPath {
				let _ = TMDbClient.getPosterImage(TMDbClient.ParameterValues.posterSizes[2], filePath: posterPath , { (imageData, error) in
					if let image = UIImage(data: imageData!) {
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
	
	
	
} // end class

extension MovieDetailViewController {
	
	// task: inyectar a 'MovieTrailerViewController' el 'selected moview object'
	override func prepare(for segue: UIStoryboardSegue,sender: Any?) {
		
		if segue.identifier == "toTrailer" {
			
			// el destino de la transición, el 'MovieTrailerViewController'
			let trailerVC = segue.destination as! MovieTrailerViewController
			
			// el controlador de datos
			trailerVC.selectedMovie = selectedMovie
			
		}
		
	}
}
