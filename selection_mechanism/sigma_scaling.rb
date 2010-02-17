require 'selection_mechanism/roulette_wheel'

class SigmaScalingSelectionMechanism < RouletteWheelSelectionMechanism
  
  def exp_val(individual, generation)
    if @prev != generation or @prev.nil?
      @sum = generation.map { |i| i.fitness }.sum
      @adv = generation.map { |i| i.fitness / @sum }
      @sum == 0.0 ? @sum = generation.size : nil
      @prev = generation
    end
    
    fi = individual.fitness / @sum
    fg = @adv.average
    sd = @adv.std_dev
    
    1 + ((fi - fg) / (2 * sd))
  end
  
  
end