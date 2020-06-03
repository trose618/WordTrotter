//
//  ViewController.swift
//  WordTrotter
//
//  Created by Def Method on 5/12/20.
//  Copyright © 2020 RoseZyArt. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
  
  //properties
  var gl: CAGradientLayer!
  
  @IBOutlet var celsiusLabel: UILabel!
  @IBOutlet var textField: UITextField!
  
  var fahrenheitValue: Measurement<UnitTemperature>? {
    didSet {
      updateCelsiusLabel()
    }
  }
  
  var celsiusValue: Measurement<UnitTemperature>? {
    if let fahrenheitValue = fahrenheitValue {
        return fahrenheitValue.converted(to: .celsius)
    } else {
        return nil
    }
  }
  
  let numberFormatter: NumberFormatter = {
    let nf = NumberFormatter()
    nf.numberStyle = .decimal
    nf.minimumFractionDigits = 0
    nf.maximumFractionDigits = 1
    return nf
  }()
  
  //Overrides
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    print("ConversionViewController loaded its view.")
    
    updateCelsiusLabel()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    
    let backgroundColor = UIColor(red: .random(in: 0...1),
    green: .random(in: 0...1),
    blue: .random(in: 0...1),
    alpha: 1.0)
    
    view.backgroundColor = backgroundColor
    
  }
  
  override func viewWillLayoutSubviews() {
//    gl = CAGradientLayer()
//    gl.colors = [UIColor.red.cgColor,
//                 UIColor.yellow.cgColor,
//                 UIColor.green.cgColor,
//                 UIColor.blue.cgColor]
//
//    gl.frame = view.bounds
//    view.layer.insertSublayer(gl, at: 0)
  }
  
  @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
    
    if let text = textField.text, let value = Double(text) {
      fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
    } else {
      fahrenheitValue = nil
    }
    
  }

  @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
    textField.resignFirstResponder()
  }
  
  func updateCelsiusLabel() {
    if let celsiusValue = celsiusValue {
      celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
      } else {
      celsiusLabel.text = "???"
    }
  }

  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
    let replacementTextHasDecimalSeparator = string.range(of: ".")
    let letters = NSCharacterSet.letters
    
    let replacementTextIsALetter = string.rangeOfCharacter(from: letters)
    
    if ((existingTextHasDecimalSeparator != nil &&
      replacementTextHasDecimalSeparator != nil) || (replacementTextIsALetter != nil)) {
        return false
    } else {
      return true
    }
  }
  
}

