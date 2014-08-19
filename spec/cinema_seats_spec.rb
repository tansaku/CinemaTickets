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
    cinemaseats.book_seat(0,2,[])
    expect(cinemaseats.seatmap[0][2]).to eq("booked")
    cinemaseats.book_seat(5,60,[])
    expect(cinemaseats.seatmap[5][60]).to eq("booked")
  end

  it 'should extract all 5 data elements from the booking request file' do 
    expect(cinemaseats.access_data).to include([0,89,13,89,13])
  end

  it 'should be able to make a booking of one to five seats' do 
    cinemaseats.make_booking
    expect(cinemaseats.seatmap[89][13]).to eq("booked")
    expect(cinemaseats.seatmap[32][22]).to eq("booked")
    expect(cinemaseats.seatmap[32][23]).to eq("booked")
    expect(cinemaseats.seatmap[32][24]).to eq("booked")
  end

  it 'should not accept bookings with row requests on different rows' do 
    cinemaseats.same_row
    expect(cinemaseats.failed_bookings.length).to eq(5)
  end

  it 'should reject booking requests for more than five seats' do 
    cinemaseats.less_than_six_seats
    expect(cinemaseats.failed_bookings.length).to eq(4)
  end

  it 'should know if a seat is already booked' do 
    cinemaseats.book_seat(0,2,[])
    expect(cinemaseats.seat_already_booked(0,2)).to eq(true)
    expect(cinemaseats.seat_already_booked(0,3)).to eq(false)
  end

  it 'should know if only one free seat to the left' do 
    cinemaseats.book_seat(0,2,[1,0,2,0,4])
    cinemaseats.book_seat(0,4,[1,0,2,0,4])
    expect(cinemaseats.only_one_free_seat_to_left(0,4)).to eq(true)
  end
  it 'should know if only one free seat to the right' do 
    cinemaseats.book_seat(0,4,[1,0,2,0,4])
    cinemaseats.book_seat(0,2,[1,0,2,0,4])
    expect(cinemaseats.only_one_free_seat_to_right(0,2)).to eq(true)
  end

  it 'should know if a seat request is invalid' do 
    cinemaseats.book_seat(0,2,[1,0,2,0,4])
    expect(cinemaseats.failed_bookings.count).to eq(0)
    expect(cinemaseats.invalid_seat_request(0,4,[1,0,2,0,4])).to include("[1, 0, 2, 0, 4]")
    expect(cinemaseats.failed_bookings.count).to eq(10)
    expect(cinemaseats.invalid_seat_request(0,5,[1,0,2,0,5])).to eq(false)
  end

  it 'should count the number of failed bookings' do 
    cinemaseats.less_than_six_seats
    cinemaseats.same_row
    cinemaseats.make_booking
    expect(cinemaseats.rejected_bookings).to eq(11)
  end

  it 'should output an updated seatmap' do 

    cinemaseats.less_than_six_seats
    cinemaseats.same_row
    cinemaseats.make_booking 
    expect(cinemaseats.show_bookings).to include([1,2,3,4,5,"booked","booked",8])

  end
end