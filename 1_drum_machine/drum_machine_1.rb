# Partial Samples

live_loop :myloop do
  sample :loop_amen,
    rate: 2,
    attack: 0.01,
    sustain: 0,
    release: 0.35,
    start: 0.2,
    finish: 0.8
  sleep 0.5
end