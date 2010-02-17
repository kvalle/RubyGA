class IntPermutationGenotype < Genotype
  
  def random!
    num_genes   = $settings.get('genotype.genes')
    @genome = (0..num_genes-1).map { |i| i }
    @genome.shuffle!
  end
  
  def mutate!
    @genome.each_with_index do |c,index|
      next if rand < @mutation_rate
      other_index = @genome.random_other_index(index)
      @genome.swap!(index, other_index)
    end
  end
  
  def crossover(other)
    raise NotImplementedError
  end
  
end