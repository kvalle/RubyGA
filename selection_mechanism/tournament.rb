class TournamentSelectionMechanism < SelectionMechanism
  
  def select(individuals, number)
    @tournament_size = $settings.get(@mode + '.tournament.size')
    @epsilon = $settings.get(@mode + '.tournament.epsilon')
    
    group = individuals.dup
    winners = []
    
    number.times do 
      contestants = []
      @tournament_size.times do
        r = rand(group.size)
        contestants << group.delete_at(r)
      end
      if rand < @epsilon
        winners << contestants.delete_at(rand(contestants.size))
      else
        winners << contestants.sort! { |a,b| a.fitness <=> b.fitness }.delete_at(0)
      end
      group += contestants
    end
    
    winners
  end
  
end