//
//  LocationCell.swift
//  FirstApplication
//
//  Created by Antares on 10.12.2021.
//

import UIKit
import MapKit
class LocationCell: UITableViewCell {
    var mapItem: MKMapItem! {
        didSet {
            guard let mapItem = mapItem else { return }
            title.text = mapItem.placemark.name
            place.text = mapItem.placemark.title
        }
    }
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var place: UILabel!
    
}
