//
//  TMDBConstants.swift
//  Rappi_pt
//
//  Created by Luciano Schillagi on 19/08/2018.
//  Copyright © 2018 luko. All rights reserved.
//

/* Networking */

import Foundation

/* Abstract:
Almacena valores a usar en las api calls.
*/

extension TMDbClient {
	
	//*****************************************************************
	// MARK: - Constants
	//*****************************************************************
	
	struct Constants {
		
		// MARK: API Key
		static let ApiKey = "0942529e191d0558f888245403b4dca7" // 🔑
		
		// MARK: URLs
		static let ApiScheme = "https"
		static let ApiHost = "api.themoviedb.org"
		static let ApiPath = "/3"
	
		// MARK: Youtbe
		static let YouTubeBaseURL = "https://www.youtube.com/watch?v="
	}
	
	//*****************************************************************
	// MARK: - Methods
	//*****************************************************************
	struct Methods {
		
		// MARK: Search
		static let SearchPopularMovie = "/movie/popular"
		static let SearchTopRatedMovies = "/movie/top_rated"
		static let SearchUpcomingMovies = "/movie/upcoming"
		static let SearchMovie = "/movie/"
		static let SearchVideo = "/videos"
		static let SearchTextMovie = "/search/movie"
	}
	
	//*****************************************************************
	// MARK: - URL Keys
	//*****************************************************************
	
	struct URLKeys {
		static let UserID = "id"
	}
	
	//*****************************************************************
	// MARK: - Parameter Keys
	//*****************************************************************
	
	struct ParameterKeys {
		static let ApiKey = "api_key"
		static let Language = "language"
		static let Page = "page"
		static let Query = "query"
	}
	
	//*****************************************************************
	// MARK: - Parameter Values
	//*****************************************************************
	
	struct ParameterValues {
		
		static let ApiKey = "0942529e191d0558f888245403b4dca7"
		static let Language = "en-US"
		
		// MARK: Get Poster Images
		static let secureBaseImageURLString = "https://image.tmdb.org/t/p/"
		static let posterSizes = ["w92", "w154", "w185", "w342", "w500", "w780", "original"]
	}

	//*****************************************************************
	// MARK: - JSON Body Keys
	//*****************************************************************
	
	struct JSONBodyKeys {
		static let MediaType = "media_type"
		static let MediaID = "media_id"
		static let Favorite = "favorite"
		static let Watchlist = "watchlist"
	}
	
	//*****************************************************************
	// MARK: - JSON Response Keys
	//*****************************************************************
	
	struct JSONResponseKeys {
		
		// MARK: General
		static let StatusMessage = "status_message"
		static let StatusCode = "status_code"

		// MARK: Config
		static let ConfigBaseImageURL = "base_url"
		static let ConfigSecureBaseImageURL = "secure_base_url"
		static let ConfigImages = "images"
		static let ConfigPosterSizes = "poster_sizes"
		static let ConfigProfileSizes = "profile_sizes"
		
		// MARK: Movies
		static let Results = "results"
		static let TotalPages = "total_pages"

		// MARK: Movie
		static let MovieID = "id"
		static let TrailerID = "id"
		static let MovieTitle = "title"
		static let MoviePosterPath = "poster_path"
		static let MovieReleaseDate = "release_date"
		static let MovieReleaseYear = "release_year"
		static let MovieOverview = "overview"
		static let MovieResults = "results"
		static let MovieAverage = "vote_average"
		static let MoviePopularity = "popularity"
		
		// MARK: Video
		static let MovieVideoKey = "key"

		}
	}
