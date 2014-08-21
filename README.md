`````
##  CINEMA SEATS TEST
`````
The full challenge as received is at the bottom of this Readme file. 

I tackled this project using pure Ruby code, in a TDD environment using RSpec. Strictly sticking to the TDD mantra of write test, fail test, write code, pass test I endeavoured to let the tests drive the code. 


In Github the program has been run, creating the file 'cinema_seats.md' so the resulting output can be seen. I used Markdown so it was Github freindly, but in real life this could go to a text file or html etc  depending on the needs of the user. 

`````
How to run the file.

In the terminal cd to the repo, and run the file using 'ruby lib/cinema_seats.rb' 
`````

``````
###The Challenge
``````

A cinema has a theatre of 100 rows, each with 50 seats. Customers request particular seats when making a booking.
Bookings are processed on a first-come, first-served basis. A booking is accepted as long as it is for five or fewer
seats, all seats are adjacent and on the same row, all requested seats are available, and accepting the booking would
not leave a single-seat gap (since the cinema believes nobody would book such a seat, and so loses the cinema money).

Write a system to process a text file of bookings (booking_requests) and determine the number of bookings which are
rejected. To test your system, a smaller sample file (sample_booking_requests) is supplied; processing this file should
yield 11 rejected requests.

The text file of bookings contains one booking per line, where a booking is of the following form:
  (<id>,<index of first seat row>:<index of first seat within row>,<index of last seat row>:<index of last seat within row>),
Rows and seats are both 0-indexed. Note the trailing comma is absent on the final line.

You should treat this as an opportunity to demonstrate your coding style. Solutions should ideally be written in Java
or C#, but solutions in Ruby, JavaScript and Scala are also acceptable. Please discuss with Softwire before using any
other language.

Send the output of your program and the code to gareth@softwire.com.
