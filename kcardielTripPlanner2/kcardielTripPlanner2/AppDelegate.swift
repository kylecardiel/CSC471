//
//  AppDelegate.swift
//  kcardielTripPlanner2
//
//  Created by Kyle on 6/2/15.
//  Copyright (c) 2015 DePaul University. All rights reserved.
//

import UIKit
import CoreLocation



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  var locationManager: CLLocationManager?
  
  func application(application: UIApplication,
    didFinishLaunchingWithOptions
    launchOptions: [NSObject: AnyObject]?) -> Bool {
      
      locationManager = CLLocationManager()
      locationManager?.requestWhenInUseAuthorization()
      
      return true
  }

  func applicationWillResignActive(application: UIApplication) {

  }

  func applicationDidEnterBackground(application: UIApplication) {

  }

  func applicationWillEnterForeground(application: UIApplication) {

  }

  func applicationDidBecomeActive(application: UIApplication) {

  }

  func applicationWillTerminate(application: UIApplication) {

  }


}

