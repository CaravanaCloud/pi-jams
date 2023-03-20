amps = [
  [1, 1, 1, 1,  1, 1, 1, 1,  1, 1, 1, 1,  1, 1, 1, 1 ],
  [1, 0, 0, 0,  1, 0, 0, 0,  1, 0, 0, 0,  1, 0, 0, 0 ]
]

samples = [
  :drum_cymbal_closed,
  :drum_bass_hard
]

ticks = amps[0].length - 1
live_loop :myloop do
  0.upto(ticks) do |t|
    samples.each_with_index do |s, i|
      sample s, amp: amps[i][t]
    end
    sleep 1
  end
end