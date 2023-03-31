# Twinkle Twinkle Little Star - Sonic Pi version
use_bpm 60

# Define the notes and durations in the same array
melody = [ [:c4, 0.5], [:c4, 0.5], [:g4, 0.5], [:g4, 0.5], [:a4, 0.5], [:a4, 0.5], [:g4, 1],
           [:f4, 0.5], [:f4, 0.5], [:e4, 0.5], [:e4, 0.5], [:d4, 0.5], [:d4, 0.5], [:c4, 1],
           [:g4, 0.5], [:g4, 0.5], [:f4, 0.5], [:f4, 0.5], [:e4, 0.5], [:e4, 0.5], [:d4, 1],
           [:g4, 0.5], [:g4, 0.5], [:f4, 0.5], [:f4, 0.5], [:e4, 0.5], [:e4, 0.5], [:d4, 1],
           [:c4, 0.5], [:c4, 0.5], [:g4, 0.5], [:g4, 0.5], [:a4, 0.5], [:a4, 0.5], [:g4, 1],
           [:f4, 0.5], [:f4, 0.5], [:e4, 0.5], [:e4, 0.5], [:d4, 0.5], [:d4, 0.5], [:c4, 1] ]

# Play the notes and durations in a loop
live_loop :twinkle_twinkle do
  melody.each do |n, d|
    play n, release: d
    sleep d
  end
end
