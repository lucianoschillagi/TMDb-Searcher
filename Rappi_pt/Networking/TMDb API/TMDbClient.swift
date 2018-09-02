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
		
		// 0. total pages random
		let totalPagesRandom = Int.random(in: 1 ..< 306)
		var choosenPage = String(totalPagesRandom)
		
		/* 1. 📞 Realiza la llamada a la API, a través de la función request() de Alamofire 🚀 */
		Alamofire.request(configureUrl(TMDbClient.Methods.SearchPopularMovie, page: choosenPage)).responseJSON { response in
			
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
				
				if let results = jsonObjectResultDictionary[TMDbClient.JSONResponseKeys.Results], let totalPages = jsonObjectResultDictionary[TMDbClient.JSONResponseKeys.TotalPages] {
				
				let resultsFavoriteMovies = TMDbMovie.moviesFromResults(results as! [[String : AnyObject]])
					debugPrint("total de páginas: \(totalPages)")
					
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
	
		// 0. total pages random
		let totalPagesRandom = Int.random(in: 1 ..< 15)
		let choosenPage = String(totalPagesRandom)
		
		/* 1. 📞 Realiza la llamada a la API, a través de la función request() de Alamofire 🚀 */
		Alamofire.request(configureUrl(TMDbClient.Methods.SearchTopRatedMovies, page: choosenPage)).responseJSON { response in
			
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
				
				if let results = jsonObjectResultDictionary[TMDbClient.JSONResponseKeys.Results] {
					
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

		// 0. total pages random
		let totalPagesRandom = Int.random(in: 1 ..< 15)
		let choosenPage = String(totalPagesRandom)
		
		/* 1. 📞 Realiza la llamada a la API, a través de la función request() de Alamofire 🚀 */
		Alamofire.request(configureUrl(TMDbClient.Methods.SearchUpcomingMovies, page: choosenPage)).responseJSON { response in
			
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
	
	// MARK: Get Images
	// task: obtener las imágenes (posters) de las películas
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
	
	
	// MARK: Get Search Movie
	// task: obtener las películas que se correspondan con el texto de búsqueda
	static func getMoviesForSearchString(_ searchString: String, completionHandlerForMovies: @escaping (_ success: Bool, _ result: [TMDbMovie]?, _ error: String?) -> Void)  {
		
		//https://api.themoviedb.org/3/search/movie?api_key=0942529e191d0558f888245403b4dca7&query=Is
		/* 1. 📞 Realiza la llamada a la API, a través de la función request() de Alamofire 🚀 */
		Alamofire.request(configureUrlSearchText(TMDbClient.Methods.SearchTextMovie, searchString: searchString)).responseJSON { response in

		
			// response status code
			if let status = response.response?.statusCode {
				switch(status){
				case 200:
					print("example success")
				default:
					let errorMessage = "error with response status: \(status)"
					completionHandlerForMovies(false, nil, errorMessage)
				}
			}
			
			/* 2. Almacena la respuesta del servidor (response.result.value) en la constante 'jsonObjectResult' 📦 */
			if let jsonObjectResult: Any = response.result.value {
				
				let jsonObjectResultDictionary = jsonObjectResult as! [String:AnyObject]
				
				debugPrint("🤜JSON TEXT SEARCH MOVIES: \(jsonObjectResult)") // JSON obtenido
				
				if let results = jsonObjectResultDictionary[TMDbClient.JSONResponseKeys.Results] {
					
					let resultsMovieTextSearch = TMDbMovie.moviesFromResults(results as! [[String : AnyObject]])
					
					//test
					debugPrint("🤾🏼‍♂️ TMDBMovie...\(resultsMovieTextSearch)")
					
					completionHandlerForMovies(true, resultsMovieTextSearch, nil)
					
				}
			}
			
		}
			
	}
	
	
	// MARK: Get Movie Trailer
	// task: obtener el trailer (video) de una película en particular
	static func getMovieTrailer(_ videoMethod: String, _ completionHandlerForVideo: @escaping (_ success: Bool, _ videoTrailer: [TMDbMovie]?, _ error: String?) -> Void) {
		
		/* 1. 📞 Realiza la llamada a la API, a través de la función request() de Alamofire 🚀 */
		//Alamofire.request(configureUrl(videoMethod)).responseJSON { response in
		Alamofire.request(configureUrl(videoMethod)).responseJSON { response in

			
			// response status code
			if let status = response.response?.statusCode {
				switch(status){
				case 200:
					print("example success")
				default:
					let errorMessage = "error with response status: \(status)"
					completionHandlerForVideo(false, nil, errorMessage)
				}
			}
			
			/* 2. Almacena la respuesta del servidor (response.result.value) en la constante 'jsonObjectResult' 📦 */
			if let jsonObjectResult: Any = response.result.value {
				
				debugPrint("JSON\(jsonObjectResult)")
				
				let jsonObjectResultDictionary = jsonObjectResult as! [String:AnyObject]
				
				debugPrint("JSON DICTIONARY\(jsonObjectResultDictionary)")
				
				// json key 'results' y 'id'
				if let results = jsonObjectResultDictionary[TMDbClient.JSONResponseKeys.Results], let movieId = jsonObjectResultDictionary[TMDbClient.JSONResponseKeys.MovieID] {
					
					debugPrint("Foundation \(movieId)")
					
					// rellena el objeto 'TMBbMovie' con los valores que contiene las keys 'results' y 'id' 🔌
					let resultsVideoMovie = TMDbMovie.moviesFromResults(results as! [[String : AnyObject]])
					//let idVideoMovie = TMDbMovie.moviesFromResults(movieId as! Int)
					
					//test
					// cantidad de trailer que tiene la película solicitada
					debugPrint("Los videos disponibles (trailer) de una película en particular:\(resultsVideoMovie.count)")
					
					// envía el ch los resultados extraídos de esta solicitud (los valores que contiene la key 'results')
					completionHandlerForVideo(true, resultsVideoMovie, nil)
					
				} else {
					completionHandlerForVideo(false, nil, "error")
				}
			}
			
		}
	}
	
	
	//*****************************************************************
	// MARK: - Helpers
	//*****************************************************************
	
	// task: configurar las diversas URLs a enviar en las APi calls
	static func configureUrl(_ methodRequest: String, page: String? = nil, searchString: String? = nil) -> URL {
		
		var components = URLComponents()
		components.scheme = TMDbClient.Constants.ApiScheme
		components.host = TMDbClient.Constants.ApiHost
		components.path = TMDbClient.Constants.ApiPath + methodRequest
		components.queryItems = [URLQueryItem]()
		let queryItem1 = URLQueryItem(name: TMDbClient.ParameterKeys.ApiKey, value: TMDbClient.ParameterValues.ApiKey)
		let queryItem2 = URLQueryItem(name: TMDbClient.ParameterKeys.Language, value: TMDbClient.ParameterValues.Language)
		let queryItem3 = URLQueryItem(name: TMDbClient.ParameterKeys.Page, value: page)
		components.queryItems?.append(queryItem1) // api key
		components.queryItems?.append(queryItem2) // language
		components.queryItems?.append(queryItem3) // page
		
		return components.url!
	}
	
	
	// task: configurar la url para el método 'getMoviesForSearchString'
	static func configureUrlSearchText(_ methodRequest: String, searchString: String?) -> URL {
		
		var components = URLComponents()
		components.scheme = TMDbClient.Constants.ApiScheme
		components.host = TMDbClient.Constants.ApiHost
		components.path = TMDbClient.Constants.ApiPath + methodRequest
		components.queryItems = [URLQueryItem]()
		let queryItem1 = URLQueryItem(name: TMDbClient.ParameterKeys.ApiKey, value: TMDbClient.ParameterValues.ApiKey)
		let queryItem2 = URLQueryItem(name: TMDbClient.ParameterKeys.Query, value: searchString)
		components.queryItems?.append(queryItem1) // api key
		components.queryItems?.append(queryItem2) // query
		
		return components.url!
	}
	
	

} // end class
