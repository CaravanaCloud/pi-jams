# Major Scale VI - Synths and Synth Options

delay = 1
# delay = 2
intervals = [0, 2, 4, 5, 7, 9, 11, 12]
note = :C
# note = :A

use_synth :prophet

live_loop :myloop do
  intervals.each_with_index do |interval, index|
    puts "#{index} - #{interval}"
    play note + interval,
      amp: 0.2 + 0.1 * index,
      pan: -1 + index % 3
    sleep delay
  end
end