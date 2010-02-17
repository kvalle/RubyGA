class FloatVectorPhenotype < Phenotype
  
  def phenome
    @floatvector
  end
  
  def phenome=(val)
    @floatvector = val
  end
  
  def entropy
    s = @floatvector.map { |b| b > 0 ? b * Math.logn(b,2) : 0.0 }.sum
    s == 0 ? s : -s
  end  
  
  def to_s
    @floatvector.map { |e| e.round_to(2) }.join(' ')
  end
  
end