Documentation
=============

This class is very useful and it is the way you can "talk" with your Zumo Robot. <br></br>

How to use
----------

- ZumoRobotManager is a singleton class, so every time you want to use it you should do it this way:
```objc
  [[ZumoRobotManager sharedZumoRobotManager] (...)];
  // (...) representing your code
```
- For getting logs from the ZumoRobotManager you should implement ZumoRobotManagerDelegate.
- ZumoRobotManager knows how to connect or disconnect from a device.
```objc
  [[ZumoRobotManager sharedZumoRobotManager] connectToDevice];
  //    OR
  [[ZumoRobotManager sharedZumoRobotManager] disconnectFromDevice];
```
- For sending a string to the robot you should use this method:
```objc
  [[ZumoRobotManager sharedZumoRobotManager] sendString:(...) avoidingRestriction:NO];
  // (...) representing the string you want to send
  // If what you want to send is very important and should be sent right away, you should have YES at avoidingRestriction
```
- For sending the velocity of the joystick to the robot, ZumoRobotManager uses a special format: spabxy, where s and p are the signs of the two velocities, a and b are the first two fractional digits of velocityX, x and y are the first two fractional digits of velocityY. For example, for velocityX = + 0.65, velocityY = - 0.11 the string sent would be: "+-6511". ZumoRobotManager knows how to convert your velocities in a string like the previous one only by calling this method:
```objc
  NSString *stringToSend = [[ZumoRobotManager sharedZumoRobotManager] stringForVelocityX:0.65f andY:-0.11f];
  // stringToSend will be @"+-6511" after this calling
```
