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
-overview
-vote average
-popularity
-video key
*/

struct TMDbMovie {
	
	//*****************************************************************
	// MARK: - Properties
	//*****************************************************************
	
	let title: String?
	let id: Int?
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
		title = dictionary[TMDbClient.JSONResponseKeys.MovieTitle] as? String // "title"
		id = dictionary[TMDbClient.JSONResponseKeys.MovieID] as? Int // "id"
		posterPath = dictionary[TMDbClient.JSONResponseKeys.MoviePosterPath] as? String // "poster_path"
		overview = dictionary[TMDbClient.JSONResponseKeys.MovieOverview] as? String // "poster_path"
		voteAverage = dictionary[TMDbClient.JSONResponseKeys.MovieAverage] as? Double // "vote_average"
		popularity = dictionary[TMDbClient.JSONResponseKeys.MoviePopularity] as? Double // "popularity"
		videoKey = dictionary[TMDbClient.JSONResponseKeys.MovieVideoKey] as? String // "key"
		
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


/*
Example Popular Movie Object

{
"vote_count": 1859,
"id": 19404,
"video": false,
"vote_average": 9.3,
"title": "Dilwale Dulhania Le Jayenge",
"popularity": 10.45,
"poster_path": "/uC6TTUhPpQCmgldGyYveKRAu8JN.jpg",
"original_language": "hi",
"original_title": "दिलवाले दुल्हनिया ले जायेंगे",
"genre_ids": [
35,
18,
10749
],
"backdrop_path": "/nl79FQ8xWZkhL3rDr1v2RFFR6J0.jpg",
"adult": false,
"overview": "Raj is a rich, carefree, happy-go-lucky second generation NRI. Simran is the daughter of Chaudhary Baldev Singh, who in spite of being an NRI is very strict about adherence to Indian values. Simran has left for India to be married to her childhood fiancé. Raj leaves for India with a mission at his hands, to claim his lady love under the noses of her whole family. Thus begins a saga.",
"release_date": "1995-10-20"
},

*/

/*
Example Top Rated Movie Object

{
"vote_count": 191,
"id": 500664,
"video": false,
"vote_average": 7.6,
"title": "Upgrade",
"popularity": 63.334,
"poster_path": "/adOzdWS35KAo21r9R4BuFCkLer6.jpg",
"original_language": "en",
"original_title": "Upgrade",
"genre_ids": [
28,
53,
878
],
"backdrop_path": "/22cUd4Yg5euCxIwWzXrL4m4otkU.jpg",
"adult": false,
"overview": "A brutal mugging leaves Grey Trace paralyzed in the hospital and his beloved wife dead. A billionaire inventor soon offers Trace a cure — an artificial intelligence implant called STEM that will enhance his body. Now able to walk, Grey finds that he also has superhuman strength and agility — skills he uses to seek revenge against the thugs who destroyed his life.",
"release_date": "2018-06-01"
},

*/


/*
Example Upcoming Movie Object

{
"vote_count": 191,
"id": 500664,
"video": false,
"vote_average": 7.6,
"title": "Upgrade",
"popularity": 63.334,
"poster_path": "/adOzdWS35KAo21r9R4BuFCkLer6.jpg",
"original_language": "en",
"original_title": "Upgrade",
"genre_ids": [
28,
53,
878
],
"backdrop_path": "/22cUd4Yg5euCxIwWzXrL4m4otkU.jpg",
"adult": false,
"overview": "A brutal mugging leaves Grey Trace paralyzed in the hospital and his beloved wife dead. A billionaire inventor soon offers Trace a cure — an artificial intelligence implant called STEM that will enhance his body. Now able to walk, Grey finds that he also has superhuman strength and agility — skills he uses to seek revenge against the thugs who destroyed his life.",
"release_date": "2018-06-01"
},

*/
