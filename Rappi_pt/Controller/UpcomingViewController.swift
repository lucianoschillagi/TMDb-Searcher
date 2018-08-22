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
	

	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	
	
	
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


//*****************************************************************
// MARK: - Table View Data Source Methods
//*****************************************************************

extension UpcomingViewController: UITableViewDataSource {
	
	// task: determinar cuantas filas tendrá la tabla
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		//debugPrint("la tabla de las tarjetas de crédito tiene \(allCreditCards.count) filas.")
		return 10
	}
	
	// task: configurar las celdas de la tabla
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cellReuseId = "cell"
		//let creditCard = allCreditCards[(indexPath as NSIndexPath).row]
		let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath) as UITableViewCell!
		//		cell?.textLabel?.text = creditCard.name
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

//extension PopularViewController: UITableViewDelegate {
//
//	// task: almacenar el nombre de la tarjeta seleccionada para su posterior uso en la solicitud web
//	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//		let creditCard = allCreditCards[(indexPath as NSIndexPath).row]
//		MercadoPagoClient.ParameterValues.PaymentMethod = creditCard.id // 🔌 👏
//		PayMethodViewController.creditCardChoosen = creditCard.name // 🔌 👏
//
//		setUIEnabled(true)
//	}
//
//} // end ext


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
