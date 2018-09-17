//
//  AppDelegate.swift
//  Rappi_pt
//
//  Created by Luciano Schillagi on 18/08/2018.
//  Copyright © 2018 luko. All rights reserved.
//

/* Application */

import UIKit

/* Abstract:

*/

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

	//*****************************************************************
	// MARK: - Properties
	//*****************************************************************
	
	var window: UIWindow?

	//*****************************************************************
	// MARK: - Methods
	//*****************************************************************

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
			// configura al split view controller como vc raíz
			let splitViewController = window!.rootViewController as! UISplitViewController

		
			let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-2] as! UINavigationController
			navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
			splitViewController.preferredDisplayMode = .allVisible
		splitViewController.delegate = self
		
			// configura la apariencia de la barra de búsqueda y de la barra de navegación
			UISearchBar.appearance().tintColor = .movieGreen
			UINavigationBar.appearance().tintColor = .movieGreen
	
			return true
		}
	
	
		// MARK: - Split view
		func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {

			guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
			guard let topAsDetailController = secondaryAsNavController.topViewController as? MovieDetailViewController else { return false }
			if topAsDetailController.selectedMovie == nil {
				return true
			}
			
			return false
		}

	
} // end class

