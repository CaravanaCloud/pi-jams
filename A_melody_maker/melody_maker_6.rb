# Für Elise - Sonic Pi version
use_bpm 60

# Define the notes
notes = [:e5, :d5, :e5, :d5, :e5, :b4, :d5, :c5,
         :a4, :rest, :c4, :e4, :a4, :b4, :rest, :e4,
         :g4, :b4, :c5, :rest, :e4, :rest, :a4, :rest,
         :b4, :rest, :e4, :rest, :e5, :d5, :e5, :d5,
         :e5, :b4, :d5, :c5, :a4, :rest, :c4, :e4, :a4,
         :b4, :rest, :e4, :g4, :b4, :c5, :rest, :e4, :rest,
         :a4, :rest, :b4, :rest, :e4]

# Play the notes and sleep for 0.25s between each note
live_loop :fur_elise do
  notes.each do |n|
    play n
    sleep 0.25
  end
end
