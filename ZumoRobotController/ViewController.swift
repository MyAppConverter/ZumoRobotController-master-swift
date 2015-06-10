//
//  ViewController.swift
//  ZumoRobotController
//
//  Created by Cătălin Crăciun on 29/09/14.
//  Copyright (c) 2014 Cătălin Crăciun. All rights reserved.
//  *******************************************************************************************
//  *                                                                                         *
//  **This code has been automaticaly converted to Swift language using MyAppConverter.com **
//  *                                                                                         *
//  *******************************************************************************************

import UIKit


class ViewController :UIViewController,ccJoystickDelegate, ZumoRobotManagerDelegate
{
    @IBOutlet weak var robotsConsole:UITextView?
    @IBOutlet var  joystick:ccJoystick?
    
    var _robotsConsole:UITextView?
    
    
    
    func log( string:NSString ,silently:Bool ){
        NSLog("%@" , string )
        if !silently{
            var finalMessage:NSString = "➤  ".stringByAppendingString(string as String )
            
            self.robotsConsole?.text = finalMessage.stringByAppendingString("\n" ).stringByAppendingString(self.robotsConsole!.text!) as String
            
            	
        }
        
        
    }
    
    func velocityDidChangeWithX( velX:CFloat ,andY velY:CFloat ,withPriority priority:Bool ){
        ZumoRobotManager.sharedZumoRobotManager().sendString(ZumoRobotManager.sharedZumoRobotManager().stringForVelocityX(velX, andY:velY), avoidingRestriction:priority);
        
    }
    
    @IBAction func lightBlueLed( sender:AnyObject ){
        if ZumoRobotManager.sharedZumoRobotManager().connectedToDevice! {
            self.log("Lighting the blue led", silently: false)
            ZumoRobotManager.sharedZumoRobotManager().sendString("c$b", avoidingRestriction:true);
        }
    }
    
    @IBAction func lightGreenLed( sender:AnyObject ){
        if ZumoRobotManager.sharedZumoRobotManager().connectedToDevice! {
            self.log("Lighting the green led", silently: false)
            ZumoRobotManager.sharedZumoRobotManager().sendString("c$g", avoidingRestriction:true);
        }
    }
    
    @IBAction func lightRedLed( sender:AnyObject ){
        if ZumoRobotManager.sharedZumoRobotManager().connectedToDevice! {
            self.log("Lighting the red led", silently: false)
            ZumoRobotManager.sharedZumoRobotManager().sendString("c$r", avoidingRestriction: true)
        }
    }
    
    @IBAction func disconnectButtonPressed( sender:UIButton ){
        ZumoRobotManager.sharedZumoRobotManager().disconnectFromDevice()
    }
    
    @IBAction func clearButtonPressed( sender:UIButton ){
        self.robotsConsole?.text = ""
        
    }
    @IBAction func connectButtonPressed( sender:UIButton ){
        ZumoRobotManager.sharedZumoRobotManager().connectToDevice();
    }
    override func viewDidLoad(){
        super.viewDidLoad()
        self.joystick?.delegate = self;
        ZumoRobotManager.sharedZumoRobotManager().delegate = self;

        
    }
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
        
    }
}