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
	
	private let buttonStartHighlight = UIButton(type: .system)
	
	private lazy var views = [indigoView, orangeView, tealView]
	
	override func loadView() {
		super.loadView()
		
		let stack = UIStackView(arrangedSubviews: views)
		stack.spacing = 15
		stack.axis = .vertical
		stack.alignment = .fill
		stack.distribution = .fillEqually
		
		stack.translatesAutoresizingMaskIntoConstraints = false
		buttonStartHighlight.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(stack)
		view.addSubview(buttonStartHighlight)
		
		NSLayoutConstraint.activate([
			indigoView.heightAnchor.constraint(equalTo: indigoView.widthAnchor, multiplier: 1),
			
			stack.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
			stack.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
			stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			
			buttonStartHighlight.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 40),
			buttonStartHighlight.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		])
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		buttonStartHighlight.setTitle("Start Highlighted", for: .normal)
		
		view.backgroundColor = .systemBackground
		indigoView.backgroundColor = .systemIndigo
		orangeView.backgroundColor = .systemOrange
		tealView.backgroundColor = .systemTeal
		buttonStartHighlight.backgroundColor = .systemBlue
		buttonStartHighlight.setTitleColor(.white, for: .normal)
		
		indigoView.layer.cornerRadius = 15
		orangeView.layer.cornerRadius = 15
		tealView.layer.cornerRadius = 15
		buttonStartHighlight.layer.cornerRadius = 5
		
		buttonStartHighlight.addTarget(self, action: #selector(buttonStartHighlight_Click), for: .touchUpInside)
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

	@objc private func buttonStartHighlight_Click(_ sender: UIButton) {
		showHighlight(views)
	}
	
}

