# Major Scale IV

delay = 1
intervals = [0, 2, 4, 5, 7, 9, 11, 12]
note = :C

intervals.each do |i|
  play note + i
  sleep delay
end