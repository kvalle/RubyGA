class EntropyPlot < Plot
    
  def initialize
    @plotter = Plotter.new('entropy')
  end
  
  def plot(population)
    @plotter.point('best_entropy', population.best.phenotype.entropy)
    @plotter.point('worst_entropy', population.worst.phenotype.entropy)
    @plotter.point('average_entropy', population.all.map { |i| i.phenotype.entropy }.average)
  end
  
end