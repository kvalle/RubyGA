require 'selection_mechanism/roulette_wheel'

class FitnessProportionateSelectionMechanism < RouletteWheelSelectionMechanism
  
  def exp_val(individual, generation)
    f = individual.fitness.to_f
    avg = generation.map { |i| i.fitness }.average
    
    f / avg
  end
  
end