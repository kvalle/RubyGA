class BitVectorGenotype < Genotype
  
  def random!
    @@num_genes   ||= $settings.get('genotype.genes')
    @@gene_length ||= $settings.get('genotype.gene_length')
    
    @genome = Array.new(@@num_genes * @@gene_length).map { rand(2) }
  end
  
  def mutate!
    mutated = []
    
    @genome.each_slice($settings.get('genotype.gene_length')) do |gene|
      i = rand(gene.size)
      gene[i] = Bit.flip(gene[i]) if rand < @mutation_rate
      mutated += gene
    end
    
    @genome = mutated
  end
  
  def crossover(other)
    return [self, other] if rand > @crossover_rate
    
    # Cross genomes
    index = rand(@@num_genes) * @@gene_length 
    new_genomes = Array.crossover(self.genome, other.genome, index)
    
    self.genome  = new_genomes[0]
    other.genome = new_genomes[1]
    
    # Return new genotypes
    [self, other]
  end
  
end