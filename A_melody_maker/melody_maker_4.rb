# https://in-thread.sonic-pi.net/t/just-a-piano-music-nothing-much/7696
use_bpm 80
use_synth :tri

# Define the chords
chord1 = chord(:C3, :minor)
chord2 = chord(:A3, :minor)
chord3 = chord(:D3, :minor)
chord4 = chord(:G3, :minor)

# Define the melody notes
notes = [:C4, :B3, :A3, :G3, :F3, :E3, :D3]

# Play the chords and melody in a sad sequence
4.times do
  play_pattern_timed chord1, 1
  sleep 0.5
  play_pattern_timed notes, 0.25
  play_pattern_timed chord2, 1
  sleep 0.5
  play_pattern_timed notes.reverse, 0.25
  play_pattern_timed chord3, 1
  sleep 0.5
  play_pattern_timed notes, 0.25
  play_pattern_timed chord4, 1
  sleep 0.5
  play_pattern_timed notes.reverse, 0.25
end