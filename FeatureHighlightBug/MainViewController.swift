//
//  MainViewController.swift
//  FeatureHighlightBug
//
//  Created by Red Beard on 17.05.2022.
//

import UIKit
import MaterialComponents

class MainViewController: UIViewController {
	
	private let indigoView = UIView()
	private let orangeView = UIView()
	private let tealView = UIView()
	
	private let btnStartHighlight = UIButton(type: .system)
	
	private lazy var views = [indigoView, orangeView, tealView]
	
	override func loadView() {
		super.loadView()
		
		let stack = UIStackView(arrangedSubviews: views)
		stack.spacing = 15
		stack.axis = .vertical
		stack.alignment = .fill
		stack.distribution = .fillEqually
		
		stack.translatesAutoresizingMaskIntoConstraints = false
		indigoView.translatesAutoresizingMaskIntoConstraints = false
		orangeView.translatesAutoresizingMaskIntoConstraints = false
		tealView.translatesAutoresizingMaskIntoConstraints = false
		btnStartHighlight.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(stack)
		view.addSubview(btnStartHighlight)
		
		NSLayoutConstraint.activate([
			NSLayoutConstraint(item: indigoView, attribute: .height, relatedBy: .equal, toItem: indigoView, attribute: .width, multiplier: 1, constant: 0),
			
			NSLayoutConstraint(item: stack, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.6, constant: 0),
			NSLayoutConstraint(item: stack, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: -20),
			NSLayoutConstraint(item: stack, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
			
			NSLayoutConstraint(item: btnStartHighlight, attribute: .top, relatedBy: .equal, toItem: stack, attribute: .bottom, multiplier: 1, constant: 40),
			NSLayoutConstraint(item: btnStartHighlight, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
		])
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		btnStartHighlight.setTitle("Start Highlighted", for: .normal)
		
		view.backgroundColor = .white
		indigoView.backgroundColor = UIColor(red: 88/255, green: 86/255, blue: 214/255, alpha: 1)
		orangeView.backgroundColor = UIColor(red: 255/255, green: 149/255, blue: 0/255, alpha: 1)
		tealView.backgroundColor = UIColor(red: 90/255, green: 200/255, blue: 250/255, alpha: 1)
		btnStartHighlight.backgroundColor = .systemBlue
		btnStartHighlight.setTitleColor(.white, for: .normal)
		
		indigoView.layer.cornerRadius = 15
		orangeView.layer.cornerRadius = 15
		tealView.layer.cornerRadius = 15
		btnStartHighlight.layer.cornerRadius = 5
		
		btnStartHighlight.addTarget(self, action: #selector(btnStartHighlight_Click), for: .touchUpInside)
	}
	
	private func getTitle(for view: UIView) -> String {
		switch view {
			case indigoView: return "Indigo"
			case orangeView: return "Orange"
			case tealView: return "Teal"
			default: return "nil"
		}
	}
	
	private func showHighlight(_ views: [UIView?]) {
		guard let view = views.first as? UIView else { return }
		
		let vc = MaterialComponents.MDCFeatureHighlightViewController(highlightedView: view) { [weak self] _ in
			guard let self = self else { return }
			let highlightedViews = Array(views.dropFirst())
			self.showHighlight(highlightedViews)
		}
		
		vc.titleText = getTitle(for: view)
		vc.titleColor = .white
		vc.titleFont = .systemFont(ofSize: 17, weight: .semibold)
		vc.outerHighlightColor = view.backgroundColor
		vc.view.backgroundColor = .clear
		
		present(vc, animated: true)
	}

	@objc private func btnStartHighlight_Click(_ sender: UIButton) {
		showHighlight(views)
	}
}

