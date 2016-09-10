//
//  ResultViewController.swift
//  Whats-for-lunch
//
//  Created by Steven Xu on 2016-02-13.
//  Copyright © 2016 Steven Xu. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

	@IBOutlet var resultView: UIView!
	@IBOutlet var resultViewWidth: NSLayoutConstraint!

	var resultNum: Int!
	var images: [UIImage] = []
	var xSoFar: CGFloat = 0
	var totalWidth: CGFloat {
		var foo: CGFloat = 0
		self.images.forEach {
			foo += $0.size.width / $0.size.height * self.resultView.frame.height
		}
		return foo
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(ResultViewController.viewDidSwipe))
		swipeGesture.direction = .down
		self.view.addGestureRecognizer(swipeGesture)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		let digits = String(self.resultNum).characters.map { String($0) }
		digits.forEach { self.images.append(UIImage(named: $0)!) }

		self.resultViewWidth.constant = self.totalWidth

		self.images.forEach { img in
			let imageWidth = img.size.width / img.size.height * self.resultView.frame.height
			let start = max(0, (self.resultViewWidth.constant - self.totalWidth) / 2)
			let rect = CGRect(x: start + self.xSoFar, y: 0, width: imageWidth, height: self.resultView.frame.height)
			let imageView = UIImageView(frame: rect)
			imageView.image = img
			self.resultView.addSubview(imageView)
			self.xSoFar += imageWidth
		}
	}

	func viewDidSwipe() {
		self.dismiss(animated: true, completion: nil)
	}

}
