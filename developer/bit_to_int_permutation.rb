class BitToIntPermutationDeveloper < Developer
    
  def self.convert(genome)
    num_genes   = $settings.get('genotype.genes')
    gene_length = $settings.get('genotype.gene_length')
    
    ints = (0..num_genes-1).map { |i| i }
    perm = []
    
    genome.each_slice(gene_length) do |g|
      index = g.join('').to_i(2) % ints.size
      perm << ints.delete_at(index)
    end
    
    if perm != perm.uniq
      puts perm.join(', ')
      puts perm.uniq.join(', ')
      raise Exception, "WTF" 
    end
    perm
    
  end
  
end