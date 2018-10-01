class User
  def self.scores(file)
    frames = Hash.new { |hash, key| hash[key] = [] }
    File.open(file).each do |line|
      player = line.split(" ")
      frames[player[0]] << player[1]
    end
    frames
  end
end