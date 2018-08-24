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
	
	
	//*****************************************************************
	// MARK: - VC Life Cycle
	//*****************************************************************

    override func viewDidLoad() {
        super.viewDidLoad()
			
			self.title = movie?.title
			
			// el título de la película seleccionada
			debugPrint(movie?.title)
			
			//movieDetailTitle.text = movie?.title
			movieOverview.text = movie?.overview
			
			
			
			
			

    }
    

	
	
	
	
	
} // end class
