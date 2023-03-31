# https://in-thread.sonic-pi.net/t/bachs-prelude-in-c-major-bmv-846-allegro/6598
# Bach's "Prelude in C major BMV 846 allegro"
# Piano music sheet http://www.agatidiperinaldo.org/Bach%20-%20Preludio%201.pdf

# My performance of this code https://youtu.be/ea7TmW_tzwk

# Ideas:
# - Send midi to 0-coast
# - Create visuals from midi notes in Hydra or Improviz
# - Create dynamics/velocity on amp from note sheet: p, ff
# - "Use_random_seed Time.now.to_i"
# - Create a drum beat

# How to use "case" https://www.rubyguides.com/2015/10/ruby-case/


use_bpm 132  #112 original tempo on note sheet    #132 or 142 my tempo

live_loop :met do #Metronon
  sleep 1
end


# Song structure
# - Playing 2.times arpeggio most of the time
# - Last 2 bars only played once
# - Last bar are a chord

# Arpeggio
define :my_notes_play do |my_notes, my_pattern|
  
  #  use_synth :saw   # :saw :dsaw :dpulse :dtri    # change here
  
  case my_pattern
  when "repeat_two_times"
    2.times do
      8.times do
        play my_notes.tick, release: 0.25, cutoff: range(70,120,step: 2).mirror.tick(:a),
          pan: ring(0.25,-0.25).choose #if spread(9,16).tick
        sleep 0.5
      end
    end
  when "dont_repeat"
    16.times do
      play my_notes.tick, release: 0.25, cutoff: range(70,120,step: 2).mirror.tick(:a),
        pan: ring(0.25,-0.25).choose #if spread(9,16).tick
      sleep 0.5
    end
  when "play_my_chord"
    play_chord my_notes, release: 0.5*8, cutoff: range(70,120,step: 2).mirror.tick(:a),
      pan: ring(0.25,-0.25).choose #if spread(9,16).tick
    sleep 0.5*8
  end
end

# Bass half notes
define :my_notes_play_bass do |my_notes, my_pattern|
  case my_pattern
  when "repeat_two_times"
    #use_synth :saw
    2.times do
      play my_notes.take(1).tick, release: 6*0.25, cutoff: range(70,120,step: 2).mirror.tick(:b),
        pan: ring(0.25,-0.25).choose, amp: 0.4 #if spread(3,7).tick
      sleep 4
    end
  when "dont_repeat"
    #use_synth :saw
    2.times do
      play my_notes.take(1).tick, release: 6*0.25, cutoff: range(70,120,step: 2).mirror.tick(:b),
        pan: ring(0.25,-0.25).choose, amp: 0.4 #if spread(3,7).tick
      sleep 4
    end
  when "play_my_chord"
    play my_notes.take(1).tick, release: 6*0.25, cutoff: range(70,120,step: 2).mirror.tick(:b),
      pan: ring(0.25,-0.25).choose, amp: 0.4 #if spread(3,7).tick
    sleep 4
  end
end

# Arpeggio + bass halfnote + which pattern to play
define :my_inst do |my_notes, my_pattern|
  use_synth :saw   # :saw :dsaw :dpulse :dtri    # change here
  in_thread do
    my_notes_play my_notes, my_pattern
  end
  #use_synth :saw   # :saw :dsaw :dpulse :dtri    # change here
  my_notes_play_bass my_notes, my_pattern
end



# Notes
with_fx :reverb, room: 0.8 do
  
  live_loop :BMV_inst, sync: :met do
    
    # stop
    #bar 1-4
    puts "Bar 1  ------"
    notes = [:c3, :e3, :g3, :c4, :e4, :g3, :c4, :e4]
    my_inst notes, "repeat_two_times"
    
    puts "Bar 2"
    notes = [:c3, :d3, :a3, :d4, :f4, :a3, :d4, :f4]
    my_inst notes, "repeat_two_times"
    
    puts "Bar 3"
    notes = [:b2, :d3, :g3, :d4, :f4, :g3, :d4, :f4]
    my_inst notes, "repeat_two_times"
    
    puts "Bar 4"
    notes = [:c3, :e3, :g3, :c4, :e4, :g3, :c4, :e4]
    my_inst notes, "repeat_two_times"
    
    
    #bar 5-8
    puts "Bar 5  ------"
    notes = [:c3, :e3, :a3, :e4, :a4, :a3, :e4, :a4]
    my_inst notes, "repeat_two_times"
    
    puts "Bar 6"
    notes = [:c3, :d3, :fs3, :a3, :d4, :fs3, :a3, :d4]
    my_inst notes, "repeat_two_times"
    
    puts "Bar 7"
    notes = [:b2, :d3, :g3, :d4, :g4, :g3, :d4, :g4]
    my_inst notes, "repeat_two_times"
    
    puts "Bar 8"
    notes = [:b2, :c3, :e3, :g3, :c4, :e3, :g3, :c4]
    my_inst notes, "repeat_two_times"
    
    
    #bar 9-12
    puts "Bar 9 ------"
    notes = [:a2, :c3, :e3, :g3, :c4, :e3, :g3, :c4]
    my_inst notes, "repeat_two_times"
    
    puts "Bar 10"
    notes = [:d2, :a2, :d3, :fs3, :c4, :d3, :fs3, :c4]
    my_inst notes, "repeat_two_times"
    
    puts "Bar 11"
    notes = [:g2, :b2, :d3, :g3, :b3, :d3, :g3, :b3]
    my_inst notes, "repeat_two_times"
    
    puts "Bar 12"
    notes = [:g2, :bb2, :e3, :g3, :cs4,  :e3, :g3, :cs4]
    my_inst notes, "repeat_two_times"
    
    
    #bar 13-16
    puts "Bar 13 ------"
    notes = [:f2, :a2, :d3, :a3, :d4, :d3, :a3, :d4]
    my_inst notes, "repeat_two_times"
    
    puts "Bar 14"
    notes = [:f2, :gs2, :d3, :f3, :b3, :d3, :f3, :b3]
    my_inst notes, "repeat_two_times"
    
    puts "Bar 15"
    notes = [:e2, :g2, :c3, :g3, :c4, :c3, :g3, :c4]
    my_inst notes, "repeat_two_times"
    
    puts "Bar 16"
    notes = [:e2, :f2, :a2, :c3, :f3, :a2, :c3, :f3]
    my_inst notes, "repeat_two_times"
    
    
    #bar 17-20
    puts "Bar 17 ------"
    notes = [:d2, :f2, :a2, :c3, :f3, :a2, :c3, :f3,]
    my_inst notes, "repeat_two_times"
    
    puts "Bar 18"
    notes = [:g1, :d2, :g2, :b2, :f3, :g2, :b2, :f3,]
    my_inst notes, "repeat_two_times"
    
    puts "Bar 19"
    notes = [:c2, :e2, :g2, :c3, :e3, :g2, :c3, :e3]
    my_inst notes, "repeat_two_times"
    
    puts "Bar 20"
    notes = [:c2, :g2, :bb2, :c3, :e3, :bb2, :c3, :e3]
    my_inst notes, "repeat_two_times"
    
    
    #bar 21-24
    puts "Bar 21 ------"
    notes = [:f1, :f2, :a2, :c3, :e3, :a2, :c3, :e3]
    my_inst notes, "repeat_two_times"
    
    puts "Bar 22"
    notes = [:fs1, :c2, :a2, :c3, :ds3, :a2, :c3, :ds3]
    my_inst notes, "repeat_two_times"
    
    puts "Bar 23"
    notes = [:g1, :ds2, :b2, :c3, :ds3, :b2, :c3, :ds3]
    my_inst notes, "repeat_two_times"
    
    puts "Bar 24"
    notes = [:gs1, :f2, :b2, :c3, :d3, :b2, :c3, :d3]
    my_inst notes, "repeat_two_times"
    
    
    #bar 25-28
    puts "Bar 25 ------"
    notes = [:g1, :f2, :g2, :b2, :d3, :g2, :b2, :d3]
    my_inst notes, "repeat_two_times"
    
    puts "Bar 26"
    notes = [:g1, :e2, :g2, :c3, :e3, :g2, :c3, :e3]
    my_inst notes, "repeat_two_times"
    
    puts "Bar 27"
    notes = [:g1, :d2, :g2, :c3, :f3, :g2, :c3, :f3]
    my_inst notes, "repeat_two_times"
    
    puts "Bar 28"
    notes = [:g1, :d2, :g2, :b2, :f3, :g2, :b2, :f3]
    my_inst notes, "repeat_two_times"
    
    
    #bar 29-32
    puts "Bar 29 ------"
    notes = [:g1, :ds2, :a2, :c3, :fs3, :a2, :c3, :fs3]
    my_inst notes, "repeat_two_times"
    
    puts "Bar 30"
    notes = [:g1, :e2, :g2, :c3, :g3, :g2, :c3, :g3]
    my_inst notes, "repeat_two_times"
    
    puts "Bar 31"
    notes = [:g1, :d2, :g2, :c3, :f3, :g2, :c3, :f3]
    my_inst notes, "repeat_two_times"
    
    puts "Bar 32"
    notes = [:g1, :d2, :g2, :b2, :f3, :g2, :b2, :f3]
    my_inst notes, "repeat_two_times"
    
    
    
    #bar 33-36
    puts "Bar 33 ------"
    notes = [:c1, :c2, :g2, :bb2, :e3, :g2, :bb2, :e3]
    my_inst notes, "repeat_two_times"  # pattern "1" => repeating notes two times
    
    # Ending
    puts "Bar 34"
    notes = [:c1,:c2,:f2,:a2, :c3,:f3,:c3,:a2, :c3,:a2,:f2,:a2, :f2,:d2,:f2,:d2]  # pattern "2" => not repeating
    my_inst notes, "dont_repeat"
    
    puts "Bar 35"
    notes = [:c1,:b1,:g3,:b3, :d4,:f4,:d4,:b3, :d3,:b3,:g3,:b3, :d3,:f3,:e3,:d3]  # pattern "2" => not repeating
    my_inst notes, "dont_repeat"
    
    puts "Bar 36"
    notes = [:c1, :c2, :e3, :g3, :c4]  # pattern "3" => all notes played as a chord
    my_inst notes, "play_my_chord"
    
    sleep 4
    
    # Waiting before starting from begining
    sleep 8
  end
  
end

# ----------  Drum sketch to Bach ---------- #

my_drum_on = false #true/false

with_fx :reverb, room: rrand(0.3,0.9) do
  live_loop :drums, sync: :met do
    #stop
    sample :bd_haus, cutoff: 90, amp: 1.5, on: my_drum_on
    sleep 1
    sample :bd_haus, cutoff: 70, amp: 2.5, pan: ring(0.25, 0,-0.25).choose,
      on: my_drum_on if one_in(4)
    sleep 0.5
    sample :bd_haus, cutoff: 70, amp: 2.5, pan: ring(0.25, 0,-0.25).choose,
      on: my_drum_on if one_in(4)
    sleep 0.5
    sample :sn_generic, cutoff: ring(100,105,110,115,120,125,130).mirror.tick(:asd),
      amp: 0.5, finish: rrand(0.1,0.5), on: my_drum_on  if one_in(2)
    sleep 0.5
    sample :sn_generic, cutoff: ring(100,105,110,115,120,125,130).mirror.tick(:asd),
      amp: 0.5, finish: rrand(0.1,0.3), on: my_drum_on  if one_in(1)
    sleep 0.5*2
    sample :bd_haus, cutoff: 70, amp: 2.5, pan: ring(0.25, 0,-0.25).choose,
      on: my_drum_on if one_in(4)
    sleep 0.5
  end
end

# Sketch idea from density hihats from Mister Bomb
# - Sonic Pi Tutorial - Making Trap Hi Hats with Density function
# - https://youtu.be/3Fii-M0I1FA?t=543
define :hats do |d|
 # stop
  density d do
    sample :drum_cymbal_closed, on: my_drum_on, amp: 0.75,
      pan: ring(-0.25,0.25).choose, finish: rrand(0.02,0.08)
    sleep 1
  end
end

live_loop :hats, sync: :met do
  #hats (ring 1,2,3,4,5,4,3,2,1).tick
  #hats (ring 1,2,1).choose
  hats (ring 2,2,2,2,4).choose
  #hats rrand_i(1,4)
end

