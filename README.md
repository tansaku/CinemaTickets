CINEMA SEATS 
============

The full challenge as received is at the bottom of this Readme file. 

Some notes on the challenge
---------------------------

I tackled this project using Ruby, in a TDD environment using RSpec. Strictly sticking to the TDD mantra of write test, see the test fail, write code to pass the test - I let the tests drive the code. 

I had some debate about the 'invalid_seat_request' method. This method calls the three helper methods to determine whether a seat request is valid or not, according to the rules in the challenge. It could have been written as one, fairly long method, and there is some similarity of code in the helper methods. I decided to keep them separate to make the 'invalid_seat_request' method very readable. It is a trade off between readability and keeping the code DRY. It may be a matter of personal taste, but this way it is clear exactly what each method does, and it keeps the methods short and punchy.

After completing the task using the test data, I have run the code using the full 'booking_requests' data file provided. The results are in the 'cinema_seats.md' file. Running this caused tests to break, but in each case it is because the test was looking for specific data from the test data, and not the 'real' booking request file. The full booking requests file resulted in 36 failed bookings. The updated seatmap is in **[cinema_seats.md]**.


The file **['cinema_seats_test_results.md']** shows the output of the test results, and the correct number of **11 rejected bookings**. I used Markdown so it was Github friendly, but in real life this could go to a text file or html etc  depending on the needs of the user. 

`````
To run the file from the command line:

In the terminal cd to the repo, and run the file using 'ruby lib/cinema_seats.rb' 
Use the rspec command to see the tests pass.
`````


###The Challenge


A cinema has a theatre of 100 rows, each with 50 seats. Customers request particular seats when making a booking.
Bookings are processed on a first-come, first-served basis. A booking is accepted as long as it is for five or fewer
seats, all seats are adjacent and on the same row, all requested seats are available, and accepting the booking would
not leave a single-seat gap (since the cinema believes nobody would book such a seat, and so loses the cinema money).

Write a system to process a text file of bookings (booking_requests) and determine the number of bookings which are
rejected. To test your system, a smaller sample file (sample_booking_requests) is supplied; processing this file should
yield 11 rejected requests.

The text file of bookings contains one booking per line, where a booking is of the following form:

  (id, index of first seat row : index of first seat within row , index of last seat row : index of last seat within row , ) ,

Rows and seats are both 0-indexed. Note the trailing comma is absent on the final line.

You should treat this as an opportunity to demonstrate your coding style.

 ['cinema_seats_test_results.md']: https://github.com/ColinFrankish/CinemaTickets/blob/master/cinema_seats_test_results.md
[cinema_seats.md]: https://github.com/ColinFrankish/CinemaTickets/blob/master/cinema_seats.md