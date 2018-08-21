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
		static let AuthorizationURL = "https://www.themoviedb.org/authenticate/"
		static let AccountURL = "https://www.themoviedb.org/account/"
	}
	
	//*****************************************************************
	// MARK: - Methods
	//*****************************************************************
	struct Methods {
		
		// MARK: Account
		static let Account = "/account"
		static let AccountIDFavoriteMovies = "/account/{id}/favorite/movies"
		static let AccountIDFavorite = "/account/{id}/favorite"
		static let AccountIDWatchlistMovies = "/account/{id}/watchlist/movies"
		static let AccountIDWatchlist = "/account/{id}/watchlist"
		
		// MARK: Authentication
		static let AuthenticationTokenNew = "/authentication/token/new"
		static let AuthenticationSessionNew = "/authentication/session/new"
		
		// MARK: Search
		static let SearchMovie = "/search/movie"
		
		// MARK: Config
		static let Config = "/configuration"
		
	}
	
	//*****************************************************************
	// MARK: - URL Keys
	//*****************************************************************
	
	struct URLKeys {
		static let UserID = "id"
	}
	
	//*****************************************************************
	// MARK: - Paramter Keys
	//*****************************************************************
	
	struct ParameterKeys {
		static let ApiKey = "api_key"
		static let SessionID = "session_id"
		static let RequestToken = "request_token"
		static let Query = "query"
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
		
//		// MARK: General
//		static let StatusMessage = "status_message"
//		static let StatusCode = "status_code"
//
//		// MARK: Authorization
//		static let RequestToken = "request_token"
//		static let SessionID = "session_id"
//
//		// MARK: Account
//		static let UserID = "id"
//
//		// MARK: Config
//		static let ConfigBaseImageURL = "base_url"
//		static let ConfigSecureBaseImageURL = "secure_base_url"
//		static let ConfigImages = "images"
//		static let ConfigPosterSizes = "poster_sizes"
//		static let ConfigProfileSizes = "profile_sizes"
//
//		// MARK: Movies
//		static let MovieID = "id"
//		static let MovieTitle = "title"
//		static let MoviePosterPath = "poster_path"
//		static let MovieReleaseDate = "release_date"
//		static let MovieReleaseYear = "release_year"
//		static let MovieResults = "results"
//
//	}
		
		struct PopularMovies {
			static let Results = "results"
			static let Title = "title"
			static let ReleaseDate = "release_date"
			static let Overview = "overview"
		}
	
	}

}
