//
//  AppDelegate.swift
//  ZumoRobotController
//
//  Created by Cătălin Crăciun on 29/09/14.
//  Copyright (c) 2014 Cătălin Crăciun. All rights reserved.
//  *******************************************************************************************
//  *                                                                                         *
//  **This code has been automaticaly converted to Swift language using MyAppConverter.com **
//  *                                                                                         *
//  *******************************************************************************************



import CoreData
import UIKit

@UIApplicationMain
class AppDelegate :UIResponder,UIApplicationDelegate
{
    var managedObjectContext:NSManagedObjectContext?
    var window:UIWindow?
    var persistentStoreCoordinator:NSPersistentStoreCoordinator?
    var managedObjectModel:NSManagedObjectModel?
    var _managedObjectContext:NSManagedObjectContext?
    var _managedObjectModel:NSManagedObjectModel?
    var _persistentStoreCoordinator:NSPersistentStoreCoordinator?
    var _window:UIWindow?
    func application( application:UIApplication ,didFinishLaunchingWithOptions launchOptions:[NSObject: AnyObject]? )->Bool{
        sleep( 3 )
        return true
        
    }
    func applicationWillResignActive( application:UIApplication ){
    }
    func applicationDidEnterBackground( application:UIApplication ){
    }
    func applicationWillEnterForeground( application:UIApplication ){
    }
    func applicationDidBecomeActive( application:UIApplication ){
    }
    func applicationWillTerminate( application:UIApplication ){
        self.saveContext()
        
    }
    func applicationDocumentsDirectory()->NSURL{
        return NSFileManager.defaultManager().URLsForDirectory(NSSearchPathDirectory.DocumentDirectory , inDomains: NSSearchPathDomainMask.UserDomainMask).last as! NSURL
    }
    
    func getManagedObjectModel()->NSManagedObjectModel{
        if _managedObjectModel != nil  {
            return _managedObjectModel!
            
            
        }
        
        var modelURL:NSURL = NSBundle.mainBundle().URLForResource("ZumoRobotController" , withExtension:"momd" )!
        
        _managedObjectModel! = NSManagedObjectModel(contentsOfURL:modelURL )!
        return _managedObjectModel!
        
    }
    func getPersistentStoreCoordinator()->NSPersistentStoreCoordinator?{
        if _persistentStoreCoordinator != nil  {
            return _persistentStoreCoordinator!
            
            
        }
        
        _persistentStoreCoordinator! = NSPersistentStoreCoordinator(managedObjectModel: self.getManagedObjectModel() )
        var storeURL:NSURL = self.applicationDocumentsDirectory().URLByAppendingPathComponent("ZumoRobotController.sqlite" )
        
        var error:NSErrorPointer? = nil
        
        var failureReason:NSString = "There was an error creating or loading the application&apos;s saved data."
        
        
        if _persistentStoreCoordinator!.addPersistentStoreWithType(NSSQLiteStoreType , configuration:nil , URL:storeURL , options:nil , error:error! ) != nil  {
            var dict:NSMutableDictionary = NSMutableDictionary()
            
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application&apos;s saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error?.memory
            
            if (error != nil) {
                error?.memory = NSError(domain:"YOUR_ERROR_DOMAIN" , code: 9999 , userInfo:dict as [NSObject : AnyObject] )
            }
            NSLog("Unresolved error %@, %@" , error!.memory! , error!.memory!.userInfo! )
            abort()
            
            
        }
        
        return _persistentStoreCoordinator!
        
    }
    func getManagedObjectContext()->NSManagedObjectContext?{
        if _managedObjectContext != nil  {
            return _managedObjectContext!
            
        }
        
        var coordinator:NSPersistentStoreCoordinator? = self.getPersistentStoreCoordinator()
        
        
        if (coordinator != nil){
            return nil
        }
        
        _managedObjectContext! = NSManagedObjectContext()
        _managedObjectContext!.persistentStoreCoordinator = coordinator
        return _managedObjectContext!
        
    }
    func saveContext(){
        var managedObjectContext:NSManagedObjectContext? = self.getManagedObjectContext()
        
        if (managedObjectContext != nil)  {
            var error:NSError? = nil
            
            if managedObjectContext!.hasChanges && managedObjectContext!.save(&error)   {
                NSLog("Unresolved error %@, %@" , error! , error!.userInfo! )
                abort()
                
                
            }
            
            
            
        }
        
        
    }
}