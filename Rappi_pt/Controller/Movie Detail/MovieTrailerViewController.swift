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

	
	
	//*****************************************************************
	// MARK: - VC Life Cycle
	//*****************************************************************

    override func viewDidLoad() {
        super.viewDidLoad()

        startRequest()
			
			//test
			debugPrint("😅 siiii\(selectedMovie?.id)")
			


			
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
		TMDbClient.getMovieTrailer (videoMethod){ (video, error) in
			
			// TODO: if success...
			var videosKey: [String] = []
			var oficialVideoKey: String = String()
			
			for item in video! {
				videosKey.append(item.videoKey!)
			}
			
			// TODO: falta seguridad!!!
			oficialVideoKey = videosKey.first!
			debugPrint("🎬\(oficialVideoKey)")
			
			let youtube = TMDbClient.Constants.YouTubeBaseURL
			
			// url trailer youtube 👈
			var urlTrailerYouTube = "\(youtube)\(oficialVideoKey)"
			debugPrint("⚽️\(urlTrailerYouTube)")
						
			
			self.videoView.playerVars = ["playerInline": 1 as AnyObject,
															"showinfo": 0 as AnyObject,
															"controls": 0 as AnyObject]
			
			//https://www.youtube.com/watch?v=c25GKl5VNeY
			self.videoView.loadVideoID(oficialVideoKey)
		}
		
		
	} // end func
	
	


    

} // end class
