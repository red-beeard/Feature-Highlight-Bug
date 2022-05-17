//
//  MainViewController.swift
//  FeatureHighlightBug
//
//  Created by Red Beard on 17.05.2022.
//

import UIKit

class MainViewController: UIViewController {
	
	@IBOutlet var indigoView: UIView!
	@IBOutlet var orangeView: UIView!
	@IBOutlet var tealView: UIView!
	
	private lazy var views = [indigoView, orangeView, tealView]
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}

	@IBAction func startHighlight_Click(_ sender: UIButton) {
		let vc = MDCFeatureHighlightViewController(highlightedView: highlightedView) { [weak self] _ in
			guard let self = self else { return }
			
			self.secureAppSettings.discoveredFeatures.insert(feature)
			self.secureAppSettings.save()
			
			let featuresToShow = Array(features.dropFirst())
			// Recursion
			self.showFeatures(featuresToShow)
		}
	}
	
}

