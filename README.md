ZumoRobotController
===================

ZumoRobotController is an iOS application for controlling a Zumo Robot build with a [Zumo Robot Kit](http://www.pololu.com/product/2505) from Pololu and a [FRDM-KL25Z](http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=FRDM-KL25Z) from Freescale. As a bluetooth module, a [HM-10](http://imall.iteadstudio.com/im130614001.html) has been used. For motors, I have chosen [150:1 Micro Metal Gearmotor](http://www.pololu.com/product/1097).

mbed code
---------
For programming the FRDM-KL25Z [mbed](https://mbed.org) seemed the best solution. You can find the code running on microcontroller [here](http://developer.mbed.org/users/catalincraciun7/code/ZumoRobotBluetoothControlled/) and also some helping libraries which I wrote for the Zumo Robot [here](http://developer.mbed.org/users/catalincraciun7/code/ZumoRobotUtilities/).

Features:
---------
- Joystick for precise control
- Connection secured with password
- Connect/Disconnect buttons
- Log console in iOS app (with Clear button)
- 3 buttons for changing the colour of an RGB Led on microcontroller
- Buzzer control for playing simple sounds

Screenshots:
------------
<img alt="App Screenshot 1" src="https://raw.githubusercontent.com/catalincraciun/ZumoRobotController/master/Photos/appScreenshot1.png" width="210">
&nbsp;&nbsp;
<img alt="App Screenshot 2" src="https://raw.githubusercontent.com/catalincraciun/ZumoRobotController/master/Photos/appScreenshot2.png" width="210">
&nbsp;&nbsp;
<img alt="App Screenshot 3" src="https://raw.githubusercontent.com/catalincraciun/ZumoRobotController/master/Photos/appScreenshot3.png" width="210">
<img alt="Robot" src="https://raw.githubusercontent.com/catalincraciun/ZumoRobotController/master/Photos/robot.png" width="667">

<br></br>
Catalin Craciun
---------------
