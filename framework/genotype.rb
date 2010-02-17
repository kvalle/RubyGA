class Genotype
  
  def initialize
    @mutation_rate  = $settings.get('breeding.mutation_rate')
    @crossover_rate = $settings.get('breeding.mutation_rate')
    random!
  end
  
  # Mutate and crossover two genotypes, and return two new genotypes
  # (We actually create two copies of the parents genotypes 
  # as children, and then mutate and crossover these two.)  
  def self.combine(g1, g2)
    # Create new genotypes
    n1 = self.new
    n2 = self.new
    n1.genome = g1.genome.dup
    n2.genome = g2.genome.dup
    
    # Mutate and crossover new genotypes
    n1.mutate!
    n2.mutate!
    n1.crossover(n2)
  end
  
  def genome
    @genome
  end
  
  def genome=(val)
    @genome = val
  end
    
  def to_s
    @genome.join('')
  end
  
  def random!
    raise NotImplementedError
  end
  
  def mutate!
    raise NotImplementedError
  end
  
  def crossover(other)
    raise NotImplementedError
  end
  
end