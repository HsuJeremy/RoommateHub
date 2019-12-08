# Design Documentation 

## Storyboard Layout
We sought out to make RoommateHub as applicable and relevant to students in the real world as possible and therefore took a lot of feedback from fellow classmates as well as other iOS apps which we really enjoyed. Upon loading the app, users are greeted with a login page prompting them to enter their email, password, and room credentials. We stored all our data in the Firebase Realtime Database, which essentially serves as a master JSON file. By sorting items by room credentials, we were able to narrow the scope of children in the database to only include those which pertained to the users’ specific room. First-time users have the option to create their user account before logging in again. 

Once past the login page, users are greeted by a simple yet eye-catching home page. The central banner displays the user’s name and room and 3 buttons lie below: Roommates, Task List, and Messages. 
Selecting the Roommates button directs users to a UITableView of all the other user profiles which have signed up in the same room. Users can click into any listed roommate profile. There, they can see primary information about the selected person (first name, last name, concentration, hometown, etc.) and also have the option to send them an iMessage or SMS right from the app. 

Selecting the Task List button directs users to a …

Finally, selecting the Message button directs the user to another UITableView with options to click into anonymous messages. Users will have the option to submit an anonymous message themselves, but are not allowed to edit them afterwards. As college students with multiple roommates, we thought that having an anonymous message board would be a pretty useful feature that our users would really enjoy.
Users have the option of logging out in the home page.

## Designing the UI/UX 
When it came to design, we wanted RoommateHub to be modern and simplistic but also fun at the same time. Our primary colors of Indigo, White, and Black give the app a clean user interface, but adding emojis to various pages injects small bursts of colors which keep users engaged. 
Overall, RoommateHub is an app that we would certainly find useful as college students and our hope is that our fellow classmates feel the same way. 