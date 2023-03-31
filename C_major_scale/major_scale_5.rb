# Major Scale V - Loops

delay = 1
# delay = 2
intervals = [0, 2, 4, 5, 7, 9, 11, 12]
note = :C
# note = :A

loop do
  intervals.each do |i|
    play note + i
    sleep delay
  end
end
