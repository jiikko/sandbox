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
            
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(searchKey, completionHandler: { (placemarks, error) in
                if let unwnrapPlacemarks = placemarks {
                    if let firstPlacemark = unwnrapPlacemarks.first {
                        if let location = firstPlacemark.location {
                            let targetCoordinate = location.coordinate
                            print(targetCoordinate)
                            
                            let pin = MKPointAnnotation()
                            pin.coordinate = targetCoordinate
                            pin.title = searchKey
                            self.dispMap.addAnnotation(pin)
                            self.dispMap.region = MKCoordinateRegion(center: targetCoordinate, latitudinalMeters: 500.0, longitudinalMeters: 500.0)
                        }
                    }
                }
            })
        }
        return true
    }
}

