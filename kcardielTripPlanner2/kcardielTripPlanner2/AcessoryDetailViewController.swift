//
//  AcessoryDetailViewController.swift
//  kcardielTripPlanner2
//
//  Created by Kyle on 6/4/15.
//  Copyright (c) 2015 DePaul University. All rights reserved.
//

import UIKit


var gloablLabel : UILabel?

class AcessoryDetailViewController: UIViewController {

  @IBOutlet weak var canvas: CanvasView!
  @IBOutlet weak var testingLabel: UILabel!
  



  @IBAction func buttonTouched(sender: UIButton) {
    self.showBudget()
  }

  

  var trip : TripPlanner?
  var index : Int = 0


  //Makes sure the specific trip information is deiplayed when the screen is loaded as well as an image of several dollars
    override func viewDidLoad() {
        super.viewDidLoad()
        trip = trips[index]
        testingLabel.text = trip?.tripName
      
      

      var label = UILabel()
      label.backgroundColor = UIColor(patternImage: UIImage(named: "money 2")!)
      label.frame = CGRect(x: 0, y: 101, width: 375, height: 85)
      view.addSubview(label)
      gloablLabel = label
      
      
    }


 func showBudget(){
    
    var y: CGFloat = 203
    
    
    if let tp = trip {
      var exp = tp.totalExpenses
      var bud = tp.totalBudget
      
      var percentage = exp/Double(bud)
      
      if percentage <= 1 {
        var newy = 380 - (200 * (1 - percentage))
        y = CGFloat(newy)
      } else {
        var newy = 380 + (250 * (percentage - 1))
        if newy > 608 {
          newy = 608
        }
        y = CGFloat(newy)
      }
      
      
      
      
      UIView.animateWithDuration(3.0, animations: {
        gloablLabel!.frame = CGRect(x: 110, y: y, width: 105, height: 45)
        }, completion: nil)
      
      
    }
    
    
    
  }
  
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


  
  
  

}
