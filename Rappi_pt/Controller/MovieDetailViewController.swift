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

	var detailMovie: TMDbMovie?
	
	// esconde la barra de estado
	override var prefersStatusBarHidden: Bool {
		return true
	}
	
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
		
		var title = detailMovie?.title
		var releaseYear = detailMovie?.releaseYear
		
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
		movieOverview.text = detailMovie?.overview
		// el promedio de votos
		let voteAverage = "Vote Average: \(Float((detailMovie?.voteAverage)!))"
		movieVoteAverage.text = String(voteAverage)
		
	}
	
	
	
} // end class
