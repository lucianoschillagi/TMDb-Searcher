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
	// MARK: - Properties
	//*****************************************************************
	
	//
	var upcomingMovies: [TMDbMovie] = [TMDbMovie]()
	

	//*****************************************************************
	// MARK: - IBOutlets
	//*****************************************************************
	

	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	
	
	
	//*****************************************************************
	// MARK: - VC Life Cycle
	//*****************************************************************
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		debugPrint("↗️\(upcomingMovies)")
		
		// networking 🚀
		startRequest()
		
	} // end view did load
	
	
	//*****************************************************************
	// MARK: - Networking
	//*****************************************************************
	
	// task: obtener, mediante una solicitud web a la API de TMDb, el array de películas populares
	func startRequest() {
		
		// networking ⬇
		TMDbClient.getUpcomingMovies { (success, upcomingMovies, error) in
			
			// dispatch
			DispatchQueue.main.async {
				
				// si la solicitud fue exitosa
				if success {
					print("HOLA")
					
					// comprueba si el 'popularMovies' recibido contiene algún valor
					if let upcomingMovies = upcomingMovies {
						// si es así, se lo asigna a la propiedad ´popularMovies´
						self.upcomingMovies = upcomingMovies // 🔌 👏
						self.stopActivityIndicator()
						self.tableView.reloadData()
						
						debugPrint("↗️\(upcomingMovies.count)")
						
						
						
					}
					
				} else {
					
				}
				
			}
			
		}
		
	}
	
	
	//*****************************************************************
	// MARK: - Activity Indicator
	//*****************************************************************
	
	func startActivityIndicator() {
		activityIndicator.alpha = 1.0
		activityIndicator.startAnimating()
	}
	
	func stopActivityIndicator() {
		activityIndicator.alpha = 0.0
		self.activityIndicator.stopAnimating()
	}
	
	
	

} // end class


//*****************************************************************
// MARK: - Table View Data Source Methods
//*****************************************************************

extension UpcomingViewController: UITableViewDataSource {
	
	// task: determinar cuantas filas tendrá la tabla
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		debugPrint("Upcoming \(upcomingMovies.count)")
		return upcomingMovies.count
	}
	
	// task: configurar las celdas de la tabla
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cellReuseId = "cell"
		let movie = upcomingMovies[(indexPath as NSIndexPath).row]
		let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath) as UITableViewCell!
		cell?.textLabel?.text = movie.title
		
		
		
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

extension UpcomingViewController: UITableViewDelegate {
	
	// task: almacenar el nombre de la tarjeta seleccionada para su posterior uso en la solicitud web
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		let controller = storyboard!.instantiateViewController(withIdentifier: "Detail") as! MovieDetailViewController
		controller.detailMovie = upcomingMovies[(indexPath as NSIndexPath).row]
		navigationController!.pushViewController(controller, animated: true)
	}
	
} // end ext

//*****************************************************************
// MARK: - Navigation (Segue)
//*****************************************************************

//extension PopularViewController {
//
//	// task: enviar a 'BankViewController' el valor de la tarjeta seleccionada, para imprimirla luego en una etiqueta
//	override func prepare(for segue: UIStoryboardSegue,sender: Any?) {
//
//		// si este vc tiene un segue con el identificador "toBankVC"
//		if segue.identifier == "toBankVC" {
//			let bankVC = segue.destination as! BankViewController
//			bankVC.creditCardSelected = PayMethodViewController.creditCardChoosen
//
//		}
//	}
//}
