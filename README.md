# RoommateHub: iOS App
Jeremy Hsu & Geena Kim

CS50 Final Project 

December 8, 2019

## How to use RoommateHub

### Compile
To compile the application, clone into this repo and open RoommateHub.xcworkspace (white file) and click the play button 
slight left of thecenter of the top bar. You may either choose to run it on a simulator or install it on your iPhone. If 
installing on youriPhone for the first time, you will need to verify RoommateHub (Settings > General  > Profiles & Device 
Management)locally. If using the simulator, know that the constraints were optimized for the iPhone 11 Pro, iPhone 11, and 
iPhone11 Max. 

### Login and Sign Up
The app will initially render the login page, where existing users can sign in. New users can click into the signup page,
where they will need to enter their information. Make sure to click outside of the textfields to get the keyboard to
disappear and allow access to the textfields lower on the screen. Also note that passwords must be at least 6 characters in length and that both a first and last name must be provided. Upon a successful user registration, the Create User button will
disappear. From there, return to the login page and enter your new credentials to sign into RoommateHub. 

Immediately, you will be directed to the home page, with your name and room number displayed front and center. The
home page will render 3 buttons: Roommates, Task List, and Message Board. 

### Roommates Page
Tapping into Roommates will direct you to a list of all the other roommates who registered under the same room.
Clicking into each one will allow you to view their profiles. Additionally, you can send them an iMessage or SMS
message from within the app, though this does not work on the computer simulator since it does not have caller ID. 

### Task List Page
Tapping into Task List will take you to a Task List page that has a to do list that all of you and your roommates have access
to. To create a new task, you can click the plus button in the upper right hand corner. This will take you to a new page where
you may write the task that you want to add onto the list. Additionally, you may choose to mark the task as important by 
tapping on the switch. Once you are satisfied with your entries, you can press the "Add" to push the new task to the to do 
page. To complete a task, you can tap the text the cells on the Task list. That will bring you to a page specifically for the
task you tapped on. If you have completed the task, you can tap on the "Complete" button. This will cause the button to 
disappear. Press the back button at the top left corner to be brought back to the task list. For the change to be seen, you 
must go back to the homepage (one more back button) and upon re-entering the task list page, you will see that the completed 
tasks have been moved to the Completed Task List page which can be accessed from the task list page by pressing the "Completed 
Items" in the navigation bar.

### Anonymous Message Board Page
Tapping into Message Board will display a list of anonymous messages. If you click the compose button on the top
right, you will be prompted to enter something yourself. Feel free to exit out and cancel your post by pressing the back
button on the top left. Contrarily, pressing the Submit Message button right below the text field will publish the
message to the board. However, messages are not editable afterwards so make sure you are satisfied with what you
write before submitting. The timestamps are recorded on each page. 

And as always, you can log out in the home page by pressing the Log Out button on the top right. 
