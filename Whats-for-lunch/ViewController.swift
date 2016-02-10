//
//  ViewController.swift
//  Whats-for-lunch
//
//  Created by Steven Xu on 2016-02-09.
//  Copyright © 2016 Steven Xu. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITextFieldDelegate {
	@IBOutlet weak var fromTextField: UITextField!
	@IBOutlet weak var toTextField: UITextField!
	@IBOutlet weak var generateBtn: UIButton!
	@IBOutlet weak var result: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.fromTextField.delegate = self
		self.toTextField.delegate = self
	}

	func textFieldShouldReturn(textField: UITextField) -> Bool {
		return true
	}

	func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
		var from = self.fromTextField.text!
		var to = self.toTextField.text!
		if self.fromTextField.isFirstResponder() {
			from = string == "" ? (from as NSString).stringByReplacingCharactersInRange(range, withString: string) : "\(from)" + string
		} else if self.toTextField.isFirstResponder() {
			to = string == "" ? (to as NSString).stringByReplacingCharactersInRange(range, withString: string) : "\(to)" + string
		}
		self.generateBtn.enabled = Int(to) >= Int(from)
		return true
	}

	@IBAction func generatePressed(sender: UIButton) {
		if let from = UInt32(self.fromTextField.text!), let to = UInt32(self.toTextField.text!) where to >= from {
			self.generateBtn.enabled = true
			let rand = Int(arc4random_uniform(to - from + 1)) + Int(from)
			self.result.text = "\(rand)"
		} else {
			self.generateBtn.enabled = false
		}
		self.fromTextField.resignFirstResponder()
		self.toTextField.resignFirstResponder()
	}
}

