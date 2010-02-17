require 'genotype/int_permutation'

class PmxGenotype < IntPermutationGenotype
  
  def crossover(other)
    return [self, other] if rand > @crossover_rate
    
    # Cross genomes
    g1 = self.genome
    g2 = other.genome
    
    # part
    i1 = rand(g1.size/2)
    i2 = i1 + g1.size/2
    
    s1 = g1[i1..i2]
    s2 = g2[i1..i2]
    
    # swap
    g1[i1..i2] = s2
    g2[i1..i2] = s1
    
    # dup
    g1_dups = g1.dups
    g2_dups = g2.dups
    
    # map
    g1_dups.each do |d|
      i = g1.index(d)
      i = g1[i2..g1.size-1].index(d) + i2 if i >= i1 and i < i2
      r = s1[s2.index(d)]
      while g1.include?(r)
        r = s1[s2.index(r)]
      end
      g1[i] = r
    end

    g2_dups.each do |d|
      i = g2.index(d)
      i = g2[i2..g2.size-1].index(d) + i2 if i >= i1 and i < i2
      r = s2[s1.index(d)]
      while g2.include?(r)
        r = s2[s1.index(r)]
      end
      g2[i] = r
    end
    
    self.genome = g1
    other.genome = g2
    
    # Return new genotypes
    [self, other]
  end
  
end