//
//  ZumoRobotManagerDelegate.swift
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
import Foundation
import CoreBluetooth

protocol ZumoRobotManagerDelegate {
    
    func log( string:NSString , silently:Bool )
}

class ZumoRobotManager :NSObject,CBPeripheralDelegate,CBCentralManagerDelegate
{
    var centralManager:CBCentralManager?
    var characteristics:CBCharacteristic?
    var selectedPeripheral:CBPeripheral?
    var connectedToDevice:Bool?
    var delegate:AnyObject?//UIViewController<ZumoRobotManagerDelegate>?
    var transmissionIntervalRestriction:CInt?
    var silentIncorectPassword:Bool?
    var _centralManager:CBCentralManager?
    var _selectedPeripheral:CBPeripheral?
    var _characteristics:CBCharacteristic?
    var _connectedToDevice:Bool?
    var _delegate:UIViewController?
    
    
    class var sharedInstance:ZumoRobotManager{
        //2
        struct Static {
            //3
            static let instance:ZumoRobotManager = ZumoRobotManager()
        }
        //4
        return Static.instance
    }
    
    
    func sendConnectionRequestWithPassword(  var passwordToSend:NSString ){
        passwordToSend = passwordToSend.stringByAppendingString("$" )
        passwordToSend = passwordToSend.stringByAppendingString("\n" )
        
      for var i:CInt =  0; i <  5 ; i++ {
        for service:CBService in _selectedPeripheral!.services as! [CBService]{
            for  characteristic:CBCharacteristic in service.characteristics as! [CBCharacteristic]{
                _selectedPeripheral!.writeValue(passwordToSend.dataUsingEncoding(NSUTF8StringEncoding),forCharacteristic:characteristic,
            type:CBCharacteristicWriteType.WithoutResponse);
            }
        }
        }
    
    
}
func sendString( var str:NSString ,avoidingRestriction avoid:Bool ){
    if self.connectedToDevice! {
        if transmissionIntervalRestriction	 >=  5  || avoid  {
            transmissionIntervalRestriction =  0
            str = str.stringByAppendingString("\n")
            NSLog("%@" , str )
           
            for service:CBService  in _selectedPeripheral!.services as! [CBService]{
                for characteristic:CBCharacteristic in service.characteristics as! [CBCharacteristic]{
                _selectedPeripheral!.writeValue(str.dataUsingEncoding(NSUTF8StringEncoding),
                forCharacteristic:characteristic,
                type:CBCharacteristicWriteType.WithoutResponse);
        
                }
            }
        
    }
    
    
    
}


}
    
    
    
func stringForVelocityX( var velX:Float ,var andY  velY:Float )->NSString{
    var stringToSend:NSString = ""
    
    var s1:NSString?
    
    var s2:NSString?
    
    if velX >  0  {
        s1 = "+"
        
        
    }else {
        s1 = "-"
        velX = -velX
        
    }
    
    if velY >  0  {
        s2 = "+"
        
        
    }else {
        s2 = "-"
        velY = -velY
        
    }
    
    stringToSend = stringToSend.stringByAppendingString(s1! as String )
    stringToSend = stringToSend.stringByAppendingString(s2! as String)
    var decsVelXInt:CInt = CInt((velX - CFloat(CInt(velX))) *  CFloat(100))
    
    var decsVelYInt:CInt = CInt((velY - CFloat(CInt(velY))) *  CFloat(100))
    
    var p:CInt =  10

    while (p >= 1) {
        stringToSend = stringToSend.stringByAppendingFormat("%d", decsVelXInt / p);
        decsVelXInt = decsVelXInt % p;
        p /= 10;
    }
    
    p = 10;
    while (p >= 1) {
        stringToSend = stringToSend.stringByAppendingFormat("%d", decsVelYInt / p);
        decsVelYInt = decsVelYInt % p;
        p /= 10;
    }
    
    return stringToSend;

}
func centralManager( central:CBCentralManager ,didDisconnectPeripheral peripheral:CBPeripheral! , error:NSError! ){
    (self.delegate! as! ZumoRobotManagerDelegate).log(NSString(format:"Disconnected from peripheral with UUID: %@" , peripheral!.identifier.UUIDString )  , silently: true )
    self.connectedToDevice = false
    
}
func centralManager( central:CBCentralManager ,didFailToConnectPeripheral peripheral:CBPeripheral , error:NSError! ){
    (self.delegate! as! ZumoRobotManagerDelegate).log("Connection to the peripheral failed! Check for errors!" , silently: false )
    self.connectedToDevice = false
    
}
func peripheral( peripheral:CBPeripheral! ,didUpdateValueForCharacteristic characteristic:CBCharacteristic! , error:NSError! ){
    
    
    // This code has been added manually check this github example : https://gist.github.com/nolili/a583ea045dafafebb17f

    
    var buffer = [UInt8](count: characteristic.value.length, repeatedValue: 0x00)
    characteristic!.value.getBytes(&buffer, length: buffer.count)
    
    var toRead = buffer
    
    if toRead[0] == 36  && toRead[ 1] == 115   && toRead[ 2] == 117   && toRead[ 3] == 99   {
        self.connectedToDevice = true
        silentIncorectPassword = true
        (self.delegate! as! ZumoRobotManagerDelegate).log("Password was correct! Access granted!" , silently: false )
        
        
    }else {
        if toRead[ 0] == 36  && toRead[ 1] == 102   && toRead[ 2] == 97   && toRead[ 3] == 105   {
            self.connectedToDevice? = false
            (self.delegate! as! ZumoRobotManagerDelegate).log("Incorrect password! Failed to connect to the bluetooth device" , silently: silentIncorectPassword! )
            
            
        }
        
        
    }
    
    
}
func peripheral(peripheral:CBPeripheral! ,didDiscoverDescriptorsForCharacteristic characteristic:CBCharacteristic! , error:NSError! ){
    (self.delegate! as! ZumoRobotManagerDelegate).log("Discovered descriptor" , silently: true )
    self.selectedPeripheral = peripheral
    //for }


}
func peripheral( peripheral:CBPeripheral! ,didDiscoverCharacteristicsForService service:CBService! , error:NSError! ){
    (self.delegate! as! ZumoRobotManagerDelegate).log("Discovered characterisic" , silently:true )
   // for }


}
func peripheral( peripheral:CBPeripheral! ,didDiscoverServices error:NSError! ){
    (self.delegate! as! ZumoRobotManagerDelegate).log("Discovered service in peripheral" , silently:true )
   // for }


}
func centralManager( central:CBCentralManager! ,didConnectPeripheral peripheral:CBPeripheral! ){
    (self.delegate! as! ZumoRobotManagerDelegate).log("Succeded to connect to peripheral!" , silently:true )
    peripheral!.delegate = self
    peripheral!.discoverServices(nil )
    
}
    
func centralManager( central:CBCentralManager! ,didDiscoverPeripheral peripheral:CBPeripheral! , advertisementData:[NSObject : AnyObject]! , RSSI:NSNumber! ){
    var uuidOfDevice:NSString = peripheral.identifier.UUIDString
    
    if uuidOfDevice.length == 0 {
        (self.delegate! as! ZumoRobotManagerDelegate).log(NSString(format:"Discovered peripherial with UUID: %@" , uuidOfDevice )  , silently:false )
        self.selectedPeripheral? = peripheral!
        central!.connectPeripheral(peripheral! , options:nil )
        var passwordAlert:UIAlertController = UIAlertController(title :"Stop! Connection needs password!" , message:"Enter the password in order to get access to the bluetooth device" , preferredStyle:UIAlertControllerStyle.Alert )
        
        passwordAlert.addTextFieldWithConfigurationHandler( { (textField:UITextField!) in
            textField.secureTextEntry = true;
            textField.keyboardType = UIKeyboardType.NumberPad;
            textField.keyboardAppearance = UIKeyboardAppearance.Dark;
        })
        passwordAlert.addAction(UIAlertAction(title:"Cancel" , style:UIAlertActionStyle.Destructive , handler:nil )  )
        passwordAlert.addAction(UIAlertAction(title:"Done" , style:UIAlertActionStyle.Default ,  handler:nil   ))
        self.delegate?.presentViewController(passwordAlert , animated:true , completion:nil )

    }
    
    
}
func centralManagerDidUpdateState( central:CBCentralManager! ){
    
    if central!.state != CBCentralManagerState.PoweredOn  {
        (self.delegate! as! ZumoRobotManagerDelegate).log("Bluetooth should be turned on!" , silently:false )
        
    }else {
        (self.delegate! as! ZumoRobotManagerDelegate).log("Scanning for bluetooth devices..." , silently:false )
        central!.scanForPeripheralsWithServices(nil , options:nil )
        
    }
    
    
}
func connectToDevice(){
    
    if !self.connectedToDevice! {
        self.centralManager = CBCentralManager(delegate: self , queue:nil )
        
        
    }else {
        (self.delegate! as! ZumoRobotManagerDelegate).log("Already connected to device" , silently:false )
        
    }
    
    
}
func disconnectFromDevice(){
    
    if self.connectedToDevice!  {
        (self.delegate! as! ZumoRobotManagerDelegate).log("Disconnecting..." , silently:false )
        for var i:CInt =  0; i <  5 ; i++
        {
            ZumoRobotManager.sharedZumoRobotManager().sendString("$out" , avoidingRestriction:true )
            
            for var j:CInt =  0; j <=  10000000 ; j++
                
            {
                var x:CInt?
                
                x! =  0
                
            }
        }
        
        silentIncorectPassword = false
        self.connectedToDevice = false
        self.centralManager = nil
        
        
    }else {
        (self.delegate! as! ZumoRobotManagerDelegate).log("Not connected to any device!" , silently:false )
        
    }
    
    
}
    
class func sharedZumoRobotManager()->ZumoRobotManager{

    
    //Single Pattern goes here
    NSLog("isConnected %@", sharedInstance.connectedToDevice!)
    
    return sharedInstance;
    
}
func alloc(){
    
}
func updateCounter(){
    transmissionIntervalRestriction?++
    
}
override init(){
    
    super.init()
        NSLog("*** ZumoRobotManager - Shared instance initialised" )
        self.connectedToDevice = false
        silentIncorectPassword = false
    var timer:NSTimer = NSTimer(timeInterval:NSTimeInterval( 0.050000) , target:self , selector:Selector("updateCounter") , userInfo:nil , repeats:true )
        
        NSRunLoop.currentRunLoop().addTimer(timer , forMode:NSDefaultRunLoopMode )
        timer.fire()
        
        
    }


}
