This is the online platform for team formation. 

To access the website, you need do the following steps:

1. make sure you have downloaded ruby and rails and convert the default database SQLite3 to Postgre SQL

2. after using the git clone command to copy the test1 file to your local computer, you enter the file in terminal(if you use Mac)/Command Line(if you use Windows)

3. run $ bundle install to install missing gems

4. run $ rake db:migrate and $ rake db:seed to set up things in database

5. run $rails server and then visit http://localhost:3000 on safari/chrome (chrome is recommended)

There is only one preset account(set in db/seeds) for administrator:
email: Admin@email.com
password: Admin1

You can use this account to log in and access pages which are only open to administator.

You can sign up as many user accounts as you like 

