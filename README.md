## A&M Chess Camps ##

Welcome to A&M Chess Camps, a web application created for CMU's 67-272 Application Design and Development. Students learn about MVC and practice good design by creating a website using Ruby on Rails for the business A&M Chess Camps, a made-up organization featuring the professor's children Alex and Mark.

To set this up, clone this repository, run the `bundle install` command to ensure you have all the needed gems and then create the database with `rake db:migrate`.  If you want to populate the system with fictitious, but somewhat realistic data (similar to the data given in the spreadsheets in phase 1), you can run the `rake db:populate` command.  The populate script will create a series of curriculums, instructors and over 35 camps

Many objects are created with some element of randomness so you will get slightly different results each time it is run.  However, instructors and users are fixed.  If there were any users in this phase, all the users in the system have a password of 'secret'.  In terms of users there are two admins (Alex and Mark) and five instructor-level users (our five Head TAs: Becca, Rick, Jordan, Connor, and Sarah).  The email for each will be their first name in all lowercase + "@razingrooks.org".

This project caters to three users: guest, parent, and admin. Upon running rails server, you can expect some pages like the site below.

### Guest ###
Guests only have access to the home page, camps index and show, and curriculums index and show. They have the option of logging in or creating an account to access the site.

Guest Homepage
![alt text](https://raw.githubusercontent.com/judyzhang25/A-M-Chess-Camps/master/app/assets/images/guest_homepage.png?raw=true "Guest Homepage")

Guest Login
![alt text](https://raw.githubusercontent.com/judyzhang25/A-M-Chess-Camps/master/app/assets/images/login.png?raw=true "Guest Login")

Camp Index
![alt text](https://raw.githubusercontent.com/judyzhang25/A-M-Chess-Camps/master/app/assets/images/active_camps.png?raw=true "Camp Index")

### Parent ###
Parents have customized home pages and dashboards. Their dashboards allow them to see upcoming camps in either a list or calendar format. They can see their own accounts and create students. They have the ability to register their students for camps and checkout their carts. They can also edit their own students and see their updated students.

Parent Homepage
![alt text](https://raw.githubusercontent.com/judyzhang25/A-M-Chess-Camps/master/app/assets/images/parent_homepage.png?raw=true "Parent Homepage")

Parent Camp Show
![alt text](https://raw.githubusercontent.com/judyzhang25/A-M-Chess-Camps/master/app/assets/images/camp_show2.png?raw=true "Parent Camp Show")

Parent Checkout
![alt text](https://raw.githubusercontent.com/judyzhang25/A-M-Chess-Camps/master/app/assets/images/checkout.png?raw=true "Parent Checkout")

Parent Dash- Calendar
![alt text](https://raw.githubusercontent.com/judyzhang25/A-M-Chess-Camps/master/app/assets/images/agenda_calendar.png?raw=true "Parent Dash- Calendar")

Parent Dash- Upcoming
![alt text](https://raw.githubusercontent.com/judyzhang25/A-M-Chess-Camps/master/app/assets/images/agenda_upcoming.png?raw=true "Parent Dash- Upcoming")

Parent Dash- Account
![alt text](https://raw.githubusercontent.com/judyzhang25/A-M-Chess-Camps/master/app/assets/images/agenda_manage.png?raw=true "Parent Dash- Account")

### Admin ###
Admins can do everything except for register students. They have an additional feature to their dashboard allowing them to see statistics regarding the business including registrations per curriculum/instructor/location/week, best/worst customers (limited to 12), total revenue, number of families, and number of upcoming/past registrations.

Admin Dash- Statistics
![alt text](https://raw.githubusercontent.com/judyzhang25/A-M-Chess-Camps/master/app/assets/images/agenda_stats.png?raw=true "Admin Dash- Statistics")

Instructions for what needed to be done in this phase of the project can be found in the project write-ups found on the [67-272 course site](http://67272.cmuis.net/projects/). Please leave any questions below. Thank you and enjoy the site!



