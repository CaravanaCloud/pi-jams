# Major Scale VII - Duration with Envelopes

delay = 1
intervals = [0, 2, 4, 5, 7, 9, 11, 12]
note = :C
use_synth :pulse

live_loop :myloop do
  intervals.each_with_index do |interval, index|
    puts "#{index} - #{interval}"
    
    play note + interval,
      attack: 0.2,
      sustain: 0.6,
      release: 0.2
    
    sleep delay
  end
end