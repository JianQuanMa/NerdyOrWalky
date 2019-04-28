//
//  MapViewController.swift
//  NerdyOrWalky
//
//  Created by Jian Ma on 4/21/19.
//  Copyright © 2019 Jian Ma. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps
import GooglePlaces

class Destination : NSObject{
    let name : String
    let location : CLLocationCoordinate2D
    let zoom : Float
    
    init(name : String, location : CLLocationCoordinate2D, zoom: Float){
        self.name = name
        self.location = location
        self.zoom = zoom
    }
    
}

class MapViewController: UIViewController {
    
    var mapView2 : GMSMapView?
    
    var currentLocation : Destination?
    
    let destinations = [
        Destination(name: "Governor Island Hotel", location: CLLocationCoordinate2DMake(40.41234, -74.01209), zoom: 11)
        ,
        Destination(name: "Flag Plaza", location:
            CLLocationCoordinate2DMake(40.41344, -74.03229), zoom: 11)
    ]

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
//        GMSServices.provideAPIKey("AIzaSyDXCTV4Mv6vgN3cDQU79fXk8YbqSbk4eD0")
//        let appleHQ = CLLocation(latitude: 37.33, longitude: -122.00)
//        let regionRadius : CLLocationDistance = 1000.0
//        let region = MKCoordinateRegion(center: appleHQ.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
//        mapView.setRegion(region, animated: true)
//        mapView.delegate = self
        findLocation()
      

        // Do any additional setup after loading the view.
    }
    
    func findLocation(){
      
        GMSServices.provideAPIKey("AIzaSyDXCTV4Mv6vgN3cDQU79fXk8YbqSbk4eD0")
        let camera = GMSCameraPosition.camera(withLatitude: 40.690194, longitude: -74.043541, zoom: 10)
        
         mapView2 = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView2
        let currentLocation = CLLocationCoordinate2DMake(40.690194, -74.043541)
        let clMarker = GMSMarker(position: currentLocation)
        clMarker.title = "you"
        clMarker.map = mapView2
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "next", style: .plain, target: self, action: "next")
        
    }
    
    @objc func next(){
        
        if currentLocation == nil {
            currentLocation = destinations.first
            
            
        
        }else{
            if let index = destinations.firstIndex(of: currentLocation!), index < destinations.count - 1{
                currentLocation = destinations[index+1]}
            
        }
        setMapFocus()
//        let nextPosition = CLLocationCoordinate2DMake(40.41234, -74.01209)
//        mapView2?.camera = GMSCameraPosition.camera(withLatitude: nextPosition.latitude, longitude: nextPosition.longitude, zoom: 11)
//        addMarker(position: CLLocation(latitude: nextPosition.latitude, longitude: nextPosition.longitude), title: "Governor island hotel")
        
    }
    
    private func setMapFocus(){
        CATransaction.begin()
        CATransaction.setValue(1, forKey: kCATransactionAnimationDuration)
        mapView2?.camera = GMSCameraPosition.camera(withTarget: currentLocation!.location, zoom: currentLocation!.zoom)
//        mapView2?.animate(to: GMSCameraPosition.camera(withTarget: currentLocation!.location, zoom: currentLocation!.zoom))
        CATransaction.commit()
        let clMarker = GMSMarker(position: currentLocation!.location)
        clMarker.title = currentLocation?.name
        clMarker.map = mapView2
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
    
    private func addMarker(position: CLLocation, title : String){
        let marker = GMSMarker(position: position.coordinate)
        marker.title = title
        marker.map = mapView2
    }
}
