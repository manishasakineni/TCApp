//
//  InfoMapTableViewCell.swift
//  Telugu Churches
//
//  Created by Manoj on 21/02/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Contacts

@available(iOS 11.0, *)
class InfoMapTableViewCell: UITableViewCell,CLLocationManagerDelegate {
    
    @IBOutlet weak var backGroundView: UIView!
    
    @IBOutlet weak var mapViewOutLet: MKMapView!
    
    let manager = CLLocationManager()
    let annotation = MKPointAnnotation()
    
     //MARK: - Color

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        
        backGroundView.layer.cornerRadius = 3.0
        backGroundView.layer.shadowColor = UIColor.lightGray.cgColor
        backGroundView.layer.shadowOffset = CGSize(width: 0, height: 3)
        backGroundView.layer.shadowOpacity = 0.6
        backGroundView.layer.shadowRadius = 2.0

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    @available(iOS 11.0, *)
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//
//        guard let annotation = annotation as?  MKPointAnnotation else { return nil }
//        // 3
//        let identifier = "marker"
//        var view: MKMarkerAnnotationView
//        // 4
//        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
//            as? MKMarkerAnnotationView {
//            dequeuedView.annotation = annotation
//            view = dequeuedView
//        } else {
//            // 5
//            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//            view.canShowCallout = true
//            view.calloutOffset = CGPoint(x: -5, y: 5)
//            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//        }
//        return view
//    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let lat = kUserDefaults.string(forKey: kLatitude) {
            
            if let long = kUserDefaults.string(forKey: kLongitude) {
                
                let location = locations[0]
                let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
                let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(Double(lat)!, Double(long)!)
                annotation.coordinate = CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(long)!)
                mapViewOutLet.addAnnotation(annotation)
                let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
                mapViewOutLet.setRegion(region, animated: true)
                
                print(myLocation.latitude)
                print(myLocation.longitude)
                self.mapViewOutLet.showsUserLocation = true
                
                CLGeocoder().reverseGeocodeLocation(location) { (placemark, error) in
                    
                    if error != nil
                    {
                        print("There was as error")
                    }
                    else
                    {
                        if let place = placemark?[0]
                        {
                            self.annotation.subtitle = "\(String(describing: place.name!))"
                            self.annotation.title = "\(String(describing: place.locality!)) "
                            //self.label.text = "\(String(describing: place.locality!)) \n \(String(describing: place.country!)) \n \(String(describing: place.location!))"
                        }
                        
                    }
                }
            }
            
        }
        
        
        
    }
   
}

@available(iOS 11.0, *)
extension InfoMapTableViewCell: MKMapViewDelegate {
    // 1
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2
        guard let annotation = annotation as?  MKPointAnnotation else { return nil }
        // 3
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
//    func mapItem() -> MKMapItem {
//        let addressDict = [CNPostalAddressStreetKey: subtitle!]
//        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
//        let mapItem = MKMapItem(placemark: placemark)
//        mapItem.name = title
//        return mapItem
//    }
//
//    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
//                 calloutAccessoryControlTapped control: UIControl) {
//        let location = view.annotation as! Artwork
//        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
//        location.mapItem().openInMaps(launchOptions: launchOptions)
//    }
    
}
