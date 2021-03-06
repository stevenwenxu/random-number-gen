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
	
	var resultNum = 0

	override func viewDidLoad() {
		super.viewDidLoad()
		self.fromTextField.delegate = self
		self.toTextField.delegate = self
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.didTapView))
		self.view.addGestureRecognizer(tapGesture)
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		return true
	}

	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		var from = self.fromTextField.text!
		var to = self.toTextField.text!
		if self.fromTextField.isFirstResponder {
			from = (from as NSString).replacingCharacters(in: range, with: string)
		} else if self.toTextField.isFirstResponder {
			to = (to as NSString).replacingCharacters(in: range, with: string)
		}
		self.generateBtn.isEnabled = Int(to)! >= Int(from)!
		return true
	}

	func textFieldDidBeginEditing(_ textField: UITextField) {
		textField.text = ""
	}

	@IBAction func generatePressed(_ sender: UIButton) {
		if let from = UInt32(self.fromTextField.text!), let to = UInt32(self.toTextField.text!) , to >= from {
			self.generateBtn.isEnabled = true
			self.resultNum = Int(arc4random_uniform(to - from + 1)) + Int(from)
			self.view.endEditing(true)
		}
	}

	func didTapView() {
		self.view.endEditing(true)
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let identifier = segue.identifier {
			if identifier == "showResult" {
				let vc = segue.destination as! ResultViewController
				vc.modalPresentationStyle = .fullScreen
				vc.modalTransitionStyle = .partialCurl
				vc.resultNum = self.resultNum
			}
		}
	}

}
