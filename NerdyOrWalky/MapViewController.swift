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

struct Destination {
    let name : String
    let location : CLLocationCoordinate2D
    let zoom : Float
}

extension Destination: Equatable {
    static func == (lhs: Destination, rhs: Destination) -> Bool {
        return (lhs.location.latitude == rhs.location.latitude) && (lhs.location.longitude == rhs.location.longitude)
    }
}

final class MapViewController: UIViewController {
    
    private let mapView2 = GMSMapView.map(withFrame: .zero,
                                          camera: .camera(withLatitude: 40.690194,
                                                          longitude: -74.043541,
                                                          zoom: 10))
    
    var currentLocation: Destination?
    
    let destinations = [
        Destination(name: "Governor Island Hotel", location: CLLocationCoordinate2DMake(40.41234, -74.01209), zoom: 11),
        Destination(name: "Flag Plaza", location: CLLocationCoordinate2DMake(40.41344, -74.03229), zoom: 11)
    ]
    @IBOutlet weak var mapView: MKMapView!

    @IBAction private func changeMapType(_ sender: UISegmentedControl) {
        mapView.mapType = sender.selectedSegmentIndex == 0 ? .standard : .satellite
    }
    
    
    @IBAction private func closeButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        findLocation()
        addNextBarButtonItem()
    }
    

    func findLocation(){
        
        let currentLocation = CLLocationCoordinate2DMake(40.690194, -74.043541)
        let clMarker = GMSMarker(position: currentLocation)
        clMarker.title = "you"
        clMarker.map = mapView2
        
    }
    
    @objc func didPressNextButton(){
        
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
    
    private func setMapFocus() {
        CATransaction.begin()
        CATransaction.setValue(1, forKey: kCATransactionAnimationDuration)
        mapView2.camera = GMSCameraPosition.camera(withTarget: currentLocation!.location, zoom: currentLocation!.zoom)
//        mapView2?.animate(to: GMSCameraPosition.camera(withTarget: currentLocation!.location, zoom: currentLocation!.zoom))
        CATransaction.commit()
        let clMarker = GMSMarker(position: currentLocation!.location)
        clMarker.title = currentLocation?.name
        clMarker.map = mapView2
    }
  
    // MARK: - Helpers
    
    private func setupMapView() {
        view.addSubview(mapView2)
        mapView2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView2.topAnchor.constraint(equalTo: view.topAnchor),
            mapView2.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView2.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView2.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
    }
    
    private func addNextBarButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "next", style: .plain, target: self, action: "didPressNextButton")
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
