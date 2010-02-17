class BlottoDeveloper < Developer
    
  def self.convert(genome)
    int_array = Bit.bit_array_to_dec_array(genome, $settings.get('genotype.length'))
    int_array.normalize!
  end
  
end