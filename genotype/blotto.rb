class BlottoGenotype < Genotype
  
  def random!
    @battles = $settings.get('blotto.battles')
    @genome = Array.new(@battles).map { rand }
    @genome.normalize!
  end
  
  def mutate!
    @genome.each_with_index do |g,i|
      if rand < @mutation_rate
        diff  = rand(g)
        other_index = @genome.random_other_index(i)
        
        @genome[i] -= diff
        @genome[other_index] += diff
      end
    end
    @genome.normalize!
  end
  
  def crossover(other)
    return [self, other] if rand > @crossover_rate
    
    r = rand(@battles)
    self.genome[0..r], other.genome[0..r] = \
      other.genome[0..r], self.genome[0..r]
    
    self.genome.normalize!
    other.genome.normalize!
    
    # Return new genotypes
    [self, other]
  end
  
  def to_s
    @genome.map { |e| e.round_to(2) }.join(' ')
  end
    
end