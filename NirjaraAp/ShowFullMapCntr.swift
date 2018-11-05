//
//  ShowFullMapCntr.swift
//  NirjaraAp
//
//  Created by gadgetzone on 5/9/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import UIKit
import GoogleMaps

class ShowFullMapCntr: UIViewController,GMSMapViewDelegate {

    @IBOutlet weak var fullPageMapView: GMSMapView!
    
    var which = String()
    var dataOnMap : NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        var myString:NSString = "  Full Details"
        var myMutableString = NSMutableAttributedString()
        
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: CGFloat(GlobalVariables.fontSize))])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(hexcolor: GlobalVariables.titleColor), range: NSRange(location:0,length:14))
        
        
        titleLabel.attributedText = myMutableString
        
        navigationItem.titleView = titleLabel
        self.updateBackButton()
        
        
        fullPageMapView.delegate = self
        fullPageMapView.layer.shadowColor = UIColor.rgb(hexcolor: GlobalVariables.mapbelowColor).cgColor
        fullPageMapView.layer.shadowOffset = CGSize(width : 2.5,height:3.5)
        fullPageMapView.layer.shadowOpacity = 0.8;
        fullPageMapView.layer.shadowRadius = 2.5;
        fullPageMapView.layer.masksToBounds = false
        let camera = GMSCameraPosition.camera(withLatitude: Double(GlobalVariables.currentLat)!, longitude: Double(GlobalVariables.currentLong)!, zoom: 13.0)
        self.fullPageMapView.camera = camera
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: Double(GlobalVariables.currentLat)!, longitude: Double(GlobalVariables.currentLong)!)
        marker.title = String(describing: GlobalVariables.currentAddres)
        marker.map = self.fullPageMapView
        
        
        if(which == "ViharStay"){
            for i in 0..<self.dataOnMap.count{
                
                var latAndLong = self.dataOnMap[i] as! viharStayModel
                let markerImage = UIImage(named: "d2-blue")!.withRenderingMode(.alwaysOriginal)
                let markerView = UIImageView(image: markerImage)
                markerView.tintColor = UIColor.red
                let position = CLLocationCoordinate2D(latitude: Double(latAndLong.vihar_latitude)!, longitude: Double(latAndLong.vihar_longitude)!)
                let london = GMSMarker(position: position)
                london.title = "Title".localized1+" : "+latAndLong.name
                london.snippet = "\("ContactNumber".localized1+" : "+latAndLong.contact!) \n \("JainFamily".localized1+" : "+latAndLong.jain_family_around!)\n \("Address".localized1+" : "+latAndLong.vihar_address!)\n \("Distance"+" : "+latAndLong.distance!)"
                
                london.iconView = markerView
                london.map = self.fullPageMapView
                
            }
        }else if(which == "TempleSthanak"){
            for i in 0..<self.dataOnMap.count{
                
                var latAndLong = self.dataOnMap[i] as! templeSthanakModel
                let markerImage = UIImage(named: "d3-blue")!.withRenderingMode(.alwaysOriginal)
                let markerView = UIImageView(image: markerImage)
                markerView.tintColor = UIColor.red
                let position = CLLocationCoordinate2D(latitude: Double(latAndLong.latitude)!, longitude: Double(latAndLong.longitude)!)
                let london = GMSMarker(position: position)
                london.title = "Title".localized1+" : "+latAndLong.temple_name
                //london.snippet = "Address".localized1+" : "+latAndLong.location
                london.snippet = "\("Address".localized1+" : "+latAndLong.location!) \n \("Distance"+" : "+latAndLong.distance)"
                
                london.iconView = markerView
                london.map = self.fullPageMapView
            }
        }else if(which == "GuruTracking"){
            for i in 0..<self.dataOnMap.count{

                var latAndLong = self.dataOnMap[i] as! guruMarkerModel
                let markerImage = UIImage(named: "d1-blue")!.withRenderingMode(.alwaysOriginal)
                let markerView = UIImageView(image: markerImage)
                markerView.tintColor = UIColor.red
                let position = CLLocationCoordinate2D(latitude: Double(latAndLong.guru_latitude)!, longitude: Double(latAndLong.guru_longitude)!)
                let london = GMSMarker(position: position)
                //london.title = latAndLong.guru_name
                // london.snippet = "\("Contact No. : "+latAndLong.guru_contact!)"
                london.snippet = "\("GuruName".localized1+" : "+latAndLong.guru_name!) \n \("Adithana".localized1+" : "+latAndLong.adithana!)"
                
                // london.infoWindowAnchor = CGPoint(x: 0.5, y: 0.5)
                london.iconView = markerView
                //london.icon = UIImage(named: "d2-blue")
                london.map = self.fullPageMapView
            }
        }else if(which == "ActiveSamajSeva"){
            for i in 0..<self.dataOnMap.count{
                
                var latAndLong = self.dataOnMap[i] as! activeSamajSevaModel
                
                let markerImage = UIImage(named: "d11-blue")!.withRenderingMode(.alwaysOriginal)
                let markerView = UIImageView(image: markerImage)
                markerView.tintColor = UIColor.red
                let position = CLLocationCoordinate2D(latitude: Double(latAndLong.latitude)!, longitude: Double(latAndLong.longitude)!)
                let london = GMSMarker(position: position)
                london.title = "Title".localized1+" : "+latAndLong.name
                //london.snippet = latAndLong.contact
                london.snippet = "\("ContactNumber".localized1+" : "+latAndLong.contact!) \n \("Time".localized1+" : "+latAndLong.time_from!+" - "+latAndLong.time_to)\n \("Address".localized1+" : "+latAndLong.address!)\n \("Distance"+" : "+latAndLong.distance!)"
                london.iconView = markerView
                london.map = self.fullPageMapView
                
            }
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
