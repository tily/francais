require 'json'

desc 'convert'
task :convert do
  entries = []
  file = File.open('./data/fr.txt')
  lines = file.read.split("\r\n")
  lines.each_slice(2) do |f, j|
    if m = j.match(/(.+)【用例】(.+)/)
      j, e = m[1], m[2] 
    end
    entries << [f, j, e]
  end
  file = File.open('./app/scripts/dictionary.js', 'w')
  file.write "window.Francais = #{entries.to_json};"
end
