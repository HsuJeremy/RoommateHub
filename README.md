# RoommateHub

**Authors**: Jeremy Hsu and Geena Kim

RoommateHub is an iOS app designed to improve the shared living experience by
enabling roommates to coordinate tasks, learn more about each other, and send
each other direct messages.

<div align="center">
  <img
    src="Images/Login.PNG"
    title="Login"
    alt="Login Page"
    height="536"
    width="250"
  />
  <img
    src="Images/Home.PNG"
    title="Home"
    alt="Home"
    height="536"
    width="250"
  />
  <img
    src="Images/GeenaRoommateProfile.PNG"
    title="Geena's Profile"
    alt="Geena's Profile"
    height="536"
    width="250"
  />
</div>

**Note**: This project was originally written as our CS 50 project in Fall 2019.
The `README.md` and `DESIGN.md` files written as part of the original course
project write-up can be found in the `Documentation` folder.

## Architecture Overview

RoommateHub is written in Swift and UIKit and uses the 
[Firebase Realtime Database](https://firebase.google.com/docs/database) as the
primary data store, [Firebase Authentication](https://firebase.google.com/docs/auth)
for user login and creation,  and 
[MessageUI](https://developer.apple.com/documentation/messageui) to embed 
iMessage into the app. The high-level architecture of RoommateHub is as follows:

<div align="center">
<img
  src="Images/full-architecture.png"
  title="Full Architecture"
  alt="Full Architecture"
  height="400"
/>
</div>

## Full Walkthrough

When you open the app, you are greeted with the login page. If you do not have
an account, you can create one.

<div align="center">
<img
  src="Images/Login.PNG"
  title="Login"
  alt="Login Page"
  height="536"
  width="250"
/>
<img
  src="Images/CreateAccount.PNG"
  title="Create Account"
  alt="Create Account Page"
  height="536"
  width="250"
/>
</div>

Once you sign in, you arrive at the home page.

<div align="center">
<img
  src="Images/Home.PNG"
  title="Home"
  alt="Home"
  height="536"
  width="250"
/>
</div>

Upon creating their account, each user gets their own roommate profile. They
can view the profiles of their other roommates in addition to their own.

<div align="center">
<img
  src="Images/RoommateList.PNG"
  title="Roommate List"
  alt="Roommate List View"
  height="536"
  width="250"
/>
<img
  src="Images/GeenaRoommateProfile.PNG"
  title="Geena's Profile"
  alt="Geena's Profile"
  height="536"
  width="250"
/>
<img
  src="Images/JeremyRoommateProfile.PNG"
  title="Jeremy's Profile"
  alt="Jeremy's Profile"
  height="536"
  width="250"
/>
</div>

You can also send an SMS or iMessage to a roommate right from their profile page,
assuming they provided their phone number.

<div align="center">
<img
  src="Images/SendTextMessage.PNG"
  title="Text Message"
  alt="Text Message"
  height="536"
  width="250"
/>
</div>

You can also post to an anonymous message board, or set tasks that anyone in the
room can accomplish.

<div align="center">
<img
  src="Images/CreateMessage.PNG"
  title="Create Anonymous Message"
  alt="Create Anonymous Message"
  height="536"
  width="250"
/>
</div>
