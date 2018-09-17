//
//  MovieTrailerViewController.swift
//  Rappi_pt
//
//  Created by Luciano Schillagi on 28/08/2018.
//  Copyright © 2018 luko. All rights reserved.
//

/* Controller */

import UIKit
import YouTubePlayer_Swift

/* Abstract:
Una pantalla que muestra el trailer de la película seleccionada.
*/

class MovieTrailerViewController: UIViewController {
	
	//*****************************************************************
	// MARK: - Properties
	//*****************************************************************
	
	var selectedMovie: TMDbMovie?
	
	var movieTrailersArray: [TMDbMovie]?
	var firstTrailerArray: [TMDbMovie] = []
	
	// esconde la barra de estado
	override var prefersStatusBarHidden: Bool { return true }
	
	//*****************************************************************
	// MARK: - IBOutlets
	//*****************************************************************

	@IBOutlet weak var movieTrailerVideo: YouTubePlayerView!	
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	
	//*****************************************************************
	// MARK: - VC Life Cycle
	//*****************************************************************

    override func viewDidLoad() {
        super.viewDidLoad()
			startActivityIndicator()
			showTrailer()
    }
	
	//*****************************************************************
	// MARK: - Networking
	//*****************************************************************
	
	// task: mostrar el trailer de la película en youtube
	func showTrailer() {
		for trailer in movieTrailersArray! { firstTrailerArray.append(trailer)}
		let firstTrailer = firstTrailerArray.first
		let oficialVideoKey = firstTrailer?.videoKey; stopActivityIndicator()
		self.movieTrailerVideo.loadVideoID(oficialVideoKey!)
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
