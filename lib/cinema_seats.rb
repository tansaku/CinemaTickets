class CinemaSeats
   
  def initialize 
    @seatmap = ((1..50).to_a * 100).each_slice(50).to_a
    @failed_bookings = []
  end

    attr_accessor :seatmap, :failed_bookings

  def all_seats
    @seatmap
  end

  def seat_request row, seat
    @seatmap[row][seat]
  end

  def book_seat row, seat
    bookit = @seatmap[row]
    bookit.delete_at(seat)
    bookit.insert(seat, "booked")
    @seatmap.delete_at(row)
    @seatmap.insert(row, bookit)
  end

  def access_data
    File.open('test_data.txt', 'r').map do |d| 
      d.scan(/\d+/).map { |s| s.to_i}
    end
  end

  def booking_requests
    access_data.map { |rq|  rq.values_at(1,2,4)}#values_at(1,2,4) #if valid_booking?
  end

  def make_booking(data=booking_requests)
    row = data[0]
    seats = data[1]..data[2]
    seats.each { |seat| book_seat(row,seat)}
  end

  def same_row
    access_data.each do |d|
     d[1] != d[3] ? @failed_bookings << d : true
    end
  end

  def less_than_six_seats
    access_data.each do |d|
      (d[4] - d[2] +1) > 5 ? @failed_bookings << d : true 
    end
  end

  def check_seat_not_booked row, seat
    @seatmap[row][seat].is_a?(String) ? false : true
  end

  def two_free_seats_to_left row, seat
    @seatmap[row][seat - 1].is_a?(Integer) && @seatmap[row][seat - 2].is_a?(String) ? false : true
  end


end
