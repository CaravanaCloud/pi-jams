# https://in-thread.sonic-pi.net/t/kids-these-days-and-their-lofi-type-beats/6888
use_bpm 88
use_random_seed 1

rhy = (ring 2.5, 1, 0.5)
chrd = (ring :e, :f, :c, :c)
modd = (ring :minor7, :major7, :major, :major)

with_fx :distortion, distort: 0.55 do
  live_loop :kik do
    sample :bd_gas
    sleep rhy.tick
  end
end

with_fx :slicer, phase: rhy[0], invert_wave: 1, smooth_up: 1, smooth_down: 0.01,  pulse_width: 0.04 do |s|
  live_loop :s_ctrl do
    control s, phase: rhy.tick
    sleep rhy.look
  end
  
  with_fx :bitcrusher, amp: 1.5, cutoff: 100, bits: 12, sample_rate: midi_to_hz(note(:e))*40 do
    with_fx :reverb, room: 0.75, mix: 0.4 do
      live_loop :tik do
        in_thread do
          3.times do
            sleep 0.25
            sample :drum_cymbal_pedal, amp: 0.1, beat_stretch: 0.3, on: (one_in 3)
          end
        end
        sleep 0.5
        sample :drum_cymbal_pedal, amp: 0.2
        sleep 0.5
      end
      live_loop :tok do
        sleep 1
        sample :sn_dolf, amp: 0.3, beat_stretch: 0.38
        sleep 0.5
        sample :bd_klub, amp: 0.4
        sample :drum_splash_soft, amp: 0.2, beat_stretch: 1.5, sustain: 0.25
        sleep 0.75
        in_thread do
          7.times do
            sample :sn_dolf, amp: 0.1 , beat_stretch: 0.36, on: (one_in 4)
            sleep 0.25
          end
        end
        sleep 0.75
        sample :sn_dolf, amp: 0.3, beat_stretch: 0.36
        sample :elec_bong, amp: 0.29, beat_stretch: 0.41
        sleep 1
      end
      with_fx :wobble, res: 0.6, phase: 4, mix: 0.7, cutoff_min: 50 do
        live_loop :voxy do
          use_synth :tri
          use_synth_defaults amp: 0.03
          c = chrd.tick
          m = modd.look
          play_chord (chord c+12, m), attack: 1, sustain: 0.7, release: 0
          sleep 2.25
          play_chord (chord c, m, num_octaves: 2), attack: 0.75, release: 0.3
          sleep 1.75
        end
        live_loop :base do
          use_synth :tri
          c = chrd.tick
          6.times do |i|
            n = play c-36, amp: 0.7, attack: 0, release: 0.6, cutoff: 50, note_slide: 0.2, on: (one_in i/+1)
            sleep 0.5
          end
          play c-24, amp: 0.3, release: 1
          sleep 1
        end
      end
      with_fx :flanger, phase: 0.75, depth: 5, wave: 2, feedback: 0.4 do
        live_loop :pyanno do
          use_synth :piano
          use_synth_defaults amp: 0.7, release: 2.2
          c = chrd.tick
          m = modd.look
          
          in_thread do
            15.times do
              sleep 0.25
              play (chord c+12, m, num_octaves: 2).tick(:b, step: 2), on: (one_in 3), amp: rand(0.15), release: rand(3)
            end
          end
          play c-24, amp: 0.3
          2.times do
            play_chord (chord c-12, m)
            sleep 1.5
          end
          in_thread do
            4.times do
              play (chord c-24, m).tick(:c), on: (one_in 2), amp: rand(0.4), release: rand(3)
              sleep 0.25
            end
          end
          sleep 0.5
          
          
          play_chord (chord c-12, m), release: 0.4
          sleep 0.5
        end
      end
    end
  end
end