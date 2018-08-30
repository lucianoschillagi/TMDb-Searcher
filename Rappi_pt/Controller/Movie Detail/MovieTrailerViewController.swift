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
	
	// esconde la barra de estado
	override var prefersStatusBarHidden: Bool {
		return true
	}
	
	
	//*****************************************************************
	// MARK: - IBOutlets
	//*****************************************************************

	@IBOutlet weak var videoView: YouTubePlayerView!	
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	
	
	//*****************************************************************
	// MARK: - VC Life Cycle
	//*****************************************************************

    override func viewDidLoad() {
        super.viewDidLoad()

			startActivityIndicator()
			startRequest()
			
			
    }
	
	//*****************************************************************
	// MARK: - Networking
	//*****************************************************************
	
	// task: obtener los datos para solicitar el trailer de la película
	func startRequest() {
		//TODO: refactorizar luego este método
		
	
		var movieId: String = String()
		
		if let selectedMovieId = selectedMovie?.id {
			movieId = String(selectedMovieId)
		}
		

		let videoMethod = TMDbClient.Methods.SearchMovie + movieId + TMDbClient.Methods.SearchVideo
		
		// networking 🚀
		TMDbClient.getMovieTrailer (videoMethod){ (success, videoTrailer, error) in
			
			// TODO: if success...
			var videosKey: [String] = []
			var oficialVideoKey: String = String()
			
			// dispatch
			DispatchQueue.main.async {
				
				// si la solicitud fue exitosa
				if success {
					
					self.stopActivityIndicator()
					
					// comprueba si el 'popularMovies' recibido contiene algún valor
					if let videoTrailer = videoTrailer {
						// si es así, se lo asigna a la propiedad ´popularMovies´
						for item in videoTrailer {
							videosKey.append(item.videoKey!)
						}
						
						// TODO: falta seguridad!!!
						oficialVideoKey = videosKey.first!
						debugPrint("🎬\(oficialVideoKey)")
						
						let youtube = TMDbClient.Constants.YouTubeBaseURL
						// url trailer youtube 👈
						var urlTrailerYouTube = "\(youtube)\(oficialVideoKey)"
						debugPrint("⚽️\(urlTrailerYouTube)")
						self.videoView.loadVideoID(oficialVideoKey)
					}
						
				} else {
					// si devuelve un error
					//self.displayAlertView("Error Request", error)
				}
			}
		}
	} // end func
	
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
	
	
} // end class
