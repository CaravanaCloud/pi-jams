repodir = "#{ENV['HOME']}/src/pi-jams"
samples = "#{repodir}/songs/Hydelic - Connected/samples"


puts "playing #{samples}"

sample "#{samples}/bass.wav"
sample "#{samples}/drums.wav"
sample "#{samples}/other.wav"
sample "#{samples}/strings.wav"
sample "#{samples}/vocals.wav"
