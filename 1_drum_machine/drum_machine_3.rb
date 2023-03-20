# https://www.drumeo.com/beat/13-easy-beginner-drum-beats/
use_bpm 92
slp = 0.66

amps = [
  [1, 1, 1, 1,  1, 1, 1, 1],
  [1, 0, 0, 0,  1, 1, 0, 0],
  [1, 0, 1, 0,  0, 0, 1, 0],
]

samples = [
  :drum_snare_soft,
  :drum_bass_hard,
  :drum_cymbal_closed
]


ticks = amps[0].length - 1
live_loop :myloop do
  0.upto(ticks) do |t|
    samples.each_with_index do |s, i|
      sample s, amp: amps[i][t]
    end
    sleep slp
  end
end