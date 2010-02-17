class Developer
  
  def self.develop(genotype)
    phenotype = $settings.phenotype_class.new
    phenotype.phenome = $settings.developer_class.convert(genotype.genome)
    phenotype
  end
  
  # Convert genome to phenome
  def self.convert(genome)
    raise NotImplementedError
  end
  
end