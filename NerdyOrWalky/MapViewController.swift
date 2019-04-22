//
//  MapViewController.swift
//  NerdyOrWalky
//
//  Created by Jian Ma on 4/21/19.
//  Copyright © 2019 Jian Ma. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBAction func changeMapType(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0{
            mapView.mapType = .standard
        }else{
            mapView.mapType = .satellite
        }
    }
    @IBAction func closeButton(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appleHQ = CLLocation(latitude: 37.33, longitude: -122.00)
        let regionRadius : CLLocationDistance = 1000.0
        let region = MKCoordinateRegion(center: appleHQ.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(region, animated: true)
        mapView.delegate = self

        // Do any additional setup after loading the view.
    }
    

    

}
extension MapViewController {
    private func performSegueToReturnBack()  {
        if let nav = navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
extension MapViewController : MKMapViewDelegate{
    func mapViewWillStartRenderingMap(_ mapView: MKMapView) {
        print("rendering....")
    }
}
