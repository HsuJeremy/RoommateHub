# RoommateHub

**Authors**: Jeremy Hsu and Geena Kim

RoommateHub is an iOS app designed to improve the shared living experience by
enabling roommates to coordinate tasks, learn more about each other, and send
each other direct messages.

**Note**: This project was originally written as our CS 50 project in Fall 2019.
The `README.md` and `DESIGN.md` files written as part of the original course
project write-up can be found in the `Documentation` folder.

## Walkthrough

When you open the app, you are greeted with the login page. If you do not have
an account, you can create one.

<img
  src="Images/Login.PNG"
  title="Login"
  alt="Login Page"
  height="611"
  width="285"
/>
<img
  src="Images/CreateAccount.PNG"
  title="Create Account"
  alt="Create Account Page"
  height="611"
  width="285"
/>

Once you sign in, you arrive at the home page.

<img
  src="Images/Home.PNG"
  title="Home"
  alt="Home"
  height="611"
  width="285"
/>

Upon creating their account, each user gets their own roommate profile. They
can view the profiles of their other roommates in addition to their own.

<img
  src="Images/RoommateList.PNG"
  title="Roommate List"
  alt="Roommate List View"
  height="611"
  width="285"
/>
<img
  src="Images/GeenaRoommateProfile.PNG"
  title="Geena's Profile"
  alt="Geena's Profile"
  height="611"
  width="285"
/>
<img
  src="Images/JeremyRoommateProfile.PNG"
  title="Jeremy's Profile"
  alt="Jeremy's Profile"
  height="611"
  width="285"
/>

You can also send an SMS or iMessage to a roommate right from their profile page,
assuming they provided their phone number.

<img
  src="Images/SendTextMessage.PNG"
  title="Text Message"
  alt="Text Message"
  height="611"
  width="285"
/>

You can also post to an anonymous message board, or set tasks that anyone in the
room can accomplish.

<img
  src="Images/CreateMessage.PNG"
  title="Create Anonymous Message"
  alt="Create Anonymous Message"
  height="611"
  width="285"
/>

## Tech Stack
- Swift and UIKit
- Firebase for authentication and data storage
- MessageUI to send direct messages through iMessage
