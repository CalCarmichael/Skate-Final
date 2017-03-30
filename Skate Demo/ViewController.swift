//
//  ViewController.swift
//  Skate Demo
//
//  Created by Callum Carmichael (i7726422) on 15/03/2017.
//  Copyright © 2017 Callum Carmichael (i7726422). All rights reserved.
//

import UIKit
import Firebase
import Mapbox
import MapKit

class ViewController: UIViewController, SideBarDelegate, MGLMapViewDelegate {
    
    
    @IBOutlet weak var mapView: MGLMapView!
    
    
    //Filtering annotations for sidebar
    
    func sideBarDidSelectButtonAtIndex(_ index: Int) {
       mapView.removeAnnotations(mapView.annotations!)
        
        for park in skateparks {
            
            if index == 0 {
                addAnnotation(park: park)
            }
            
            if index == 1 && park.type == .park {
                addAnnotation(park: park)
            }
            
            if index == 2 && park.type == .street {
                addAnnotation(park: park)
            }
            
            
        }
        
    }

    var sideBar: SideBar = SideBar()
    
    var skateparks = [Skatepark]()
    
    let locationsRef = FIRDatabase.database().reference(withPath: "locations")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Initiates the mapView
        
        mapView.delegate = self
        
        
        //Sidebar
        
        sideBar = SideBar(sourceView: self.view, skateItems: ["All Skate Spots", "Skateparks", "Street Skating"])
        sideBar.delegate = self
        
        
        // Passing firebase annotation data
        
        locationsRef.observe(.value, with: { snapshot in
            self.skateparks.removeAll()
            
            for item in snapshot.children {
                guard let snapshot = item as? FIRDataSnapshot else { continue }
                
                let newSkatepark = Skatepark(snapshot: snapshot)
                
                self.skateparks.append(newSkatepark)

                self.addAnnotation(park: newSkatepark)
            }
        })
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.sendSubview(toBack: mapView)
    }
    
    
    //Adding annotations on map
    
    func addAnnotation(park: Skatepark) {

        let point = MGLPointAnnotation()
        
        point.coordinate = park.coordinate

        point.title = park.name
        
        point.subtitle = park.subtitle
        
        mapView.addAnnotation(point)
        
        mapView.selectAnnotation(point, animated: true)
        
    }
    

    //Show the annotation callout

 func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
    
    return true
    

    }
    
    
    //Hide the callout view
    
    func mapView(_ mapView: MGLMapView, annotation: MGLAnnotation, calloutAccessoryControlTapped control: UIControl) {
        
        mapView.deselectAnnotation(annotation, animated: false)

    }

    //Image for Annotation - Change for Skatepark/StreetSkating
    
     func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {
        
        return nil
        
    }

}
