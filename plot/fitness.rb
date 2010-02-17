class FitnessPlot < Plot
  
  def initialize
    @plotter = Plotter.new('fitness')
  end
  
  def plot(population)
    @plotter.point('max_fitness', population.best.fitness)
    @plotter.point('average_fitness', population.all.map { |i| i.fitness }.average)
    @plotter.point('standard_deviation', population.all.map { |i| i.fitness }.std_dev)    
  end
  
end