class IntVectorPhenotype < Phenotype
  
  def phenome
    @intvector
  end
  
  def phenome=(val)
    @intvector = val
  end
  
  def to_s
    @intvector.join(' ')
  end
  
end