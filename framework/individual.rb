class Individual
  attr_accessor :adult, :genotype, :phenotype, :generation
  
  # Initialize an individual. Use provided genotype,
  # or generate new (random) genotype if needed.
  def initialize(generation, genotype = false)
    @generation = generation
    @fitness    = false
    @adult      = false
    @genotype   = genotype ? genotype : $settings.genotype_class.new
    @phenotype  = $settings.developer_class.develop(@genotype)
  end
  
  # Sorting of individuals
  def self.sorted(individuals)
    individuals.sort { |a,b| b.fitness <=> a.fitness }
  end
  
  # Change individual from young to adult
  def grow
    @adult = true
  end
  
  # Change individual from adult to young
  def degrow
    @adult = false
  end
  
  def fitness
    @fitness
  end
  
  def fitness=(val)
    @fitness = val.to_f
  end
  
  # Create new individuals in given generation
  # through combination of parents genotypes
  def self.mate(generation, i1, i2)
    new_genotypes = $settings.genotype_class.combine(i1.genotype, i2.genotype)
    
    # Create the new individuals
    [Individual.new(generation, new_genotypes[0]),
     Individual.new(generation, new_genotypes[1])]
  end
  
  # String of generation and genotype
  def genotype_string
    # "g" + @generation.to_s + ": " + self.object_id.to_s + " (f: #{@fitness.round_to(4)})"
    "g" + @generation.to_s + ": " + @genotype.to_s
  end
  
  # String representation of an individual
  def to_s
    "Generation: #{@generation}\n" +\
    "Adult:      #{@adult}\n" +\
    "Fitness:    #{@fitness}\n" +\
    "Genotype:   #{@genotype.to_s}\n" +\
    "Phenotype:  #{@phenotype.to_s}\n"
  end
  
end