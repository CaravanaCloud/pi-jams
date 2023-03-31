use_bpm 120

live_loop :met do
  sleep 1
end

live_loop :cymbal, sync: :met do
  sample :drum_cymbal_closed
  sleep 1
end

live_loop :bass, sync: :met do
  sample :drum_bass_soft
  sleep 4
  sample :drum_bass_soft
  sleep 1
  sample :drum_bass_soft
  sleep 3
end
