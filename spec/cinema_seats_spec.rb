require 'cinema_seats'

describe 'CinemaSeats'  do
      let(:cinemaseats) {CinemaSeats.new}

  it 'should be able to show an array of numbered seats' do
    expect(cinemaseats.all_seats).to include(1..50)
  end

  it 'should have a total of 50 * 100 seats' do 
    expect(cinemaseats.seatmap.flatten.count).to eq(5000)
  end

  it 'should know which seat is being requested ' do 
    expect(cinemaseats.seat_request(0,2)).to eq(3)
    expect(cinemaseats.seat_request(3,20)).to eq(21)
  end

  it 'should book a seat by row and seat index' do
    cinemaseats.book_seat(0,2)
    expect(cinemaseats.seatmap[0][2]).to eq("booked")
    cinemaseats.book_seat(5,60)
    expect(cinemaseats.seatmap[5][60]).to eq("booked")
  end

  it 'should extract all 5 data elements from the booking request file' do 
    expect(cinemaseats.access_data).to include([0,89,13,89,13])
  end
  
  it 'should extract booking requests from the request data file' do 
    expect(cinemaseats.booking_requests).to include([16, 37, 37])
    expect(cinemaseats.booking_requests).to include([89,13, 13])
    expect(cinemaseats.booking_requests).to include([76,35, 37])
    expect(cinemaseats.booking_requests[0]).to eq([89,13,13])
    expect(cinemaseats.booking_requests[15]).to eq([91,26,27])
  end

  it 'should be able to make a booking of one to five seats' do 
    cinemaseats.make_booking([89,13,13])
    expect(cinemaseats.seatmap[89][13]).to eq("booked")
    cinemaseats.make_booking([20,20,24])
    expect(cinemaseats.seatmap[20][20]).to eq("booked")
    expect(cinemaseats.seatmap[20][24]).to eq("booked")
  end
  it 'should not accept bookings with row requests on different rows' do 
    cinemaseats.same_row
    expect(cinemaseats.failed_bookings.length).to be(5)
  end

  it 'should reject booking requests for more than five seats' do 
    cinemaseats.less_than_six_seats
    expect(cinemaseats.failed_bookings.count).to be(4)
  end

  it 'should reject a booking if a seat is already booked' do 
    cinemaseats.book_seat(0,2)
    expect(cinemaseats.check_seat_not_booked(0,2)).to eq(false)

  end
end