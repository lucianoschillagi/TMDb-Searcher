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
	var title: String?
	var releaseDate: String?
	var overview: String?
	
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
				titleArray.append(title!)
				releaseDateArray.append(releaseDate!)
				overviewArray.append(overview!)
			}
		}

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

//static func popularMoviesFromResults(_ results: [[String:AnyObject]]) -> [PopularMovies] {
//
//	var titleArray = [PopularMovies]()
//
//	for result in results {
//
//		titleArray.append(PopularMovies(dictionary: result))
//		titleArray.append(PopularMovies(dictionary: result))
//
//
//	}
//
//	return titleArray
//
//
//}






//// task: de los resultados de la solicitud devolver un array que contenga las urls para construir las imagenes (las fotos)
//static func photosPathFromResults(_ results: [[String:AnyObject]]) -> [FlickrImage] {
//
//	// guarda las fotos obtenidas en un array de 'FlickrImage'
//	var photosPath = [FlickrImage]()
//
//	// itera a través de un array de diccionarios, cada 'FlickrImage' es un diccionario 👈
//	for result in results {
//		photosPath.append(FlickrImage(dictionary: result))
//	}
//
//	return photosPath
//
//}
