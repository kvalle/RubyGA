class Population
  attr_reader :generation, :environment
  
  def initialize
    @generation    = 1
    @selector      = Selector.new
    @environment   = $settings.environment_class.new
    
    # populate 
    @individuals = Array.new($settings.get('simulator.population_size')).map do 
      Individual.new(@generation)
    end
  end
  
  # All individuals in population
  def all
    @individuals
  end
  
  # All youngsters in population
  def youngsters
    all.select { |i| not i.adult }
  end
  
  # All adults in population
  def adults
    all.select { |i| i.adult }
  end
  
  # All individuals who have a fitness value
  def all_with_fitness
    all.select { |i| i.fitness }
  end
  
  # The best individual based on fitness
  def best
    sorted.first
  end

  # The worst individual based on fitness
  def worst
    sorted.last
  end
  
  # Sorted list of individuals based on fitness
  # Only use individuals where fitness is set
  def sorted
    Individual.sorted(all_with_fitness)
  end
  
  # Move on to next generation
  def inc_generation
    @generation += 1
  end
  
  # Test fitness of all individuals
  def test_fitness
    @individuals = @environment.test_fitness(@individuals)
  end
  
  # Select new adults from youngsters pool
  def select_adults
    @individuals = @selector.select_adults(@individuals)
  end
  
  # Breed adults to create new youngsters
  def breed
    inc_generation
    
    # Decide how many individuals to create
    limit = $settings.get('simulator.population_size') + $settings.get('breeding.limit')
    
    # Breed until population is full
    while @individuals.length < limit
      mates = @selector.select_parents(@individuals)
      @individuals += Individual.mate(@generation, mates[0], mates[1])
    end
  end
  
  # Print genes of adults in population
  def print_adult_genes
    adults.each { |i| puts i.genotype_string }
  end
   
end