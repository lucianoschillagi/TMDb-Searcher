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
Esta clase agrupa los métodos necesarios para interactuar con la API de TMDb.
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
	
	// MARK: Popular Movies
	// task: obtener las películas máspopulares de TMDb
	static func getPopularMovies(_ completionHandlerForGetPopularMovies: @escaping ( _ success: Bool, _ popularMovies: PopularMovies?, _ errorString: String?) -> Void) {
		
		/* 1. 📞 Realiza la llamada a la API, a través de la función request() de Alamofire 🚀 */
		Alamofire.request(configureUrl(TMDbClient.Methods.SearchPopularMovie)).responseJSON { response in
			
			// response status code
			if let status = response.response?.statusCode {
				switch(status){
				case 200:
					print("example success")
				default:
					let errorMessage = "error with response status: \(status)"
					completionHandlerForGetPopularMovies(false, nil, errorMessage)
				}
			}
			
			/* 2. Almacena la respuesta del servidor (response.result.value) en la constante 'jsonObjectResult' 📦 */
			if let jsonObjectResult = response.result.value {
				
				debugPrint("🤜JSON POPULAR MOVIES: \(jsonObjectResult)") // JSON obtenido
				
				/* 3. Almacena el resultado de la solicitud en la constante 'resultsPopularMovies' 📦 */
				let resultsPopularMovies = PopularMovies.popularMoviesFromResults(jsonObjectResult as! [String : AnyObject])
				
				debugPrint("👐FOUNDATION POPULAR MOVIES: \(resultsPopularMovies)") // JSON convertido a FOUNDATION
				
				/* 4.  Pasa al completion handler el objeto recibido 'resultsPopularMovies' y que la solcitud fue exitosa ⬆ */
				completionHandlerForGetPopularMovies(true, resultsPopularMovies, nil)
				
			}
			
		}
		
	}

	
	// MARK: Top Rated Movies
	// task: obtener las películar mejor ranqueadas de TMDb
	static func getTopRatedMovies(_ completionHandlerForTopRatedMovies: @escaping ( _ success: Bool, _ topRatedMovies: TopRatedMovies?, _ errorString: String?) -> Void) {
		
		/* 1. 📞 Realiza la llamada a la API, a través de la función request() de Alamofire 🚀 */
		Alamofire.request(configureUrl(TMDbClient.Methods.SearchTopRatedMovies)).responseJSON { response in
			
			// response status code
			if let status = response.response?.statusCode {
				switch(status){
				case 200:
					print("example success")
				default:
					let errorMessage = "error with response status: \(status)"
					completionHandlerForTopRatedMovies(false, nil, errorMessage)
				}
			}
			/* 2. Almacena la respuesta del servidor (response.result.value) en la constante 'jsonObjectResult' 📦 */
			if let jsonObjectResult = response.result.value {
				
				debugPrint("\(jsonObjectResult)")
				
				/* 3. Almacena el resultado de la solicitud en la constante 'resultsPopularMovies' 📦 */
				let resultsTopRatedMovies = TopRatedMovies.topRatedMoviesFromResults(jsonObjectResult as! [String:AnyObject])
				
				/* 4.  Pasa al completion handler el objeto recibido 'resultsPopularMovies' y que la solcitud fue exitosa ⬆ */
				completionHandlerForTopRatedMovies(true, resultsTopRatedMovies, nil)
				
			}
			
		}
		
	}
	
	
	// MARK: Upcoming Movies
	// task: obtener las películas por venir de TMDb
	static func getUpcomingMovies(_ completionHandlerForUpcomingMovies: @escaping ( _ success: Bool, _ upcomingMovies: UpcomingMovies?, _ errorString: String?) -> Void) {

		/* 1. 📞 Realiza la llamada a la API, a través de la función request() de Alamofire 🚀 */
		Alamofire.request(configureUrl(TMDbClient.Methods.SearchUpcomingMovies)).responseJSON { response in

			// response status code
			if let status = response.response?.statusCode {
				switch(status){
				case 200:
					print("example success")
				default:
					let errorMessage = "error with response status: \(status)"
					completionHandlerForUpcomingMovies(false, nil, errorMessage)
				}
			}
			/* 2. Almacena la respuesta del servidor (response.result.value) en la constante 'jsonObjectResult' 📦 */
			if let jsonObjectResult = response.result.value {
				
				debugPrint("\(jsonObjectResult)")
				
				/* 3. Almacena el resultado de la solicitud en la constante 'resultsPopularMovies' 📦 */
				let resultsUpcomingMovies = UpcomingMovies.upcomingMoviesFromResults(jsonObjectResult as! [String:AnyObject])
				
				/* 4.  Pasa al completion handler el objeto recibido 'resultsPopularMovies' y que la solcitud fue exitosa ⬆ */
				completionHandlerForUpcomingMovies(true, resultsUpcomingMovies, nil)
				
			}
			
		}
		
	}
	
	
	//*****************************************************************
	// MARK: - Helpers
	//*****************************************************************
	
	// task: configurar las diversas URLs a enviar en las APi calls
	static func configureUrl(_ methodRequest: String) -> URL {

		var components = URLComponents()
		components.scheme = TMDbClient.Constants.ApiScheme
		components.host = TMDbClient.Constants.ApiHost
		components.path = TMDbClient.Constants.ApiPath + methodRequest
		components.queryItems = [URLQueryItem]()
		let queryItem1 = URLQueryItem(name: TMDbClient.ParameterKeys.ApiKey, value: TMDbClient.ParameterValues.ApiKey)
		let queryItem2 = URLQueryItem(name: TMDbClient.ParameterKeys.Language, value: TMDbClient.ParameterValues.Language)
		let queryItem3 = URLQueryItem(name: TMDbClient.ParameterKeys.Page, value: TMDbClient.ParameterValues.Page)
		components.queryItems!.append(queryItem1)
		components.queryItems?.append(queryItem2)
		components.queryItems?.append(queryItem3)
		
		return components.url!
	}
	
	

} // end class