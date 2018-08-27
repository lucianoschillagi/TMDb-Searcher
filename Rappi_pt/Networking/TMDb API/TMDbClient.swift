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
	static func getPopularMovies(_ completionHandlerForGetPopularMovies: @escaping ( _ success: Bool, _ popularMovies: [TMDbMovie]?, _ errorString: String?) -> Void) {
		
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
			if let jsonObjectResult: Any = response.result.value {
				
				let jsonObjectResultDictionary = jsonObjectResult as! [String:AnyObject]
				
				debugPrint("🤜JSON POPULAR MOVIES: \(jsonObjectResult)") // JSON obtenido
				
				if let results = jsonObjectResultDictionary["results"] {
				
				let resultsFavoriteMovies = TMDbMovie.moviesFromResults(results as! [[String : AnyObject]])
					
					//test
					debugPrint("🤾🏼‍♂️ TMDBMovie...\(resultsFavoriteMovies)")

				completionHandlerForGetPopularMovies(true, resultsFavoriteMovies, nil)
			
				}
			}
		}
	}
	
	
	// MARK: Top Rated Movies
	// task: obtener las películar mejor ranqueadas de TMDb
	static func getTopRatedMovies(_ completionHandlerForTopRatedMovies: @escaping ( _ success: Bool, _ topRatedMovies:  [TMDbMovie]?, _ errorString: String?) -> Void) {
		
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
			if let jsonObjectResult: Any = response.result.value {
				
				let jsonObjectResultDictionary = jsonObjectResult as! [String:AnyObject]
				
				debugPrint("🤜JSON POPULAR MOVIES: \(jsonObjectResult)") // JSON obtenido
				
				if let results = jsonObjectResultDictionary["results"] {
					
					let resultsTopRatedMovies = TMDbMovie.moviesFromResults(results as! [[String : AnyObject]])
					
					//test
					debugPrint("🤾🏼‍♂️ TMDBMovie...\(resultsTopRatedMovies)")
					
					completionHandlerForTopRatedMovies(true, resultsTopRatedMovies, nil)
					
				}
			}
		}
		
	}
	
	
	// MARK: Upcoming Movies
	// task: obtener las películas por venir de TMDb
	static func getUpcomingMovies(_ completionHandlerForUpcomingMovies: @escaping ( _ success: Bool, _ upcomingMovies: [TMDbMovie]?, _ errorString: String?) -> Void) {

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
			if let jsonObjectResult: Any = response.result.value {
				
				let jsonObjectResultDictionary = jsonObjectResult as! [String:AnyObject]
				
				debugPrint("🥋JSON POPULAR MOVIES: \(jsonObjectResult)") // JSON obtenido
				
				if let results = jsonObjectResultDictionary["results"] {
					
					let resultsUpcomingdMovies = TMDbMovie.moviesFromResults(results as! [[String : AnyObject]])
					
					//test
					debugPrint("🤾🏼‍♂️ TMDBMovie...\(resultsUpcomingdMovies)")
					
					completionHandlerForUpcomingMovies(true, resultsUpcomingdMovies, nil)
					
				}
			}
		}
	}
	
	
	
//	func taskForGETImage(_ size: String, filePath: String, completionHandlerForImage: @escaping (_ imageData: Data?, _ error: NSError?) -> Void) -> URLSessionTask {
//
//		/* 1. Set the parameters */
//		// There are none...
//
//		/* 2/3. Build the URL and configure the request */
//		let baseURL = URL(string: config.baseImageURLString)!
//		let url = baseURL.appendingPathComponent(size).appendingPathComponent(filePath)
//		let request = URLRequest(url: url)
//
//		/* 4. Make the request */
//		let task = session.dataTask(with: request) { (data, response, error) in
//
//			func sendError(_ error: String) {
//				print(error)
//				let userInfo = [NSLocalizedDescriptionKey : error]
//				completionHandlerForImage(nil, NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
//			}
//
//			/* GUARD: Was there an error? */
//			guard (error == nil) else {
//				sendError("There was an error with your request: \(error!)")
//				return
//			}
//
//			/* GUARD: Did we get a successful 2XX response? */
//			guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
//				sendError("Your request returned a status code other than 2xx!")
//				return
//			}
//
//			/* GUARD: Was there any data returned? */
//			guard let data = data else {
//				sendError("No data was returned by the request!")
//				return
//			}
//
//			/* 5/6. Parse the data and use the data (happens in completion handler) */
//			completionHandlerForImage(data, nil)
//		}
//
//		/* 7. Start the request */
//		task.resume()
//
//		return task
//	}
//
	
	
	// MARK: Get Images
	// task: obtener las imágenes (posters) de las películas
	
//	Images
//	You'll notice that movie, TV and person objects contain references to different file paths. In order to generate a fully working image URL, you'll need 3 pieces of data. Those pieces are a base_url, a file_size and a file_path.
//
//	The first two pieces can be retrieved by calling the  API and the third is the file path you're wishing to grab on a particular media object. Here's what a full image URL looks like if the poster_path of /kqjL17yufvn9OVLyXYpvtyrFfak.jpg was returned for a movie, and you were looking for the w500 size:
//
//	https://image.tmdb.org/t/p/w500/kqjL17yufvn9OVLyXYpvtyrFfak.jpg
	
	// base_url: https://image.tmdb.org/t/p
	// file_size: /w500
	// file_path: /kqjL17yufvn9OVLyXYpvtyrFfak.jpg
	
	static func getPosterImage(_ size: String, filePath: String, _ completionHandlerForPosterImage: @escaping ( _ imageData: Data?, _ error: String?) -> Void) {
		
		/* 2/3. Build the URL and configure the request */
		let baseURL = URL(string: TMDbClient.ParameterValues.secureBaseImageURLString)!
		let url = baseURL.appendingPathComponent(size).appendingPathComponent(filePath)
		let request = URLRequest(url: url)
		
		

		/* 1. 📞 Realiza la llamada a la API, a través de la función request() de Alamofire 🚀 */
		Alamofire.request(request).responseData { response in
			
			// response status code
			if let status = response.response?.statusCode {
				switch(status){
				case 200:
					print("example success")
				default:
					let errorMessage = "error with response status: \(status)"
					completionHandlerForPosterImage(nil, errorMessage)
				}
			}
			
			 /* 2. Almacena la respuesta del servidor (response.result.value) en la constante 'dataObjectResult' 📦 */
			if let dataObjectResult: Any = response.result.value {
				
				let dataObjectResult = dataObjectResult as! Data
		
				completionHandlerForPosterImage(dataObjectResult, nil)
				
				//test
				debugPrint("Los datos de la imagen: \(dataObjectResult)")
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
