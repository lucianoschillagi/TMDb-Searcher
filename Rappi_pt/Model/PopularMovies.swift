//
//  PopularMovies.swift
//  Rappi_pt
//
//  Created by Luciano Schillagi on 21/08/2018.
//  Copyright © 2018 luko. All rights reserved.
//

/* Model */

import Foundation

/* Abstract:
Una objeto preparado para recibir, mapear y almacenar (para usar cuando sea necesario) los datos de las películas más populares.
*/

struct PopularMovies {
	
	//*****************************************************************
	// MARK: - Properties
	//*****************************************************************
	
	let results: [[String:AnyObject]]?
	var title: String = ""
	var releaseDate: String = ""
	var overview: String = ""
	
	// un array que contiene los diversos 'titulos' obtenidos
	var titleArray: [String] = []
	// un array que contiene los diversos 'release date' obtenidos
	var releaseDateArray: [String] = []
	// un array que contiene los diversos 'overview' obtenidos
	var overviewArray: [String] = []
	
	//*****************************************************************
	// MARK: - Initializers
	//*****************************************************************
	
	// task: construir el objeto 'TopRated' desde un diccionario (el JSON obtenido '[String:AnyObject]')
	
	init(dictionary: [String:AnyObject]) {
		
		// los resultados de la petición sobre ´popular movies´
		results = dictionary["results"] as? [[String:AnyObject]]
		
		// comprueba si el array de diccionario que contiene la clave 'results' contiene algún valor
		if let resultsDictionaryArray = results {
			
			// itera el array de diccionarios contenidos dentro de la clave 'results'
			for item in resultsDictionaryArray {
				
				// extrae, de cada diccionario del array, el valor de la clave...
				// title
				title = item["title"] as! String
				// release date
				releaseDate = item["release_date"] as! String
				// overview
				overview = item["overview"] as! String
				
				// agrega cada uno de de esos valores dentro del array 'PopularMovies.titleArray' (que queda lleno LISTA PARA USAR!)
				titleArray.append(title)
				releaseDateArray.append(releaseDate)
				overviewArray.append(overview)
			}
		}
		
		//test
		debugPrint("Los títulos obtenidos del objeto de películas populares es:\(titleArray). Es decir, en total son \(titleArray.count) títulos.")

	
		
	}
	
	//*****************************************************************
	// MARK: - Methods
	//*****************************************************************
	
	// task: transformar al resultado obtenido (objeto JSON) en un objeto Foundation 'PopularMovies'
	static func popularMoviesFromResults(_ results: [String:AnyObject]) -> PopularMovies {
		// convierte el diccionario obtenido a una estructura 'PopularMovies'
		let completePopularMoviesObject = PopularMovies(dictionary: results)
		// devuelve el objeto completo convertido a una struct 'TopRated'
		return completePopularMoviesObject
	}
	
} // end class
