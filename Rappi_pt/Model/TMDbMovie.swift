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
Un objeto preparado para recibir ciertos datos de las películas.

valores buscados 🔎 a extraer y almacenar 📦
-title
-id
-poster path
-release year
*/

struct TMDbMovie {
	
	//*****************************************************************
	// MARK: - Properties
	//*****************************************************************
	
	let title: String
	let id: Int
	let posterPath: String?
	let releaseYear: String?
	let overview: String?
	
	//*****************************************************************
	// MARK: - Initializers
	//*****************************************************************
	
	// construye el objeto 'TMDbMovie' desde un diccionario  👈
	init(dictionary: [String:AnyObject]) {
		title = dictionary[TMDbClient.JSONResponseKeys.MovieTitle] as! String // "title"
		id = dictionary[TMDbClient.JSONResponseKeys.MovieID] as! Int // "id"
		posterPath = dictionary[TMDbClient.JSONResponseKeys.MoviePosterPath] as? String // "poster_path"
		overview = dictionary[TMDbClient.JSONResponseKeys.MovieOverview] as? String // "poster_path"
		
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
		
		// iterate through array of dictionaries, each Movie is a dictionary
		for result in results {
			movies.append(TMDbMovie(dictionary: result))
		}
		
		return movies
	}
}


//*****************************************************************
// MARK: - Protocol Extension
//*****************************************************************

extension TMDbMovie: Equatable {}

func ==(lhs: TMDbMovie, rhs: TMDbMovie) -> Bool {
	return lhs.id == rhs.id
}

