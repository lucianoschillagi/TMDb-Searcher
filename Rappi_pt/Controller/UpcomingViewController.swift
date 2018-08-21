//
//  UpcomingViewController.swift
//  Rappi_pt
//
//  Created by Luciano Schillagi on 19/08/2018.
//  Copyright © 2018 luko. All rights reserved.
//

/* Controller */

import UIKit

/* Abstract:
*/

class UpcomingViewController: UIViewController {

	//*****************************************************************
	// MARK: - IBOutlets
	//*****************************************************************
	
	
	
	//*****************************************************************
	// MARK: - VC Life Cycle
	//*****************************************************************
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// networking ⬇
		TMDbClient.getUpcomingMovies { (success, upcomingMovies, error) in
			
			// dispatch
			DispatchQueue.main.async {
				
				if success {
					
					// si la solicitud fue exitosa, detener el indicador de actividad
					//self.activityIndicator.stopAnimating()
					
					// test
					debugPrint("🙌🏻 Leo el valor que almacené en la propiedad ´results´ del objeto ´UpcomingMovies´ \(upcomingMovies?.results)")
				}
			} // end dispatch
			
		} // end closure
		
	} // end view did load

}
