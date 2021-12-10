//
//  MapViewExtension.swift
//  FirstApplication
//
//  Created by Antares on 09.12.2021.
//

import UIKit
import MapKit
extension MKMapView {
    func setLocation(location: CLLocation, radius: Int, animation: Bool) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: CLLocationDistance(radius),
            longitudinalMeters: CLLocationDistance(radius))
        setRegion(coordinateRegion, animated: animation)
    }
}
