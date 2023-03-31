# Lo-Fi Song - Sonic Pi version with live_loop
use_bpm 80

# Define the chord progression
chords = [chord(:c4, :minor7), chord(:eb4, :major7), chord(:ab4, :major7), chord(:db4, :major7)]

# Define the melody
melody = [:c5, :r, :eb5, :r, :ab5, :r, :db5, :r].ring

# Define the bassline
bassline = [:c3, :r, :eb3, :r, :ab2, :r, :db3, :r].ring

# Define the beat
kick = "X---X---X---X---"
snare = "----X-------X---"
hh = "x-x-x-x-x-x-x-x-"

# Define the drum loop
live_loop :drum_machine do
  4.times do
    kick.each_char do |c|
      sample :bd_haus, amp: 2 if c == "X"
      sleep 0.25
    end
    snare.each_char do |c|
      sample :sn_dolf, amp: 1 if c == "X"
      sleep 0.25
    end
    hh.each_char do |c|
      sample :drum_cymbal_closed, amp: 0.5, release: 0.1 if c == "x"
      sleep 0.25
    end
  end
end

# Define the chords loop
live_loop :chords do
  with_fx :distortion do
    with_fx :reverb, room: 0.8, mix: 0.3 do
      8.times do
        chords.each do |c|
          play_chord c, attack: 0.5, release: 3, amp: 0.3
          sleep 4
        end
      end
    end
  end
end

# Define the melody loop
live_loop :melody do
  with_fx :slicer, phase: 0.25 do
    with_fx :reverb, room: 0.5, mix: 0.4 do
      16.times do
        play melody.tick, attack: 0.1, release: 0.5, amp: 0.5
        sleep 0.5
      end
    end
  end
end

# Define the bassline loop
live_loop :bassline do
  with_fx :distortion do
    with_fx :reverb, room: 0.5, mix: 0.3 do
      8.times do
        bassline.each do |n|
          play n, attack: 0.5, release: 2, amp: 0.5
          sleep 1
        end
      end
    end
  end
end
