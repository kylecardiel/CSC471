//
//  TripDetailViewController.swift
//  kcardielTripPlanner2
//
//  Created by Kyle on 6/2/15.
//  Copyright (c) 2015 DePaul University. All rights reserved.
//

import UIKit
import MapKit
import AddressBook
import CoreLocation

class TripDetailViewController: UIViewController, MKMapViewDelegate {
  
  //All Labels displayed on screen
  @IBOutlet weak var TripNameLabel: UILabel!
  @IBOutlet weak var LocationLabel: UILabel!
  @IBOutlet weak var DestinationLabel: UILabel!
  @IBOutlet weak var startDateLabel: UILabel!
  @IBOutlet weak var endDateLabel: UILabel!
  @IBOutlet weak var BudgetLabel: UILabel!
  @IBOutlet weak var ExpenseLabel: UILabel!
  @IBOutlet weak var remainingLabel: UILabel!
  @IBOutlet weak var expDollarAmountLabel: UILabel!
  
  @IBOutlet weak var mapView: MKMapView!
  
  
  var trip : TripPlanner?
  var index : Int?
  
  var coords : CLLocationCoordinate2D?
  
  
  //Makes sure when the screen is loaded it displays a map of the suers current location
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsUserLocation = true
        mapView.delegate = self
      
    }

  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

  //This ensures whent he screen is loaded the specific trip infromation is loaded in the correct areas
  override func viewWillAppear(animated: Bool) {
    if let tp = trip {
      TripNameLabel.text = tp.tripName
      LocationLabel.text = tp.startingLocation
      DestinationLabel.text = tp.endingLocation
      startDateLabel.text = stringDate(tp.startDateTime)
      endDateLabel.text = stringDate(tp.endDateTime)
      
      
      setDollarAmmount()
      
      BudgetLabel.text = currencyFormat(tp.totalBudget)
      ExpenseLabel.text = currencyFormat(tp.totalExpenses)
      remainingLabel.text = currencyFormat(tp.remainingBudget())
    
    }

  }

  
  //Used to record slider change in value
  @IBAction func dollarAmountSet(sender: UISlider) {
    expDollarAmountLabel.text = currencyFormat(Double(sender.value))
  }
  
  
  
  //button that addes expenses to the trip and updates the displayed items
  @IBAction func addExpense(sender: UIButton) {
    var exp = 0.0
    if let text = expDollarAmountLabel.text {
      var subtext = dropFirst(text)
      exp = (subtext as NSString).doubleValue

      trips[self.index!].tripExpense.append(Double(exp))
      trips[self.index!].totalExpensesCalc()
      
      ExpenseLabel.text = currencyFormat(trips[self.index!].totalExpenses)
      remainingLabel.text = currencyFormat(trips[self.index!].remainingBudget())
      
    }
    
  }
  
  
  func setDollarAmmount(){
    trip?.totalBudgetCalc()
    trip?.totalExpensesCalc()
  }
  
  
  //This zooms the map into a region containing and centering on the users current location
  @IBAction func zoomIn(sender: AnyObject) {
    let userLocation = mapView.userLocation
    let region = MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, 2000, 2000)
    mapView.setRegion(region, animated: true)
  }
  
  
  //This toggles map view types using MKMap Type
  @IBAction func changeMapType(sender: AnyObject) {
    if mapView.mapType == MKMapType.Standard {
      mapView.mapType = MKMapType.Hybrid
    } else if mapView.mapType == MKMapType.Hybrid {
      mapView.mapType = MKMapType.Satellite
    } else {
      mapView.mapType = MKMapType.Standard
    }
  }
  
  @IBAction func getDirectionsButton(sender: UIButton) {
        self.getDirections()
  }
  
  
  //This uses geoCoder to convert string address into coordinates for the map to use for directions
  func getDirections() {
    
    let geoCoder = CLGeocoder()
    
    let addressString = self.trip?.endingLocation
    let request = MKDirectionsRequest()
    var mapitem : MKMapItem

    
    geoCoder.geocodeAddressString(addressString, completionHandler:
      {(placemarks: [AnyObject]!, error: NSError!) in
        
        if error != nil {
          println("Geocode failed with error: \(error.localizedDescription)")
        } else if placemarks.count > 0 {
          let placemark = placemarks[0] as CLPlacemark
          let location = placemark.location
          self.coords = location.coordinate
          
          
          var breakout : [String] = self.getEndAddress()
            
            
          let addressDict = [kABPersonAddressStreetKey as NSString: "",
            kABPersonAddressCityKey: breakout[0],
            kABPersonAddressStateKey: breakout[1],
            kABPersonAddressZIPKey: ""]
            
            
            let place = MKPlacemark(coordinate: self.coords!, addressDictionary: addressDict)
            
            let mapItem = MKMapItem(placemark: place)

          
          request.setSource(MKMapItem.mapItemForCurrentLocation())
          request.setDestination(mapItem)
          request.requestsAlternateRoutes = false
          
          let directions = MKDirections(request: request)
          
          directions.calculateDirectionsWithCompletionHandler({(response:
            MKDirectionsResponse!, error: NSError!) in
            
            if error != nil {
              println("Error getting directions")
            } else {
              self.showRoute(response)
            }
            
          })
          
        }
    }
    )
  }
  
  
  func getEndAddress() -> [String]{
     var breakout : [String]?
    
    if let tp = self.trip {
      let addressString = tp.endingLocation
      breakout = addressString.componentsSeparatedByString(", ")
    }
    return breakout!
  }
  
  
  
  //This is used to display the route on the map once calculated
  func showRoute(response: MKDirectionsResponse) {
    
    for route in response.routes as [MKRoute] {
      
      mapView.addOverlay(route.polyline,
        level: MKOverlayLevel.AboveRoads)
      
      for step in route.steps {
        println(step.instructions)
      }
    }
    let userLocation = mapView.userLocation
    let region = MKCoordinateRegionMakeWithDistance(
      userLocation.location.coordinate, 1500000, 1500000)
    
    mapView.setRegion(region, animated: true)
  }
  
  
  //This defines how the route should look when displayed
  func mapView(mapView: MKMapView!, rendererForOverlay
    overlay: MKOverlay!) -> MKOverlayRenderer! {
      let renderer = MKPolylineRenderer(overlay: overlay)
      
      renderer.strokeColor = UIColor.blueColor()
      renderer.lineWidth = 5.0
      return renderer
  }

  
  //This make sure when the map is loaded that the users location is centered on the screen
  func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
      mapView.centerCoordinate = userLocation.location.coordinate
  }
  
  
  func stringDate(dateIn : NSDate) -> String {
    let date = dateIn
    var dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    var dateString = dateFormatter.stringFromDate(date)
    return dateString
  }
  
  
  func currencyFormat(amountIn: Int) -> String {
    var amount = amountIn
    var formatter = NSNumberFormatter()
    formatter.numberStyle = .CurrencyStyle
    return formatter.stringFromNumber(amount)!
  }
  
  func currencyFormat(amountIn: Double) -> String {
    var amount = amountIn
    var formatter = NSNumberFormatter()
    formatter.numberStyle = .CurrencyStyle
    return formatter.stringFromNumber(amount)!
  }
  

  //This is used to pass data to the budget result screen
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if let AcessoryDetailViewController = segue.destinationViewController as?
      AcessoryDetailViewController {
            AcessoryDetailViewController.index = self.index!
    }
    
  }
  
  
  

}
