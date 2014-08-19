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

  def book_seat row, seat, request
    invalid_seat_request(row,seat,request)
    bookit = @seatmap[row]
    bookit.delete_at(seat)
    bookit.insert(seat, "booked")
    @seatmap.delete_at(row)
    @seatmap.insert(row, bookit)
   
  end

  def access_data
    File.open('test_data.txt', 'r').map  do |d| 
      d.scan(/\d+/).map { |s| s.to_i}
    end
  end
  # def booking_requests
  #   access_data.select { |i| make_booking(i)}
  # end

  # def run_file
  #   booking_requests.map { |i| make_booking(i)}
  # end

  def make_booking
    access_data.map do |data|
    request = data
    row = data[1]
    seats = data[2]..data[4] 
    seats.select { |seat| book_seat(row,seat,request)}     
    end
  
  end

  def same_row
    access_data.each do |d|
     d[1] != d[3] ? @failed_bookings << d.to_s : false
    end
  end

  def less_than_six_seats
    access_data.each do |d|
      ((d[4] - d[2]) +1) > 5 ? @failed_bookings << d.to_s : false 
    end
  end

  def seat_already_booked row, seat
    @seatmap[row][seat].is_a?(String) ? true : false
  end

  def only_one_free_seat_to_left row, seat
    @seatmap[row][seat - 1].is_a?(Integer) && @seatmap[row][seat - 2].is_a?(String) ? true : false
  end

  def only_one_free_seat_to_right row, seat
    @seatmap[row][seat + 1].is_a?(Integer) && @seatmap[row][seat + 2].is_a?(String) ? true : false
  end

  def invalid_seat_request(row,seat,request)
    #access_data.each do |row,seat|
    seat_already_booked(row,seat) || only_one_free_seat_to_left(row,seat) || only_one_free_seat_to_right(row,seat)  ? @failed_bookings << request.to_s : false   
    
end

  # def filter(row,seat,request)
  #   @failed_bookings << request if invalid_seat_request(row,seat,request)
  # end

  def rejected_bookings
    @failed_bookings.uniq

  end
end

