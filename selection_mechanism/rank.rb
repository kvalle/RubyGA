require 'selection_mechanism/roulette_wheel'

class RankSelectionMechanism < RouletteWheelSelectionMechanism
  
  def exp_val(individual, generation)
    max = $settings.get(@mode + '.rank_selection.max')
    min = 2 - max
    r   = rank(individual, generation)
    n   = generation.size
    
    min + (max - min) * ((r-1.0)/(n-1.0))
  end
  
  
  private
  
  def rank(individual, generation)
    list = generation.sort { |a,b| a.fitness <=> b.fitness }.reverse
    rank = list.index(individual) + 1
    if rank == nil
      raise Exception, 'Individual not in generation: ' + individual.to_s
    end
    rank
  end
  
end