//
//  ccJoystick.swift
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

protocol ccJoystickDelegate{
    func velocityDidChangeWithX( velX:CFloat ,andY velY:CFloat ,withPriority priority:Bool )
}



class ccJoystick :UIView
{
    var delegate:ccJoystickDelegate?
    var velocityX:CFloat?
    var velocityY:CFloat?
    var thumbJoystick:UIImageView?
    var _delegate:ccJoystickDelegate?
    var _velocityX:CFloat?
    var _velocityY:CFloat?
    
    override func touchesBegan( touches: Set<NSObject> ,withEvent event: UIEvent ){
        for touch in touches {
            var locationInView:CGPoint = (touch as! UITouch).locationInView(self)
            var locationInViewConv:CGPoint = (touch as! UITouch).locationInView(self) // Converted
            locationInViewConv.x = locationInViewConv.x - self.bounds.size.width/2
            locationInViewConv.y = self.bounds.size.height - locationInViewConv.y - self.bounds.size.height/2
            
            if sqrtf(Float(locationInViewConv.x * locationInViewConv.x + locationInViewConv.y * locationInViewConv.y)) <= Float(self.bounds.size.width/2) {
                
                thumbJoystick?.center = locationInView
                self.velocityX =  CFloat(locationInViewConv.x / self.bounds.size.width/2)
                self.velocityY = CFloat(locationInViewConv.y / self.bounds.size.height/2)
                
                self.delegate?.velocityDidChangeWithX(self.velocityX!, andY: self.velocityY!, withPriority:false)
            }
        }
        
        
        
    }
    override func touchesMoved( touches: Set<NSObject> ,withEvent event: UIEvent ){
        for touch in touches {
            var locationInView:CGPoint = (touch as! UITouch).locationInView(self);
            var locationInViewConv:CGPoint = (touch as! UITouch).locationInView(self) // Converted
            locationInViewConv.x = locationInViewConv.x - self.bounds.size.width/2
            locationInViewConv.y = self.bounds.size.height - locationInViewConv.y - self.bounds.size.height/2
            
            if sqrtf(Float(locationInViewConv.x) * Float(locationInViewConv.x) + Float(locationInViewConv.y) * Float(locationInViewConv.y)) <= Float(self.bounds.size.width/2 ){
                
                thumbJoystick?.center = locationInView
                self.velocityX = Float(locationInViewConv.x/(self.bounds.size.width/2))
                self.velocityY = Float(locationInViewConv.y/(self.bounds.size.height/2))
                
                self.delegate?.velocityDidChangeWithX(self.velocityX!, andY: self.velocityY!, withPriority:false)
            } else {
                var signX = 1, signY = 1
                if locationInViewConv.y < 0 {
                    signY = -1
                }
                if locationInViewConv.x < 0 {
                    signX = -1
                }
                var alpha = Float(atanf(Float(locationInViewConv.y / locationInViewConv.x)))
                
                
                var onCirclePointConv:CGPoint = CGPointMake(CGFloat(fabsf((cosf(alpha))))*CGFloat(self.bounds.size.width/2)*CGFloat(signX), CGFloat(fabsf((cosf(alpha))))*CGFloat(self.bounds.size.width/2)*CGFloat(signY))
                
                var onCirclePoint :CGPoint = CGPointMake(0,0) //must be initialised before stroring any value into it
                onCirclePoint.x = onCirclePointConv.x + CGFloat(self.bounds.size.width/2)
                onCirclePoint.y = self.bounds.size.height/2 - onCirclePointConv.y
                
                thumbJoystick?.center = onCirclePoint
                
                self.velocityX = CFloat(onCirclePointConv.x)/CFloat(self.bounds.size.width/2)
                self.velocityY = CFloat(onCirclePointConv.y)/CFloat(self.bounds.size.height/2)
                
                self.delegate?.velocityDidChangeWithX(self.velocityX!, andY: self.velocityY!, withPriority:false)
            }
        }
        
        
    }
    override func touchesEnded( touches: Set<NSObject> ,withEvent event: UIEvent ){
        thumbJoystick!.center = CGPointMake(self.bounds.size.width /  2  , self.bounds.size.height /  2  )
        self.velocityX =  0.000000
        self.velocityY =  0.000000
        self.delegate?.velocityDidChangeWithX( 0.000000 ,  andY: 0.000000 , withPriority: true )
        
    }
    override func drawRect( rect: CGRect ){
        var bigCircle:UIBezierPath = UIBezierPath(ovalInRect:self.bounds )
        
        bigCircle.addClip()
        UIColor.whiteColor().setFill()
        bigCircle.fill()
        var smallCircle:UIBezierPath = UIBezierPath(ovalInRect:CGRectInset(self.bounds,  CGFloat(12 * thumbJoystickScale(CInt(self.bounds.size.width))) ,  CGFloat(12 * thumbJoystickScale(CInt(self.bounds.size.width)))))
            
            UIColor(red: 0.650000 , green: 0.650000 , blue: 0.650000 , alpha: 1.000000 ).setFill()
            smallCircle.fill()
        thumbJoystick = UIImageView(image:UIImage(CGImage:UIImage(named:"thumbJoystick" )?.CGImage! , scale: CGFloat(1 / thumbJoystickScale(CInt(self.bounds.size.width )))   , orientation:UIImageOrientation.Left )  )
            self.addSubview(thumbJoystick! )
            thumbJoystick!.center = CGPointMake(self.bounds.size.width /  2  , self.bounds.size.height /  2  )
        
    }
    func setup(){
        self.opaque = false
        self.backgroundColor = nil
        self.velocityX =  0.000000
        self.velocityY =  0.000000
        self.userInteractionEnabled = true
        
    }
    override func awakeFromNib(){
        super.awakeFromNib()
        self.setup()
        
    }
    
    override init(frame: CGRect){
        super.init(frame:frame)
        self.setup()
    }
    
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    func thumbJoystickScale( width:CInt )->CFloat{
        return CFloat(width) /  175.000000
        
    }
    func absolute( x: CInt )->CFloat{
        if x <  0  {
            return CFloat(x)
            
            
        }
        
        return CFloat(x)
        
    }
    func minimum( a: CInt , b: CInt )->CFloat{
        if a < b  {
            return CFloat(a)
            
            
        }
        
        return CFloat(b)
        
    }
    func maximum( a: CInt , b: CInt )->CFloat{
        if a > b  {
            return CFloat(a)
            
            
        }
        
        return CFloat(b)
        
}
}
