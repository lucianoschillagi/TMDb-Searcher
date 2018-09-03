//
//  TMDbMovie.swift
//  Rappi_pt
//
//  Created by Luciano Schillagi on 23/08/2018.
//  Copyright © 2018 luko. All rights reserved.
//

/* Model */

import Foundation

/* Abstract:
Un objeto preparado para recibir los valores necesarios para construir la lógica de la aplicación.
*/

struct TMDbMovie {
	
	//*****************************************************************
	// MARK: - Properties
	//*****************************************************************
	
	let title: String?
	let movieId: Int?
	let trailerId: Int?
	let posterPath: String?
	let releaseYear: String?
	let overview: String?
	let voteAverage: Double?
	let popularity: Double?
	let videoKey: String?
	
	//*****************************************************************
	// MARK: - Initializers
	//*****************************************************************
	
	// construye el objeto 'TMDbMovie' desde un diccionario  👈
	init(dictionary: [String:AnyObject]) {
		title = dictionary[TMDbClient.JSONResponseKeys.MovieTitle] as? String
		movieId = dictionary[TMDbClient.JSONResponseKeys.MovieID] as? Int
		trailerId = dictionary[TMDbClient.JSONResponseKeys.TrailerID] as? Int
		posterPath = dictionary[TMDbClient.JSONResponseKeys.MoviePosterPath] as? String
		overview = dictionary[TMDbClient.JSONResponseKeys.MovieOverview] as? String
		voteAverage = dictionary[TMDbClient.JSONResponseKeys.MovieAverage] as? Double
		popularity = dictionary[TMDbClient.JSONResponseKeys.MoviePopularity] as? Double
		videoKey = dictionary[TMDbClient.JSONResponseKeys.MovieVideoKey] as? String
		
		if let releaseDateString = dictionary[TMDbClient.JSONResponseKeys.MovieReleaseDate] as? String, releaseDateString.isEmpty == false {
			releaseYear = releaseDateString.substring(to: releaseDateString.characters.index(releaseDateString.startIndex, offsetBy: 4))
		} else {
			releaseYear = ""
		}
	}
	
	//*****************************************************************
	// MARK: - Methods
	//*****************************************************************
	
	// task:
	static func moviesFromResults(_ results: [[String:AnyObject]]) -> [TMDbMovie] {
		
		var movies = [TMDbMovie]()
	
		// itera a través del array de diccionarios, cada ´TMDbMovie´ es un diccionario
		for result in results {
			movies.append(TMDbMovie(dictionary: result))
		}
		
		return movies
	}
	
} // end class

