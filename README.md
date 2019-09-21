# spaceship_flight_stick

Proto Builds - Flight Stick

Created for SBUHacks 2019.

Using an Arduino Leonardo for joystick and button controls. We made a makeshift flight stick and game to use it on!

Hardware: Arduino Leonardo, joystick, push button

Software: Godot, Arduino

Check out our website, protobuilds.tech for more information and how to build it yourself!

Also check out our devpost for this project: https://devpost.com/software/spaceship_flight_stick_game#updates

# Tutorial

## Software Setup
### Arduino IDE
Download the Arduino IDE
You can download it here: https://www.arduino.cc/en/main/software
If you don't want to download it you can also use their online compiler, though downloading it is recommended. Don't forget to get the correct version 

### Godot
Download the Godot Software
You can download it here: https://godotengine.org/download/
You can also read more information about it here: https://docs.godotengine.org/en/3.1/

I chose Godot to use because of its easy compatibility with reading and assigning inputs from keys or controllers. It is straightforward to use much more lightweight than other game engines such as Unity. We aren't making a graphical heavy game.
Godot is rising in popularity and I found out about it recently by  watching Youtube videos of game developers describing Godot's usefulness and why they switched over.

Feel free to check those videos out here:
https://www.youtube.com/watch?v=U3TI2lleCYU
https://www.youtube.com/watch?v=FEiNBVVCq_A
https://www.youtube.com/watch?v=s0I4Xcr5MVw

## Creating the Flight Stick
### Box
The box is used to create a flat platform to put your joystick on that is easy to hold.
Cut it your cardboard box into a cube that fits nicely in your palm. I find that around 7cm per edge of the cube is a nice size.
Feel free to use other materials and experiment with different box sizes to see what you like the best! 

### Stick
We are making a flight stick, so make sure this fits nicely in your grip.
I personally used a small M&M canister and fit it on top of the joystick. To help it fit snugly, I took some bubble wrap packaging to stuff around the circumference of the canister.
You could try 3D printing your own stick or use more cardboard and roll it up into a cylinder. Just make sure you can also put the button on top of the cylinder!

## Set Up the Arduino
### Download the Arduino Code
I've written the Arduino code for this project.
Download it here: https://github.com/Cynthia-Lee/arduino_joystick_with_button

### Arduino Leonardo
Check if your computer can read in your Arduino Leonardo
Plug in your Leonardo to your computer with a USB to micro USB adapter.
Go to or press the Windows home button. Search "Set up USB game controllers". Check that your Arduino Leonardo is listed in the window.

### Wire Up the Arduino
Prepare your jumper wires. If they are too short, connect a male and female jumper wire.
The joystick's axis is mapped to pin A0 (x-axis) and pin A1 (y-axis) by default. I did not map the joystick's button because I didn't need it. Ground is pinned to the Leonardo's ground.
Connect the Leonardo's 5v to positive on the breadboard. (Since we have the both joystick and the button, we need a jumper wire to have the positive available)
The button is mapped to pin 9. Have a jumper wire for the positive to the breadboard. Have a jumper wire for ground to the Leonardo.

## Make the Arduino Leonardo read as an Xbox Controller
The reason I want it to read as an Xbox controller is because Godot only supports main brand controllers. It doesn't support a normal USB controller, which is the default of what Arduino Leonardo is read as.
Godot supports the following controllers: PS, Nintendo, Xbox
If you don't want it to be read as an Xbox controller, you can also make it either a PS or Nintendo one. You can skip this step if you want to have your Leonardo read as those. 
I've chosen Xbox as it seemed like the easiest option. 

There are a lot of different software options you could use to have a Arduino Leonardo read as an Xbox controller. Also, there is software that can do that to an Arduino Uno, Mega, etc. I've chosen to use x360ce, as it doesn't modify my Leonardo's chip, so I don't have to worry about switching, booting or bricking my Arduino.

### Why Not Unojoy?
The other program that I've looked at is Unojoy. I decided not to use it because I had difficulty setting it up. When I first started this project, I thought about using an Arduino Uno with Unojoy to read as a controller. However, I could not get my Uno to boot into DFU mode. My Uno had the correct Amtel Mega 16U2 and Amtel AT Mega 328P and was readable on my computer as an Arduino Uno. When I tried to boot it into DFU mode (by short circuiting the two pins near the USB connector), it would reboot and read as an Arduino Uno again. I did not have another Arduino Uno to reformat this one, so I decided to use an Arduino Leonardo.
Even with an Arduino Leonardo, I decided not to use Unojoy again. Personally, I think the Unojoy documentation is not really clear and is dated. I still could not make it work. Moving around files, the Arduino IDE could not list Unojoy as a board correctly.

### Xbox Compatible Controller, x360ce
Download it and read about it here: https://github.com/x360ce/x360ce
The GitHub link also has helpful documentation and solved issues.
Follow the instructions and download either the 32 bit or 64 bit, according to what your game is (if your game is 32 or 64 bit as well). 
Also download, "DInput.dll Plugin (required for some games)"
Also, name your "xinput" file to "xinput1_4.dll" as it seems that Godot is read as a Windows 8 / metro app

Open x360ce. Go the Leonardo tab, save and exit the program. Reopen the program.

Now let's map our Leonardo controls to the Xbox controller.
To map the joystick controls, click the drop down and click "record". Then move the joystick in the corresponding axis. Also record the button and press it.

Instructions can be seen here in a Youtube video: https://youtu.be/GrO8ZmxbOyI?t=561

### Test if Godot can Read the Xbox Controller
Open Godot.
Download the tutorial project, "Joystick".
Edit the project. Go to "Project Settings" > "Export" > "Add" > "Windows Universal" 
If you check off 64, it will be a 64 bit game. If it is unchecked, it will be a 32 bit game.
Make sure to have the x360ce 32 or 64 bit match this Joystick's 32 or 64 bit.

Take your x360ce files. Move it to the same directory (folder) as the executable (exe) Joystick file you just made. Run the exe, and test out your controller! Your controller should be read as an XInput. This is indicated on top in green text. When you move the joystick and button, it should be shown highlighted on the controller diagram in green.

You can now make any Arduino Leonardo controller. You just need to edit the Arduino code, map the x360ce buttons, and then move the x360ce files to the same directory as the game's exe file. If it isn't read, just change the xinput file name, as mentioned in the GitHub x360ce read me.

## Godot Game
Time to test our flight stick controller and code the Godot game!
The game I used to test out my flight stick controller is Gingerageous Game's Godot StarFox 64 Tutorial, link here: 
https://www.youtube.com/playlist?list=PLGyWVeC9tYcAyZbd7vyO_ivY2-YoEPRsJ

Follow the instructions, except change the following:
As you can see, in the tutorial, the player ship script controls take in an "up", "left", "bottom", "right" input. It is mapped to W A S D. 
Go to "Project Settings" > "Input Map" 
Add "up" and map the controller's input, "Axis 1, -" and "W"
Add  "down" and map the controller's input, "Axis 1, +" and "S"
Add  "left" and map the controller's input, "Axis 0, -" and "A"
Add  "right" and map the controller's input, "Axis 0, +" and "D"
Add "shoot" and map the controller's input, "0: PS Cross, XBox A, Nintendo B" and "space"
