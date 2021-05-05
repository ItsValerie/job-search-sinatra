## Technologies/ Gems used: 
 - Ruby 2.6.6.
 - Sinatra 2.0
 - Mongoid 7.0
 - Nokogiri 1.8

## Before you get started
  1. Clone this repository in your terminal using SSH
  2. Install MongoDB locally
  3. Install Ruby 2.6.6
  4. Add JSON formatter extension to make your life easier 

## Let's start 
(This is wrtitten for MacOS)


1. Install gems from your terminal command line 
>> bundle install 

2. To connect to db with mongo shell run this command in a seperate terminal tab
>> mongo 

>> use jobqueries               #db that is used

3. Boot up your server by running app.rb
>> ruby app.rb

4. Listening on localhost 4567
>> Listening on tcp://127.0.0.1:4567

5. To make a GET request to Stack Overflow's API 
>> /jobs/yourkeyword

6. To retrieve the last query to the API
>> /jobs

7. A lot of data is being processed in this application. Dropping your db might be useful. In your mongo shell run: 
>> db.dropDatabase()

8. This is still a work in process. One commit at a time. Happy for your feedback!
