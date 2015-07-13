//
//  TripHistoryViewControllerTableViewController.swift
//  kcardielTripPlanner2
//
//  Created by Kyle on 6/2/15.
//  Copyright (c) 2015 DePaul University. All rights reserved.
//

import UIKit

class TripHistoryViewControllerTableViewController: UITableViewController {


  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  //This determineshow many sections will be in the table on the home screen
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  //This determines how many rows in the table need to be displayed
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return trips.count
  }

  //This determines what information to diplay in each row (Trip name and Destination)
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let trip = trips[indexPath.row]
    let cell = tableView.dequeueReusableCellWithIdentifier("Simple", forIndexPath: indexPath) as UITableViewCell
    
    cell.textLabel?.text = trip.tripName
    cell.detailTextLabel?.text = trip.endingLocation
    
    return cell
  }


  //This will deselect the rows once selected.
  override func tableView(tableView: UITableView,didSelectRowAtIndexPath indexPath: NSIndexPath) {
      self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
  }
  
  
  //Decided not to use accessory buttons
  //override func tableView(tableView: UITableView,accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
    //self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
  //}
  
  
  //This is how the trip infromation is selected is sent to the detail trip screen to display infromation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if let TripDetailViewController = segue.destinationViewController as?
      TripDetailViewController {
      if let cell = sender as? UITableViewCell {
        if let indexPath = self.tableView.indexPathForCell(cell) {
          TripDetailViewController.trip = trips[indexPath.row]
          TripDetailViewController.index = indexPath.row
        }
      }
    }
    
  }
  
  

  //This function allows the rows to be deleted on the home screen by swiping right to left
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == UITableViewCellEditingStyle.Delete {
      trips.removeAtIndex(indexPath.row)
      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
  }
  
  
}
