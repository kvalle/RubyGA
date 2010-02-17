class OnemaxEnvironment < Environment
  
  def test_fitness(individuals)
    individuals.each { |i| i.fitness = test_individual(i) }
    individuals
  end
  
  def test_individual(i)
    i.fitness  = i.genotype.genome.inject(0) { |sum,b| sum += b }
    @@size   ||= $settings.get('genotype.genes') * $settings.get('genotype.gene_length')
    i.fitness /= @@size
  end
  
end
