class CinemaSeats
   
  def initialize 
    @seatmap = ((1..50).to_a * 100).each_slice(50).to_a
    @failed_bookings = []
  end

    attr_accessor :seatmap, :failed_bookings

  def empty_seats
    @seatmap
  end

  def book_seat row, seat
    bookit = @seatmap[row]
    bookit.collect! { |i| i == seat+1 ? "booked" : i }  
  end

  def access_data
    File.open('test_data.txt', 'r').map  do |d| 
      d.scan(/\d+/).map { |s| s.to_i}
    end
  end

  def remove_bad_booking_requests
    cleaned_data = access_data.delete_if do |d|
      d[1] != d[3] || d[4] - d[2] +1 > 5 ? @failed_bookings << d.to_s : false
    end
    cleaned_data
  end
  
  def make_bookings
    remove_bad_booking_requests.map do |data|
    request = data, row = data[1], seats = data[2]..data[4] 
    seats.select do |seat| 
      invalid_seat_request(row,seat,request)  
      book_seat(row,seat)
      end     
    end  
  end

  def invalid_seat_request row,seat,request
    seat_already_booked(row,seat) ||
    only_one_free_seat_to_left(row,seat) ||
    only_one_free_seat_to_right(row,seat)  ? @failed_bookings << request.to_s : false       
  end

  def seat_already_booked row, seat
    @seatmap[row][seat].is_a?(String) 
  end

  def only_one_free_seat_to_left row, seat
    @seatmap[row][seat - 1].is_a?(Integer) && @seatmap[row][seat - 2].is_a?(String) 
  end

  def only_one_free_seat_to_right row, seat
    @seatmap[row][seat + 1].is_a?(Integer) && @seatmap[row][seat + 2].is_a?(String)
  end

  def process_bookings
    make_bookings
    num = @failed_bookings.uniq.count
    puts "### Updated Seatmap with all confirmed bookings. ".center(110)
    puts "––––––––––––––––––––––––––––––––––––––––––––––––––".center(110)
    puts " Please note there were #{num} rejected bookings. ".center(110)
    count = 0
    @seatmap.each do |row|
      row.to_s
      puts " **ROW : #{count+1} : Seat numbers :** #{row}\n "
      count += 1
    end
  end

  def save_results_to_file
    $stdout = File.open('cinema_seats.md', 'w') 
    $stdout.sync = true
    process_bookings
  end
end

CinemaSeats.new.save_results_to_file


