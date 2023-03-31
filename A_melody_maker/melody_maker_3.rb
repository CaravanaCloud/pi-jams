
play :A, attack: rrand(1,4)
sleep 4

r = rrand(1,4)
puts "r=#{r}"
play :C, attack: r, release: 4-r
sleep 4
play :Eb, attack: 4-r, release: r
sleep 4
