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
		let digits = String(self.resultNum).characters.flatMap { String($0) }
		digits.forEach { self.images.append(UIImage(named: $0)!) }

		self.images.forEach {
			let imageWidth = $0.size.width / $0.size.height * self.resultView.frame.height
			let start = (self.resultView.frame.width - self.totalWidth) / 2
			let rect = CGRect(x: start + self.xSoFar, y: 0, width: imageWidth, height: self.resultView.frame.height)
			let imageView = UIImageView(frame: rect)
			imageView.image = $0
			self.resultView.addSubview(imageView)
			self.xSoFar += imageWidth
		}

		let swipeGesture = UISwipeGestureRecognizer(target: self, action: "viewDidSwipe")
		swipeGesture.direction = .Down
		self.view.addGestureRecognizer(swipeGesture)
	}

	func viewDidSwipe() {
		self.dismissViewControllerAnimated(true, completion: nil)
	}

}