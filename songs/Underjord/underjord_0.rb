# Underjord Demo
# https://www.youtube.com/watch?v=suH_goWVBeA&t=71s
use_bpm 130

live_loop :met do
  sleep 1
end

live_loop :hcc2, sync: :met do
  sleep 0.5
  sample :drum_cymbal_closed, rate: 1.2, start: 0.01, finish: 0.5, amp: 0.6
  sleep 0.5
end

live_loop :bass, sync: :met do
  with_fx :panslicer, mix: 0.4 do
    with_fx :reverb, mix: 0.75 do
      use_synth :tech_saws
      use_synth_defaults cutoff: 60, amp: 0.75, attack: 0
      
      play :g3, sustain: 6
      sleep 6
      
      play :d3, sustain: 2
      sleep 2
      
      play :e3, sustain: 8
      sleep 8
    end
  end
end

live_loop :kick, sync: :met do
  # Ring ticker
  if "x--x--x---x--x--".ring.tick == "x" then
    sample :bd_tek, amp: 1.2
  end
  sleep 0.25
end

live_loop :clap, sync: :met do
  sleep 1
  with_fx :echo, mix: 0.2 do
    with_fx :reverb, mix: 0.2, room: 0.5 do
      # Sample Overlaying
      sample :drum_snare_hard, rate: 2.5, amp: 0.75
      sample :drum_snare_hard, rate: 2.2, start: 0.02, pan: 0.2, amp: 0.5
      sample :drum_snare_hard, rate: 2, start: 0.04, pan: -0.2, amp: 0.7
      sleep 1
    end
  end
end



with_fx :reverb, mix: 0.2 do
  with_fx :panslicer, mix: 0.2 do
    live_loop :hhc1, sync: :met do
      if "x-x-x-x-x-x-x-x-xxx-x-x-x-x-x-x-".ring.tick == "x"
        sample :drum_cymbal_closed, amp: 0.75, rate: 2.5, finish: 0.5, pan: [-0.3, 0.3].choose
      end
      sleep 0.125
    end
  end
end

with_fx :reverb, mix: 0.7 do
  live_loop :arp, sync: :met do
   stop
    with_fx :echo, phase: 1, mix: (line 0.1, 1, steps: 128).mirror.tick do
      use_synth  :beep
      p = (line -0.7, 0.7, steps: 64).mirror.tick
      notes = (scale :g4, :major_pentatonic).shuffle
      tick
      play notes.look, amp: 0.6, pan: p
      sleep 0.75
    end
  end
end