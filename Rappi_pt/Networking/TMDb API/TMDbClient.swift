//
//  TMDBClient.swift
//  Rappi_pt
//
//  Created by Luciano Schillagi on 18/08/2018.
//  Copyright © 2018 luko. All rights reserved.
//

/* Networking */

import Foundation
import Alamofire

/* Abstract:

*/
  
class TMDbClient: NSObject {
	
	//*****************************************************************
	// MARK: - Initializers
	//*****************************************************************
	
	override init() {
		super.init()
	}
	
	//*****************************************************************
	// MARK: - Properties
	//*****************************************************************
	
	// shared session
	var session = URLSession.shared

	
	//*****************************************************************
	// MARK: - Networking Methods
	//*****************************************************************
	
//	// task: obtener las películar populares de TMDb
//	// MARK: Popular Movies
//	static func getPopularMovies(_ completionHandlerForGetPopularMovies: @escaping ( _ success: Bool, _ popularMovies: PopularMovies?, _ errorString: String?) -> Void) {
//		
//		// 1. realiza la llamada a la API, a través de la función request() de Alamofire, utilizando la URL de Iguana Fix (Apiary) 🚀
//		Alamofire.request("https://api.themoviedb.org/3/movie/popular?api_key=0942529e191d0558f888245403b4dca7&language=en-US&page=1").responseJSON { response in
//			
//			// response status code
//			if let status = response.response?.statusCode {
//				switch(status){
//				case 200:
//					print("example success")
//				default:
//					let errorMessage = "error with response status: \(status)"
//					//completionHandlerForContactObject(false, nil, errorMessage)
//				}
//			}
//			// 2.  almacena la respuesta del servidor (response.result.value) en la constante 'jsonObjectResult' 📦
//			if let jsonObjectResult = response.result.value {
//				
//				debugPrint("\(jsonObjectResult)")
//				
//				// 3. almacena el resultado de la solicitud en la constante 'resultsContacts'
//				let resultsPopularMovies = PopularMovies.popularMoviesFromResults(jsonObjectResult as! [String : AnyObject])
//				// le pasa al completion handler el objeto recibido 'resultsPopularMovies' y que la solcitud fue exitosa
//				completionHandlerForGetPopularMovies(true, resultsPopularMovies, nil)
//				
//			}
//			
//		}
//		
//	}

	
	// MARK: Top Rated Movies
	// task: obtener las películar mejor ranqueadas de TMDb
	static func getTopRatedMovies(_ completionHandlerForTopRatedMovies: @escaping ( _ success: Bool, _ topRatedMovies: TopRatedMovies?, _ errorString: String?) -> Void) {
		
		// 1. realiza la llamada a la API, a través de la función request() de Alamofire, utilizando la URL de Iguana Fix (Apiary) 🚀
		Alamofire.request("https://api.themoviedb.org/3/movie/top_rated?api_key=0942529e191d0558f888245403b4dca7&language=en-US&page=1").responseJSON { response in
			
			// response status code
			if let status = response.response?.statusCode {
				switch(status){
				case 200:
					print("example success")
				default:
					let errorMessage = "error with response status: \(status)"
					//completionHandlerForContactObject(false, nil, errorMessage)
				}
			}
			// 2.  almacena la respuesta del servidor (response.result.value) en la constante 'jsonObjectResult' 📦
			if let jsonObjectResult = response.result.value {
				
				debugPrint("\(jsonObjectResult)")
				
				// 3. almacena el resultado de la solicitud en la constante 'resultsContacts'
				let resultsTopRatedMovies = TopRatedMovies.topRatedMoviesFromResults(jsonObjectResult as! [String:AnyObject])
				// le pasa al completion handler el objeto recibido 'resultContacts' y que la solcitud fue exitosa
				completionHandlerForTopRatedMovies(true, resultsTopRatedMovies, nil)
				
			}
			
		}
		
	}
	
	
	// MARK: Upcoming Movies
	// task: obtener las películas por venir de TMDb
	static func getUpcomingMovies(_ completionHandlerForUpcomingMovies: @escaping ( _ success: Bool, _ upcomingMovies: UpcomingMovies?, _ errorString: String?) -> Void) {
		
		// 1. realiza la llamada a la API, a través de la función request() de Alamofire 🚀
		Alamofire.request("https://api.themoviedb.org/3/movie/popular?api_key=0942529e191d0558f888245403b4dca7&language=en-US&page=1").responseJSON { response in
			
			// response status code
			if let status = response.response?.statusCode {
				switch(status){
				case 200:
					print("example success")
				default:
					let errorMessage = "error with response status: \(status)"
					//completionHandlerForContactObject(false, nil, errorMessage)
				}
			}
			// 2.  almacena la respuesta del servidor (response.result.value) en la constante 'jsonObjectResult' 📦
			if let jsonObjectResult = response.result.value {
				
				debugPrint("\(jsonObjectResult)")
				
				// 3. almacena el resultado de la solicitud en la constante 'resultsContacts'
				let resultsUpcomingMovies = UpcomingMovies.upcomingMoviesFromResults(jsonObjectResult as! [String:AnyObject])
				// le pasa al completion handler el objeto recibido 'resultsUpcomingMovies' y que la solcitud fue exitosa
				completionHandlerForUpcomingMovies(true, resultsUpcomingMovies, nil)
				
			}
			
		}
		
	}
	
	
	
	
	
} // end class
