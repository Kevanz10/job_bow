class ScoreboardTable
  def initialize(scores, pinfalls, names)
    @scores = scores
    @pinfalls = pinfalls
    @names = names
  end

  def self.frame
    print "Frame\t\t"
    (1..10).each {|frame_number| print "#{frame_number}\t\t"}
    print "\n"
  end

  def player_name index
    print "#{@names[index]}\t\t"
    print "\n"
  end

  def pinfalls index
    print "Pinfalls\t"
    @pinfalls[index].each_with_index do |pinfall, index| 
      if pinfall.size == 1
        print "\t#{pinfall}\t" 
      elsif index == (@pinfalls[0].size - 1)
        print "#{pinfall[0]} \t #{pinfall[1][0]} \t #{pinfall[1][1]}"
      else
        print "#{pinfall[0]} \t #{pinfall[1]} \t"
      end
    end
    print "\n"
  end

  def score index
    print "Score\t\t"
    @scores[index].each {|score| print "#{score}\t\t"}
    print "\n"
  end

  def board
    (1..@names.size).each_with_index do |name, index|
      ScoreboardTable.frame if index == 0
      player_name(index)
      pinfalls(index)
      score(index)
    end
  end
end