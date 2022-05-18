//
//  AppDelegate.swift
//  FeatureHighlightBug
//
//  Created by Red Beard on 17.05.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	var mainVC: UIViewController?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		self.window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = MainViewController()
		window?.makeKeyAndVisible()
		
		mainVC = window?.rootViewController
		
		return true
	}
	
	func applicationWillEnterForeground(_ application: UIApplication) {
		DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [unowned self] in
			window?.rootViewController = self.mainVC
		}
	}
	
	func applicationDidEnterBackground(_ application: UIApplication) {
		let vc = UIViewController()
		vc.view.backgroundColor = .gray
		window?.rootViewController = vc
	}
}

