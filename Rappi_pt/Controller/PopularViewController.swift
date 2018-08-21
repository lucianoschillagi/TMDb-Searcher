//
//  PopularViewController.swift
//  Rappi_pt
//
//  Created by Luciano Schillagi on 19/08/2018.
//  Copyright © 2018 luko. All rights reserved.
//

/* Controller */

import UIKit

/* Abstract:


*/

class PopularViewController: UIViewController {
	
	
	//*****************************************************************
	// MARK: - IBOutlets
	//*****************************************************************
	
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	
	
	//*****************************************************************
	// MARK: - VC Life Cycle
	//*****************************************************************

    override func viewDidLoad() {
        super.viewDidLoad()
			
//			// networking ⬇
//			TMDbClient.getPopularMovies { (success, popularMovies, error) in
//				
//				// dispatch
//				DispatchQueue.main.async {
//					
//					if success {
//						
//						// si la solicitud fue exitosa, detener el indicador de actividad
//						self.activityIndicator.stopAnimating()
//			
//						// test
//						debugPrint("😆 Leo el valor que almacené en la propiedad ´results´ del objeto ´PopularMovies´ \(popularMovies?.results)")
//
//					}
//				}
//			}
			
	} // end view did load

	

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
