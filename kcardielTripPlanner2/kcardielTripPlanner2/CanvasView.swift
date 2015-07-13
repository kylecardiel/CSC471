//
//  CanvasView.swift
//  kcardielTripPlanner2
//
//  Created by Kyle on 6/4/15.
//  Copyright (c) 2015 DePaul University. All rights reserved.
//  This is only scene after the budget test button is pressed and the large dollar image is left on top.

import UIKit

class CanvasView: UIView {
  
  let myImage : UIImage?

  var x : CGFloat = 0.0
  var y : CGFloat = 0.0
  var dx: CGFloat = 10.0
  var dy: CGFloat = 10.0
  var velocity: CGFloat = 1
  
  override func drawRect(rect: CGRect) {
    let myImage = UIImage(named: "money.png")
    let rect = CGRect(x: x, y: y, width: 375, height: 85)
    myImage?.drawInRect(rect)
  }

}
