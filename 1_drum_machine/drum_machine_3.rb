use_bpm 100
beat = 1

live_loop :drums do
  sample :drum_heavy_kick
  sleep beat
  sample :drum_snare_hard
  sleep beat
  sample :drum_heavy_kick
  sleep beat
  sample :drum_snare_hard
  sleep beat
end

live_loop :hihat do
  sample :drum_cymbal_closed
  sleep 0.25 * beat
  sample :drum_cymbal_pedal
  sleep 0.75 * beat
end