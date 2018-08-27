//
//  MasterViewController.swift
//  Rappi_pt
//
//  Created by Luciano Schillagi on 27/08/2018.
//  Copyright © 2018 luko. All rights reserved.
//

/* Controller */

import UIKit

/* Abstract:

*/

class MasterViewController: UIViewController {
	
	//*****************************************************************
	// MARK: - IBOutlets
	//*****************************************************************
	
	// esconde la barra de estado
	override var prefersStatusBarHidden: Bool {
		return true
	}
	
	//*****************************************************************
	// MARK: - IBOutlets
	//*****************************************************************
	
	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var categories: UISegmentedControl!
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!

	
	//*****************************************************************
	// MARK: - VC Life Cycle
	//*****************************************************************

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
	
	
	
	
	
	


} // end class



//*****************************************************************
// MARK: - Table View Data Source Methods
//*****************************************************************

extension MasterViewController: UITableViewDataSource {
	
	// task: determinar cuantas filas tendrá la tabla
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		//return topRatedMovies.count
		return 20
	}
	
	// task: configurar las celdas de la tabla
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cellReuseId = "cell"
		//let movie = topRatedMovies[(indexPath as NSIndexPath).row]
		let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath) as UITableViewCell!
		//cell?.textLabel?.text = movie.title
		
		
		
		//		cell?.imageView!.contentMode = UIView.ContentMode.scaleAspectFit
		//
		//
		//		if let thumbPath = creditCard.thumb {
		//			// realiza la solicitud para obtener la imágen
		//			let _ = MercadoPagoClient.taskForGETImage(thumbPath) { (imageData, error) in
		//				if let image = UIImage(data:imageData!) {
		//
		//					DispatchQueue.main.async {
		//						cell?.imageView?.image = image
		//					}
		//				} else {
		//					print(error ?? "empty error")
		//				}
		//			}
		//
		//		} // end optional binding
		
		return cell!
		
	}
	
} // end class


//*****************************************************************
// MARK: - Table View Delegate Methods
//*****************************************************************

extension MasterViewController: UITableViewDelegate {
	
	// task: almacenar el nombre de la tarjeta seleccionada para su posterior uso en la solicitud web
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
//		let controller = storyboard!.instantiateViewController(withIdentifier: "Detail") as! MovieDetailViewController
//		controller.movie = topRatedMovies[(indexPath as NSIndexPath).row]
//		navigationController!.pushViewController(controller, animated: true)
	}
	
} // end ext





