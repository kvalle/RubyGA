require 'selection_mechanism/roulette_wheel'

class BoltzmannSelectionMechanism < RouletteWheelSelectionMechanism
  
  def exp_val(individual, generation)
    t = $settings.get(@mode + '.boltzmann.temprature')
    fi = individual.fitness
    
    fitness_exponential(fi, t) / average_fitness_exponential(generation, t)
  end
  
  
  private
  
  def fitness_exponential(fi, t)
    Math.exp(fi/t)
  end
  
  def average_fitness_exponential(generation, t)
    generation.inject(0) { |sum,i| sum += fitness_exponential(i.fitness, t) } / generation.size
  end
  
end