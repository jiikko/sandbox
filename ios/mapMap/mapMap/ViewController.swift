//
//  ViewController.swift
//  mapMap
//
//  Created by KAWAGUCHI on 2020/11/28.
//

import UIKit
import MapKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var dispMap: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputText.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // キーボードを閉じる
        if let searchKey = textField.text {
            print(searchKey)
        }
        return true
    }
}

