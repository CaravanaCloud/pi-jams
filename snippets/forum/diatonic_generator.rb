# https://in-thread.sonic-pi.net/t/unlimited-chord-progression-a-4-bar-diatonic-progress-generator/7703

# 4 bar chord progression generater
#  function that takes key and scale and seed as parameters
define :chord_progression do |key, scale, seed|
  # Use the scale function to get the notes of the scale
  notes = scale(key, scale)
  # Define an array of possible chord degrees
  degrees = [1, 2, 3, 4, 5, 6, 7]
  # Shuffle the degrees and take the first four
  use_random_seed seed
  progression = degrees.shuffle.take(4)
  # Define an empty array to store the chords
  chords_array = []
  # Loop through the progression
  progression.each do |degree|
    # Get the root note of the chord based on the degree
    root = notes[degree - 1]
    # Use a case statement to determine the chord quality based on the degree
    case degree
    when 1, 4 # Major
      quality = :major7
    when 2, 3, 6 # Minor
      quality = :m7
    when 5
      quality = :dom7
    when 7 # Diminished
      quality = :dim7
    end
    # Use the chord function to get the diatonic chord
    current_chord = chord(root, quality)
    # Append the chord to the chords array
    chords_array.append(current_chord)
  end
  # Return the chords array
  use_synth :dtri
  chords_array.each do |current_chord|
    play_chord current_chord, release:4
    sleep 4
  end
end

# Example usage: generate a diatonic chord progression
live_loop :prog do
  chord_progression :c, :major, 75
end



##| drumset######################
kick =  [1,1,0,0,1,0,1,0,1,0,0,0,1,1,1,1]
snare = [0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0]
hat =   [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]


live_loop :kick do
  16.times do |hit|
    sample :bd_klub, hpf:30 if kick[hit] == 1
    sleep 0.25
  end
end

live_loop :Snare do
  16.times do |hit|
    sample :drum_snare_hard, amp:rrand(0.6,0.9) if snare[hit] == 1
    sleep 0.25
  end
end

live_loop :hat do
  16.times do |hit|
    sample :drum_cymbal_closed,  release:0.3, amp: rrand(0.05, 0.3), pan: rrand(-1,1) if spread(13,16).tick
    sleep 0.25
  end
end