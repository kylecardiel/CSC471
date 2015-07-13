//
//  NewTripViewController.swift
//  kcardielTripPlanner2
//
//  Created by Kyle on 6/2/15.
//  Copyright (c) 2015 DePaul University. All rights reserved.
//

let labels = [
  "Name",
  "Location",
  "Destination",
  "Flight",
  "Hotel",
  "Rental Car",
  "Food",
  "Entertainment",
  "Other"
]

var newTrip : TripPlanner?

import UIKit

class NewTripViewController: UIViewController {

  //This outlet allows use to dismiss keyboards by touching it.
  @IBOutlet weak var Control: UIControl!
  
  //All UI outlets displayed on the screen
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Location: UITextField!
    @IBOutlet weak var Destination: UITextField!
    @IBOutlet weak var Flight: UITextField!
    @IBOutlet weak var Hotel: UITextField!
    @IBOutlet weak var RentalCar: UITextField!
    @IBOutlet weak var Food: UITextField!
    @IBOutlet weak var Entertainment: UITextField!
    @IBOutlet weak var Other: UITextField!
  
    @IBOutlet weak var Date: UIDatePicker!
  
    @IBOutlet weak var TripLength: UILabel!
    @IBOutlet weak var TripLengthStepper: UIStepper!
  
  @IBOutlet weak var CreateNewTrip: UIButton!
  
  var tripNameNew : String = ""
  var startingLocationNew : String = ""
  var endingLocationNew :  String = ""
  var tripBudgetNew : [Int] = [0,0,0,0,0,0]
  var tripLength : Int = 1
  var startDateTimeNew : NSDate?
  var endDateTimeNew : NSDate?
  
  
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

//This allows the keyboards with the done button to be dismissed from the screen
  @IBAction func editEnded(sender: UITextField) {
    sender.resignFirstResponder()
  }
  
//This allows any keyboard to be dismissed by touching the UIControl
  @IBAction func backgroundTouched(sender: UIControl) {
    Name.resignFirstResponder()
    Location.resignFirstResponder()
    Destination.resignFirstResponder()
    Flight.resignFirstResponder()
    Hotel.resignFirstResponder()
    RentalCar.resignFirstResponder()
    Food.resignFirstResponder()
    Entertainment.resignFirstResponder()
    Other.resignFirstResponder()
  }
  
  
  //Used to calculate the trip length in days
  @IBAction func tripStepperPressed(sender: UIStepper) {
    if (Int(sender.value) < 31 || Int(sender.value) > 0) {
      TripLength.text = "\(Int(sender.value))"
      tripLength = Int(sender.value)
    }
  }
  
  
  //Departure button on the screen which calls createNewTrip function
  @IBAction func createNewTripButton(sender: UIButton) {
    createNewTrip()
  }
  
  
  
  
  func createNewTrip(){
    
    
    //First part of the funct pulls all the information off the screent hat the user entered
    if let tb = Other.text.toInt()? {
      tripBudgetNew[5] = tb
    } else {
      tripBudgetNew[5] = 0
    }
    
    
    tripNameNew = Name.text
    startingLocationNew = Location.text
    endingLocationNew = Destination.text
    //"Flight"
    if let fb = Flight.text.toInt()? {
      tripBudgetNew[0] = fb
    } else {
      tripBudgetNew[0] = 0
    }
    
    //"Hotel"
    if let hb = Hotel.text.toInt()? {
      tripBudgetNew[1] = hb
    } else {
      tripBudgetNew[1] = 0
    }
    
    //"Rental Car"
    if let rb = RentalCar.text.toInt()? {
      tripBudgetNew[2] = rb
    } else {
      tripBudgetNew[2] = 0
    }
    
    //"Food"
    if let fb = Food.text.toInt()? {
      tripBudgetNew[3] = fb
    } else {
      tripBudgetNew[3] = 0
    }
    
    //"Entertainment"
    if let eb = Entertainment.text.toInt()? {
      tripBudgetNew[4] = eb
    } else {
      tripBudgetNew[4] = 0
    }
    
    //"Other"
    if let tb = Other.text.toInt()? {
      tripBudgetNew[5] = tb
    } else {
      tripBudgetNew[5] = 0
    }
    
    startDateTimeNew = Date.date
    endDateTimeNew = endDate(startDateTimeNew!, length: tripLength)
    
    //create a new trip object
    newTrip = TripPlanner(tripName: tripNameNew, startDateTime: startDateTimeNew!, endDateTime: endDateTimeNew!, startingLocation: startingLocationNew, endingLocation: endingLocationNew, tripBudget: tripBudgetNew, tripExpense: [])
    
    //calculate total budget
    newTrip?.totalBudgetCalc()
    confirmationCheck()
    
    
  }
  
  
  //This function checks to make sure at least one budget field had a value, if not confirms the trip create from the user with an alert message
  func confirmationCheck(){
    
    
    if (tripNameNew.isEmpty ||
        startingLocationNew.isEmpty ||
        endingLocationNew.isEmpty  ||
        startDateTimeNew == nil  ||
        endDateTimeNew == nil  ||
        newTrip?.totalBudget == 0){
          
          let optionMenu = UIAlertController(title: "Warning", message: "Not all sections have been completed. Do you want to continue?", preferredStyle: .Alert)
          
          let overrrideAction = UIAlertAction(title: "Yes", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
                trips.append(newTrip!)
                self.confirmationAlert()
            
          })
          
          let cancelAction = UIAlertAction(title: "No", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
          })
          
          optionMenu.addAction(overrrideAction)
          optionMenu.addAction(cancelAction)
          
          self.presentViewController(optionMenu, animated: true, completion: nil)
      
    } else {
      trips.append(newTrip!)
      self.confirmationAlert()
    }
    
    

  
  
  
  }
  
  
  
  func confirmationAlert(){
    let alertController = UIAlertController(title: "Confirmation", message:
      "New trip to " + self.endingLocationNew + " has been create.  ENJOY!", preferredStyle: UIAlertControllerStyle.Alert)
    alertController.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.Default,handler: nil))
    
    self.presentViewController(alertController, animated: true, completion: nil)
    
  }
  
  
  
  
  
  //This function uses the date picker and stepper value to determine the end date of the trip
  
  func endDate(date : NSDate, length : Int) -> NSDate {
    var desc = date.description
    
    var strArr = split(desc) {$0 == "-"}
    var year = strArr[0].toInt()!
    var month = strArr[1].toInt()!
    
    var strArr2 = split(strArr[2]) {$0 == " "}
    var day = strArr2[0].toInt()! + length
    
    if day > 28 && month == 2 {
      month = 3
      day -= 28
    }
    
    if day > 30 && (month == 4 || month == 6 || month == 8 || month == 11)
    {
      month += 1
      day -= 30
    }
    
    if day > 31 && (month == 1 || month == 3 || month == 5 || month == 7 || month == 9 || month == 10 )
    {
      month += 1
      day -= 31
    }
    
    if day > 31 && month == 12 {
      month = 1
      day -= 31
      year += 1
    }
    
    return dateTesting(year, month, day)
    
  }
  
  
  

}
