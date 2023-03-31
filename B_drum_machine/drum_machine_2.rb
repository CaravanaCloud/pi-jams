# Partial Samples
# ADSR Envelope: https://sonic-pi.net/tutorial.html#section-3-5
live_loop :met do
  sample :loop_amen,
    rate: 2,
    attack: 0.01,
    sustain: 0,
    release: 0.35,
    start: 0.2,
    finish: 0.8
  sleep 1
end