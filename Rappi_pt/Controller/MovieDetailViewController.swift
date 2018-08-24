//
//  MovieDetailViewController.swift
//  Rappi_pt
//
//  Created by Luciano Schillagi on 19/08/2018.
//  Copyright © 2018 luko. All rights reserved.
//

/* Controller */

import UIKit

/* Abstract:

*/

class MovieDetailViewController: UIViewController {
	
	
	//*****************************************************************
	// MARK: - Properties
	//*****************************************************************
	
	// la película seleccionada en la pantalla anterior
	 var movie: TMDbMovie?
	
	//*****************************************************************
	// MARK: - IBOutlets
	//*****************************************************************
	
	@IBOutlet weak var movieDetailTitle: UILabel!
	@IBOutlet weak var moviePoster: UIImageView!
	@IBOutlet weak var movieOverview: UITextView!
	@IBOutlet weak var movieVoteAverage: UILabel!
	
	
	//*****************************************************************
	// MARK: - VC Life Cycle
	//*****************************************************************

    override func viewDidLoad() {
        super.viewDidLoad()
			
			getTitleAndYear()
			configureUIDetail()
    }
    

	//*****************************************************************
	// MARK: - Configure UI Elements
	//*****************************************************************
	
	// task: obtener el título y el año de lanzamiento de la película
	func getTitleAndYear() {
		
		var title = movie?.title
		var releaseYear = movie?.releaseYear
		
		if let titleString = title, let yearString = releaseYear {
			title = titleString
			releaseYear = yearString
			var titleReleaseYear = titleString + " (\(yearString))"
			self.title = titleReleaseYear
		}
	}
	
	// task: configurar los elementos que componene la interfaz de usuario del detalle de la película
	func configureUIDetail() {
		
		// pone el overview
		movieOverview.text = movie?.overview
		// el promedio de votos
		movieVoteAverage.text = movie?.voteAverage
		
	}
	
	
	
} // end class
