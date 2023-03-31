#Original code by Ludvig. Loop control, bass_ixi and chord_ixi
# by Eli... 

use_bpm 118
set_sched_ahead_time! 4
# You can control loops from here or from scripted commands
# at the end of the code...
# loops = [1,1,1,1,1,1,1,0,0]
#loops =  [1,1,1,1,0,1,0,1,0]
loops =   [0,0,0,0,0,0,0,0,0]

kicks  = 0
hats = 1
rims   = 2
chords = 3
chords_ixi = 4
bass  = 5
bass_ixi = 6
bells  = 7
hiss = 8

bass_note  = [29,34,36,39,41,29,34,36,41,39,34,36,29,31,34,39,36,41,43,36,34,29,
              27,32,34,37,39,27,32,34,39,37,32,34,27,29,32,37,34,39,41,34,32,27]

bass_rel =   [0.75,0.75,1,1,0.5,0.75,0.75,1,0.5,0.5,0.5,0.75,0.75,1,1,0.5,0.75,0.75,1,0.5,0.5,0.5,
              0.75,0.75,1,1,0.5,0.75,0.75,1,0.5,0.5,0.5,0.75,0.75,1,1,0.5,0.75,0.75,1,0.5,0.5,0.5]

define :start_loop do |i|
  loops[i] = 1
end

define :stop_loop do |i|
  loops[i] = 0
end

define :stop_all do
  loops[0] = 0
  loops[1] = 0
  loops[2] = 0
  loops[3] = 0
  loops[4] = 0
  loops[5] = 0
  loops[6] = 0
  loops[7] = 0
  loops[8] = 0
end

define :pattern do |pattern|
  return pattern.ring.tick == "x"
end

define :bellp do |n, m|
  if loops[bells] == 1 then
    n.each.with_index do |n,id|
      sleep 2
      play n + 0.3
      sleep 0.1
      play n + 17
      sleep 0.4
      play n + 0.2
      sleep 0.1
      play n + 12
      sleep 0.9
      play m[id] + 0.2
      play m[id] + 24
      sleep 0.5
    end
  else
    sleep 1
  end
end

define :basn do |n, r|
  n.each.with_index do |n, id|
    # if loops[bass] is changed while this is playing, the next
    # line lets the define break out and return.
    if loops[bass] == 0 then
      return
    else
      play n, release: r[id], cutoff: rrand(55, 125)
      sleep r[id]
    end
  end
end

live_loop :met1 do
  sleep 1
end

live_loop :kicks, sync: :met1 do
  if loops[kicks] == 1 then
    with_swing -0.08, 2 do
      sample :bd_tek, rate: 0.8, sustain: 0, release: 0.3, amp: 0.8 if
      pattern "x---x---x---x---"
    end
    sleep 0.25
  else
    sleep 1
  end
end

live_loop :kick_soft, sync: :met1 do
  if loops[kicks] == 1 then
    with_swing -0.08, 2 do
      sample :bd_tek, rate: 0.7, sustain: 0, release: 0.2, amp: 0.2 if
      pattern "---------------x---------x------"
    end
    sleep 0.25
  else
    sleep 1
  end
end

live_loop :hh, sync: :met1 do
  if loops[hats] == 1 then
    with_swing -0.08, 2 do
      sample :drum_cymbal_closed, sustain: 0, release: 0.15, amp: 0.8, rate: 1.1 if pattern "--x---x---x---x-"
    end
    sleep 0.25
  else
    sleep 1
  end
end

live_loop :hh_short, sync: :met1 do
  if loops[hats] == 1 then
    with_swing -0.08, 2 do
      sample :drum_cymbal_pedal, sustain: 0, release: 0.05, pan: -0.4, amp: 0.3, start: 0.1 if pattern "--xx--x--xx--x-x"
    end
    sleep 0.25
  else
    sleep 1
  end
end

with_fx :reverb, damp: 1, mix: 0.3 do
  live_loop :rimshot, sync: :met1 do
    if loops[rims] == 1 then
      with_swing -0.08, 2 do
        sample :sn_generic, amp: 0.4, sustain: 0, release: 0.10 if pattern "----x-------x---"
      end
      sleep 0.25
    else
      sleep 1
    end
  end
end

live_loop :rimshot2, sync: :met1 do
  if loops[rims] == 1 then
    with_swing -0.08, 2 do
      sample :elec_filt_snare, sustain: 0, release: 0.10, pan: 0.4, rate: 0.5, amp: 0.2 if pattern "----x--x----x-------x--x-x--x---"
    end
    sleep 0.25
  else
    sleep 1
  end
end

with_fx :slicer, phase: 1, wave: 0, invert_wave: 1, mix: 0.9 do
  
  with_fx :level, amp: 0.15 do
    live_loop :housechords1, sync: :met1 do
      if loops[chords] == 1 then
        if loops[chords_ixi] == 1 then
          with_fx :ixi_techno, phase: 0.75 do
            use_synth :mod_fm
            use_synth_defaults pan: 1, decay: 4, sustain_level: 0, sustain: 0, release: 0.01,
              divisor: 1, mod_range: 0.2, mod_wave: 3
            
            with_fx :pitch_shift, pitch: -3.9, reps: 2 do
              play chord(:a3, "m11")
              play chord(:a3, "m11"), pan: -1, mod_range: 0.3
              sleep 4
            end
            with_fx :pitch_shift, pitch: 7.1, reps: 4 do
              play chord(:f3, "m11"), decay: 2, mod_range: 0.3
              play chord(:f3, "m11"), pan: -1, decay: 2
              sleep 2
            end
            with_fx :pitch_shift, pitch: -1.9, reps: 2 do
              play chord(:f3, "m11")
              play chord(:f3, "m11"), pan: -1, mod_range: 0.3
              sleep 4
            end
            with_fx :pitch_shift, pitch: 5.1, reps: 4 do
              play chord(:f3, "m11"), decay: 2, mod_range: 0.3
              play chord(:f3, "m11"), pan: -1, decay: 2
              sleep 2
            end
          end
          
        else
          use_synth :mod_fm
          use_synth_defaults pan: 1, decay: 4, sustain_level: 0, sustain: 0, release: 0.01,
            divisor: 1, mod_range: 0.2, mod_wave: 3
          
          with_fx :pitch_shift, pitch: -3.9, reps: 2 do
            play chord(:a3, "m11")
            play chord(:a3, "m11"), pan: -1, mod_range: 0.3
            sleep 4
          end
          with_fx :pitch_shift, pitch: 7.1, reps: 4 do
            play chord(:f3, "m11"), decay: 2, mod_range: 0.3
            play chord(:f3, "m11"), pan: -1, decay: 2
            sleep 2
          end
          with_fx :pitch_shift, pitch: -1.9, reps: 2 do
            play chord(:f3, "m11")
            play chord(:f3, "m11"), pan: -1, mod_range: 0.3
            sleep 4
          end
          with_fx :pitch_shift, pitch: 5.1, reps: 4 do
            play chord(:f3, "m11"), decay: 2, mod_range: 0.3
            play chord(:f3, "m11"), pan: -1, decay: 2
            sleep 2
          end
        end
        
      else
        sleep 1
      end
    end
  end
  
  with_fx :ping_pong, phase: 0.75 do
    with_fx :level, amp: 0.2 do
      live_loop :housechords, sync: :met1 do
        if loops[chords] == 1 then
          use_synth :mod_fm
          use_synth_defaults pan: 1, decay: 4, sustain_level: 0, sustain: 0, release: 0.01,
            divisor: 1, mod_range: 0.2, mod_wave: 3
          2.times do
            play (chord_invert(chord :f3, "m11"), 2)
            play chord(:f3, "m11"), pan: -1, mod_range: 0.3
            sleep 4
          end
          2.times do
            play (chord_invert(chord :c3, "m11"), 4), mod_range: 0.3
            play (chord_invert(chord :c3, "m11"), 3), pan: -1
          end
          2.times do
            play chord(:Eb3, "m11")
            play chord(:Eb3, "m11"), pan: -1,mod_range: 0.3
            sleep 4
          end
          2.times do
            play (chord_invert(chord :Bb2, "m11"), 2), mod_range: 0.3
            play (chord_invert(chord :Bb2, "m11"), 5), pan: -1, mod_range: 0.2
            sleep 4
          end
        else
          sleep 1
        end
      end
    end
  end
end

live_loop :Bassline, sync: :met1 do
  if loops[bass] == 1 then
    use_synth :tri
    if loops[bass_ixi] == 1 then
      with_fx :ixi_techno, phase: 0.75 do
        basn bass_note, bass_rel
      end
    else
      basn bass_note, bass_rel
    end
    
  else
    sleep 1
  end
end

with_fx :reverb, room: 1 do
  with_fx :ping_pong, phase: 0.75 do
    with_fx :lpf, cutoff: 130, pre_amp: 0.0625 do
      live_loop :lilmelo, sync: :met1 do
        if loops[bells] == 1 then
          use_synth :pluck
          bell_notes = [70,65,67,70,68,63,60,72]
          bell_rel = [67,63,65,58,65,61,65,70]
          
          bellp bell_notes, bell_rel
        else
          sleep 1
        end
      end
    end
  end
end

with_fx :reverb do
  live_loop :vinyl, sync: :met1 do
    if loops[hiss] == 1 then
      sample :vinyl_hiss, amp: 0.15
      sleep sample_duration :vinyl_hiss
    else
      sleep 1
    end
  end
end

start_loop hiss
sleep 4
start_loop rims
sleep 8
start_loop hats
sleep 8
start_loop chords
sleep 16
start_loop kicks
sleep 16
start_loop bass
sleep 32
start_loop bells
sleep 32
stop_loop bass
sleep 16
start_loop bass_ixi
start_loop bass
sleep 32
stop_loop bass
stop_loop bass_ixi
sleep 4
start_loop chords_ixi
sleep 32
stop_all