//
//  ContactInformationCell.swift
//  GlobalReach
//
//  Created by Mohit Kumar  on 23/05/20.
//  Copyright © 2020 Unica Solutions. All rights reserved.
//

import UIKit
import GoogleMaps
class ContactInformationCell: UITableViewCell {
    
    @IBOutlet var card: UIView!
    @IBOutlet var mapView: GMSMapView!
    
    @IBOutlet var address: UILabel!
     let geocoder = CLGeocoder()
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    func configure(_ model:InstituteDetailsModel){
        self.card.cardView()
        self.address.text = model.address
      //  self.loadMap(model.address)
        print(model.address.count)
        if model.address.count > 100 {
            let address = model.name + " " + model.state
            self.geoCoder(address: address)
        }else{
           self.geoCoder(address: model.address)
        }
       
    }

}

extension ContactInformationCell {
    
    func geoCoder(address:String){

               geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
                   if((error) != nil){
                    print("Error", error?.localizedDescription )
                   }
                   if let placemark = placemarks?.first {
                       let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                       print("lat", coordinates.latitude)
                       print("long", coordinates.longitude)
                    
                    let camera = GMSCameraPosition.camera(withLatitude: coordinates.latitude, longitude: coordinates.longitude, zoom: 15)
                    self.mapView.settings.setAllGesturesEnabled(false)
                     self.mapView.delegate = self
                     self.mapView.camera   = camera
                     self.mapView.animate(to: camera)
                    let marker: GMSMarker  = GMSMarker()
                    marker.title           = "Address"
                    marker.snippet         = address
                     let icon              = UIImage(named: "location_icon")
                    marker.icon            = icon
                    marker.appearAnimation = .none
                     marker.position       = coordinates
                    DispatchQueue.main.async {
                        marker.map         = self.mapView
                        self.mapView.selectedMarker = marker
                        
                    }
                    
                    
                    
                    
                   }
               })
        
        
        
    }
    
}
extension ContactInformationCell:GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print(marker.position)
        if let url = URL(string: "http://maps.apple.com/?ll=\(marker.position.latitude),\(marker.position.longitude)"){
          UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
       
        return true
    }
}
//getLatLongFromPlaceId
extension ContactInformationCell {
    func getCordinatesFromPlaceId(_ placeId:String,block:@escaping(_ locationCord:CLLocationCoordinate2D)-> Swift.Void){
        guard StaticHelper.isInternetConnected else {
            showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            return
        }
       
        var  tempLocCord = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
        //ActivityView.show()
        WebServiceManager.instance.getLatLongFromPlaceId(placeId:placeId) { (status, json) in
            switch status {
            case StatusCode.Success:
                
                if let result = json["result"] as? [String:Any], let geo = result["geometry"] as? [String:Any],let location = geo["location"] as? [String:Any] {
                    if let latitude = location["lat"] as? Double,let longitude = location["lng"] as? Double  {
                      tempLocCord = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                    block(tempLocCord)
                    }
                
        
                }
                else{
                    if let msg = json["Message"] as? String {
                    self.showAlertMsg(msg:msg )
                         }
         block(tempLocCord)
                }
                ActivityView.hide()
            case StatusCode.Fail:
         block(tempLocCord)
                ActivityView.hide()
                self.showAlertMsg(msg: AlertMsg.InternectDisconnectError)
            case StatusCode.Unauthorized:
         block(tempLocCord)
                ActivityView.hide()
                self.showAlertMsg(msg: AlertMsg.UnauthorizedError)
            default:  block(tempLocCord)
            }
        }
    }
}
