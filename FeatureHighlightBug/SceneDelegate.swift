//
//  SceneDelegate.swift
//  FeatureHighlightBug
//
//  Created by Red Beard on 17.05.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?
	var mainVC: UIViewController?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		self.window = UIWindow(windowScene: windowScene)
		window?.rootViewController = MainViewController()
		window?.makeKeyAndVisible()
		
		mainVC = window?.rootViewController
	}

	func sceneWillEnterForeground(_ scene: UIScene) {
		DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [unowned self] in
			window?.rootViewController = self.mainVC
		}
	}

	func sceneDidEnterBackground(_ scene: UIScene) {
		let vc = UIViewController()
		vc.view.backgroundColor = .gray
		window?.rootViewController = vc
	}
}

