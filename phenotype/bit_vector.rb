class BitVectorPhenotype < Phenotype
  
  def phenome=(val)
    @bitvector = val
  end
  
  def phenome
    @bitvector
  end
  
  def to_s
    @bitvector
  end
    
end