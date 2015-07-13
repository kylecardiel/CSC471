//
//  TripPlannerClass.swift
//  kcardielTripPlanner2
//
//  Created by Kyle on 6/2/15.
//  Copyright (c) 2015 DePaul University. All rights reserved.
//

import Foundation


//Initial Trips to load when opending app
var trips : [TripPlanner] = [
  
  TripPlanner(tripName: "PCB Family 2014",
    startDateTime: dateTesting(2014,8,25),
    endDateTime: dateTesting(2014,8,31),
    startingLocation: "Buffalo Grove, IL",
    endingLocation: "Panama City Beach, FL",
    tripBudget: [0,600,300,500,400],
    tripExpense: [289.73]),
  
  TripPlanner(tripName: "DSM 2013",
    startDateTime: dateTesting(2013,7,22),
    endDateTime: dateTesting(2013,7,31),
    startingLocation: "Buffalo Grove, IL",
    endingLocation: "Des Moines, IA",
    tripBudget: [0,0,120,350,250],
    tripExpense: [123.73]),
  
  TripPlanner(tripName: "Capital",
    startDateTime: dateTesting(2014,5,20),
    endDateTime: dateTesting(2014,5,27),
    startingLocation: "Buffalo Grove, IL",
    endingLocation: "Washington, DC",
    tripBudget: [150,200,0,150,150],
    tripExpense: [157.23,120.46])
  
  
]

//Trip Planner class. This is the foundation object that is being created, deleted, edited or viewed
class TripPlanner {
  
  var tripName : String
  var startDateTime : NSDate
  var endDateTime : NSDate
  var startingLocation : String
  
  var endingLocation:  String
  
  var tripBudget : [Int]
  var tripExpense : [Double]
  var totalBudget : Int = 0
  var totalExpenses : Double = 0
  
  
  init(tripName: String, startDateTime: NSDate, endDateTime: NSDate, startingLocation: String,endingLocation: String, tripBudget: [Int], tripExpense: [Double]){
    self.tripName = tripName
    self.startDateTime = startDateTime
    self.endDateTime = endDateTime
    self.startingLocation = startingLocation
    self.endingLocation = endingLocation
    self.tripBudget = tripBudget
    self.tripExpense = tripExpense
  }
  
  
  func addExpense(expense: Double){
    self.tripExpense.append(expense)
    totalExpensesCalc()
  }
  
  func totalBudgetCalc() {
    totalBudget = 0
    for a in tripBudget{
      totalBudget += a
    }
  }
  
  
  func totalExpensesCalc() {
    totalExpenses = 0
    for a in tripExpense{
      totalExpenses += a
    }
  }
  
  func remainingBudget() -> Double{
    return Double(self.totalBudget) - self.totalExpenses
  }
  
  
  func equalTo(other : TripPlanner) -> Int {
    
    if self.startDateTime.compare(other.startDateTime) == NSComparisonResult.OrderedDescending
    {
      return 1
    } else if self.startDateTime.compare(other.startDateTime) == NSComparisonResult.OrderedAscending
    {
      return -1
    } else
    {
      return 0
    }
  }
  
  
}





func dateTesting(year: Int, month: Int, day: Int) -> NSDate {
  let userCalendar = NSCalendar.currentCalendar()
  let DayComponents = NSDateComponents()
  DayComponents.year = year
  DayComponents.month = month
  DayComponents.day = day
  let Day = userCalendar.dateFromComponents(DayComponents)!
  var startDateTime: NSDate = Day
  return startDateTime
}