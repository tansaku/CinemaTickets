require 'cinema_seats'

describe 'CinemaSeats'  do
      let(:cinemaseats) {CinemaSeats.new}

  it 'should be able to show an array of numbered seats' do
    expect(cinemaseats.empty_seats).to include(1..50)
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

  it "should remove bad requests from the booking requests" do 
    expect(cinemaseats.remove_bad_booking_requests).not_to include([32, 2, 11, 3, 21])
    expect(cinemaseats.remove_bad_booking_requests).to include([0,89,13,89,13])
  end

  it 'should be able to make a booking of one to five seats' do 
    cinemaseats.make_bookings
    expect(cinemaseats.seatmap[89][13]).to eq("booked")
    expect(cinemaseats.seatmap[32][22]).to eq("booked")
    expect(cinemaseats.seatmap[32][23]).to eq("booked")
    expect(cinemaseats.seatmap[32][24]).to eq("booked")
  end

  it 'should add invalid bookings on different rows to the failed bookings array' do 
    cinemaseats.same_row
    expect(cinemaseats.failed_bookings.length).to eq(5)
  end

  it 'should add invalid requests for more than five seats to the failed bookings array' do 
    cinemaseats.less_than_six_seats
    expect(cinemaseats.failed_bookings.length).to eq(4)
  end

  it 'should know if a seat is already booked' do 
    cinemaseats.book_seat(0,2)
    expect(cinemaseats.seat_already_booked(0,2)).to eq(true)
    expect(cinemaseats.seat_already_booked(0,3)).to eq(false)
  end

  it 'should know if only one free seat to the left' do 
    cinemaseats.book_seat(0,2)
    cinemaseats.book_seat(0,4)
    expect(cinemaseats.only_one_free_seat_to_left(0,4)).to eq(true)
  end
  it 'should know if only one free seat to the right' do 
    cinemaseats.book_seat(0,4)
    cinemaseats.book_seat(0,2)
    expect(cinemaseats.only_one_free_seat_to_right(0,2)).to eq(true)
  end

  it 'should know if a seat request is invalid' do 
    cinemaseats.book_seat(0,2)
    #expect(cinemaseats.failed_bookings.count).to eq(0)
    expect(cinemaseats.invalid_seat_request(0,4,[1,0,2,0,4])).to include("[1, 0, 2, 0, 4]")
    #expect(cinemaseats.failed_bookings.count).to eq(10)
    expect(cinemaseats.invalid_seat_request(0,5,[1,0,2,0,5])).to eq(false)
  end

  it 'should count the number of failed bookings' do 
    cinemaseats.make_bookings
    expect(cinemaseats.rejected_bookings).to eq(11)
  end

  it 'should output an updated seatmap' do 
    cinemaseats.make_bookings
    expect(cinemaseats.show_bookings).to include([1, 2, "booked", "booked", 5, 6, 7, 8, 9, 
                                                 10, "booked", "booked", 13, 14, "booked", "booked", "booked", "booked", 19, 
                                                 20, 21, 22, 23, 24, "booked", "booked", "booked", "booked", 29, 
                                                 30, 31, "booked", "booked", "booked", 35, 36, 37, 38, 39, 
                                                 40, 41, 42, 43, "booked", 45, 46, 47, 48, 49, 50])
  end
end