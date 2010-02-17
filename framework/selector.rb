class Selector
  
  def initialize
    @adult_mechanism  = $settings.selection_mechanism_class('adult').new('adult')
    @parent_mechanism = $settings.selection_mechanism_class('parent').new('parent')
    @replacement      = $settings.get('adult.generational_replacement')
    @elitism          = $settings.get('adult.elitism')
    @population_size  = $settings.get('simulator.population_size')
  end
  
  # Select new adult population
  def select_adults(individuals)
    individuals = Individual.sorted(individuals) # Sort based on fitness
    survivours  = []
    
    # Elites experience eternal youth
    survivours  += individuals.select { |i| i.adult }.first(@elitism)
    individuals -= survivours
    
    # Filter out old generation if settings say so
    individuals = individuals.select { |i| not i.adult } if @replacement
    
    # Find new adults and return survivours
    if @population_size - survivours.size < individuals.size
      survivours += @adult_mechanism.select(individuals, @population_size)
    else
      survivours += individuals
    end
    
    survivours.each { |i| i.grow }
  end
  
  # Select two parents from pool of adults
  def select_parents(individuals)
    @parent_mechanism.select( individuals.select { |i| i.fitness && i.adult }, 2)
  end
  
end