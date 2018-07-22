//
//  ViewController.swift
//  IISLocation
//
//  Created by Taras Holets on 20/07/2018.
//  Copyright © 2018 Taras Holets. All rights reserved.
//

import UIKit
import Mapbox

class MapViewController: UIViewController {

    @IBOutlet weak var mapViewContainer: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    
    var presenter: MapSreenViewPresenter!
    var mapView: MGLMapView!
    var annotation: MGLPointAnnotation!
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initMapView()
        
        presenter = MapScreenPresenter(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.fetchAllData()
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(fetchAllData), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }

    private func initMapView() {
        
        mapView = MGLMapView(frame: mapViewContainer.bounds)
        mapView.delegate = self
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapViewContainer.addSubview(mapView)
        
        annotation = MGLPointAnnotation()
        mapView.addAnnotation(annotation)
    }
    
    @objc private func fetchAllData() {
        presenter.fetchAllData()
        
    }
    
}

extension MapViewController: MGLMapViewDelegate {
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
}

extension MapViewController: MapScreenView {
    
    func configurePoint(latitude: Double, longitude: Double, subtitle: String) {
        mapView.setCenter(CLLocationCoordinate2D(latitude: latitude, longitude: longitude), zoomLevel: 2, animated: true)
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        annotation.title = "Astronauts:"
        annotation.subtitle = subtitle
    }
    
    func showError(with message: String) {
        let alertAction = UIAlertAction(title: "OK", style: .default)
        let allertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        allertController.addAction(alertAction)
        present(allertController, animated: true, completion: nil)
    }
    
    func setTime(time: String) {
        timeLabel.text = "last API sync: \(time)"
    }
}

