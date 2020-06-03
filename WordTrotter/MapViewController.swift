//
//  MapViewController.swift
//  WordTrotter
//
//  Created by Def Method on 5/12/20.
//  Copyright © 2020 RoseZyArt. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
  
  var mapView: MKMapView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    
  }
  
  override func loadView() {
    //create a map view
    mapView = MKMapView()
    
    // set it as *the* view of this view controller
    view = mapView
    
    
    
    let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
    segmentedControl.backgroundColor = UIColor.systemBackground
    segmentedControl.selectedSegmentIndex = 0
    
    segmentedControl.addTarget(self, action: #selector(mapTypeChanged(_: )), for: .valueChanged)
    
    segmentedControl.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(segmentedControl)
    
    
    let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)
    
    let margins = view.layoutMarginsGuide
    let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
    let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
    
    topConstraint.isActive = true
    leadingConstraint.isActive = true
    trailingConstraint.isActive = true
    
    let poiLabel = UILabel()
    poiLabel.text = "Points of Interest"
     
    poiLabel.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(poiLabel)
     
    let poiLabelTop = poiLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8)
    let poiLabelLeading = poiLabel.leadingAnchor.constraint(equalTo: segmentedControl.leadingAnchor)
     
    poiLabelTop.isActive = true
    poiLabelLeading.isActive = true
    
    let toggleControl = UISwitch()
    toggleControl.backgroundColor = UIColor.clear
    toggleControl.isOn = true
    
    toggleControl.addTarget(self, action: #selector(togglePOI), for: .valueChanged)
    
    toggleControl.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(toggleControl)
    
    let toggleControlCenterY = toggleControl.centerYAnchor.constraint(equalTo: poiLabel.centerYAnchor)
    let toggleControlLeading = toggleControl.leadingAnchor.constraint(equalTo: poiLabel.trailingAnchor, constant: 8)
    
    toggleControlCenterY.isActive = true
    toggleControlLeading.isActive = true
    
   
  }
  
  @objc func mapTypeChanged(_ segControl: UISegmentedControl) {
    switch segControl.selectedSegmentIndex {
    case 0:
      mapView.mapType = .standard
    case 1:
      mapView.mapType = .hybrid
    case 2:
      mapView.mapType = .satellite
    default:
      break
    }
  }
  
  @objc func togglePOI(_ value: UISwitch) {
    
    mapView.pointOfInterestFilter = value.isOn ?  .includingAll : .excludingAll
    
  }
  
  
}
