Documentation
=============

The "ccJoystick" class is the perfect joystick for controlling your Zumo Robot. The joystick is described by two properties: velocityX and velocityY, which take float values from -1 to 1. In other words, velocityX and velocityY represent the position of the thumb in a cartesian coordinate system. 
<br></br><br></br>
As a child of UIView, it has been built for using it from a storyboard. For correct use of ccJoystick you should implement ccJoystickDelegate to receive its velocityX and velocityY.
