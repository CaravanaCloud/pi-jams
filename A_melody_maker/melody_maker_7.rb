# Happy Birthday to You - Sonic Pi version
use_bpm 120

# Define the notes
notes = [ :c4, :c4, :d4, :c4, :f4, :e4,
          :c4, :c4, :d4, :c4, :g4, :f4,
          :c4, :c4, :c5, :a4, :f4, :e4, :d4,
          :a4, :a4, :a4, :f4, :g4, :f4 ]

# Define the durations
durations = [ 0.5, 0.5, 1, 1, 1, 2,
              0.5, 0.5, 1, 1, 1, 2,
              0.5, 0.5, 1, 1, 1, 0.5, 0.5,
              1, 1, 1, 1, 1, 2 ]

# Play the notes and durations in a loop
live_loop :happy_birthday do
  notes.zip(durations).each do |n, d|
    play n, release: d
    sleep d
  end
end