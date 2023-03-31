# https://in-thread.sonic-pi.net/t/guitar-backing-track-generator/6836/
use_debug false

class BackingTrack
  
  attr_accessor :chord_progression, :strumming_pattern, :bpm, :tuning, :guitar_chords
  
  def initialize(chord_progression,
                 strumming_pattern = ["D.DU.U.D",".DU.DU.."],
                 bpm=200,
                 tuning = [:e2, :a2, :d3, :g3, :b3, :e4],
                 guitar_chords= { "C" => "x32010",
                                  "G" => "320033",
                                  "A" => "x03330",
                                  "E" => "022100",
                                  "Am" => "x02210",
                                  "F" => "133211",
                                  "B" => "x24442",
                                  "D" => "xx0232",
                                  "F5"=> "133xxx",
                                  "F#"=> "244322",
                                  "Bb5"=> "688xxx",
                                  "Ab5"=> "466xxx",
                                  "Db5"=> "x466xxx"
                                  })
    
    @chord_progression = chord_progression
    @strumming_pattern   = strumming_pattern
    @bpm   = bpm
    @tuning   = tuning
    @guitar_chords = guitar_chords
  end
  
end


simple_track =
  BackingTrack.new(["G","D","C","C"])

iggyPop_Passenger =
  BackingTrack.new(["Am", "F", "C", "G","Am", "F", "C", "E"],
                   ["x.UD.U"])
  
nirvana_smells =
  BackingTrack.new(["F5","Bb5","Ab5","Db5"],
                   ["D..UD.xx","xxD.DUDU"],
                   160,
                   [:eb2, :ab2, :db3, :gb3, :bb3, :eb4]
                   )
  
strokes_only_once =
  BackingTrack.new(["Dbm", "E", "B", "F#"],
                   [".DDUDUx","UxUxUD.D."],
                   118,
                   [:e2, :a2, :d3, :g3, :b3, :e4],
                   {"Dbm"=> "xxx999",
                    "E"=> "xxx997",
                    "B"=> "xxx879",
                    "F#"=> "xxx676"
                    })
  

live_loop :guitar do
  play_backing_track iggyPop_Passenger
end


define :chord_name_to_notes do |chord_name, guitar_chords, tuning|
  
  guitar_pattern = guitar_chords[chord_name]
  notes = []
  i = 0
  guitar_pattern.split(//).each do |curr_string|
    if curr_string!='x'
      notes.push(tuning[i] + curr_string.to_i)
    end
    i=i+1
  end
  notes
end

define :single_stroke do |notes, stroke|
  if stroke == 'D' # Down stroke
    time = 0.03
    rel = 1.6
  elsif stroke == 'U' # Up stroke
    time = 0.03
    rel = 1.6
    notes=notes.reverse.take(3)
  elsif stroke == 'x' # Down stroke
    time = 0.001
    rel = 0.2
  end
  
  if stroke != '.'
    in_thread do
      play_pattern_timed notes, time, release: rel
    end
  end
  
end

define :play_strumming do |notes,strumming_pattern|
  strumming_pattern.look.split(//).each do |stroke|
    single_stroke notes, stroke
    sleep 0.5
  end
end

define :play_backing_track do |backing_track|
  use_bpm backing_track.bpm
  with_fx :reverb do
    with_fx :lpf, cutoff: 115 do
      with_synth :pluck do
        tick
        notes = chord_name_to_notes backing_track.chord_progression.look, backing_track.guitar_chords, backing_track.tuning
        play_strumming notes, backing_track.strumming_pattern
      end
    end
  end
end





# Next note higher or equal to base note n, that is in the chord c
define :next_note do |n, c|
  # Make sure n is a number
  n = note(n)
  # Get distances to each note in chord, add smallest to base note
  n + (c.map {|x| (note(x) - n) % 12}).min
end

ukulele = [:g, :c, :e, :a]
guitar_standard = [:e2, :a2, :d3, :g3, :b3, :e4]