//
//  MapViewController.swift
//  FirstApplication
//
//  Created by Antares on 09.12.2021.
//

import UIKit
import CoreLocation
import MapKit
class MapViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    private var locationManager: CLLocationManager!
    private var locations: [MKMapItem] = []
    private var annotation: MKAnnotation?
    
    private var isFollowing = false
    private var isHiddenLocation: Bool {
        get {
            return locationTable.isHidden
        }
        set {
            locationTable.isHidden = newValue
        }
    }
    
    @IBOutlet weak var searchAndButton: NSLayoutConstraint!
    @IBOutlet weak var buttonAndSafeArea: NSLayoutConstraint!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var locationTable: UITableView!
    @IBOutlet weak var hideOrShowLocationButton: UIButton!
    
    override func viewDidLoad() {
        searchField.delegate = self
        
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        setCurrentLocation()
        
        mapView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(pan(_:))))
        
        hideLocations()
    }
    
    @objc func pan(_ sender: UIPanGestureRecognizer) {
        stopFollowing()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if (!isFollowing) { return }
        guard let lastLocation = locations.last else { return }
        mapView.setLocation(location: lastLocation, radius: 100, animation: true)
    }
    
    @IBAction func actionFollow(_ sender: Any) {
        if (!isFollowing) {
            startFollowing()
        } else {
            stopFollowing()
        }
    }
    
    func setCurrentLocation() {
        guard let curLocation = locationManager.location else { return }
        mapView.setLocation(location: curLocation, radius: 100, animation: true)
    }
    
    func startFollowing() {
        isFollowing = true
        UIView.animate(withDuration: 0.2) {
            [weak self] in
            guard let button = self?.followButton else { return }
            button.layer.cornerRadius = button.frame.width / 2
            button.backgroundColor = #colorLiteral(red: 0, green: 0.4695425571, blue: 1, alpha: 1)
            self?.setCurrentLocation()
        }
    }
    
    func stopFollowing() {
        isFollowing = false
        self.followButton.backgroundColor = nil
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let name = textField.text else { return }
        if (name.isEmpty) {
            locations = []
            hideLocations()
        } else {
            findLocation(name: name)
            showLocations()
        }
    }
    
    func findLocation(name: String) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = name
        let search = MKLocalSearch(request: searchRequest)
        search.start { [weak self] (response, error) in
            guard let response = response else {
                return
            }
            self?.locations = response.mapItems
            self?.locationTable.reloadData()
        }
    }
    
    @IBAction func hideOrShow(_ sender: Any) {
        if (!locations.isEmpty) {
            if (isHiddenLocation) {
                showLocations()
            } else {
                hideLocations()
            }
        }
    }
    
    func showHideOrShowButton() {
        hideOrShowLocationButton.backgroundColor = UIColor.white
        hideOrShowLocationButton.isHidden = false
        buttonAndSafeArea.isActive = true
        searchAndButton.isActive = false
    }
    
    func hideHideOrShowButton() {
        if (!locations.isEmpty) {
            hideOrShowLocationButton.backgroundColor = #colorLiteral(red: 0, green: 0.4695425571, blue: 1, alpha: 1)
        } else {
            hideOrShowLocationButton.isHidden = true
            buttonAndSafeArea.isActive = false
            searchAndButton.isActive = true
        }
    }
    
    func showLocations() {
        isHiddenLocation = false
        showHideOrShowButton()
    }
    
    func hideLocations() {
        isHiddenLocation = true
        hideHideOrShowButton()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell") as! LocationCell
        cell.mapItem = locations[indexPath.row]
        return cell
    }
    
    func setAnnotation(item: MKMapItem) {
        if (annotation != nil) {
            mapView.removeAnnotation(annotation!)
        }
        let annotation = MKPointAnnotation()
        annotation.title = item.name
        annotation.coordinate = item.placemark.coordinate
        mapView.addAnnotation(annotation)
        self.annotation = annotation
        stopFollowing()
        guard let location = item.placemark.location else { return }
        mapView.setLocation(location: location, radius: 100, animation: true)
        hideLocations()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? LocationCell else { return }
        setAnnotation(item: cell.mapItem)
    }
    
}
