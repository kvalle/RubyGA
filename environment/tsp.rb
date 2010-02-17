class TspEnvironment < Environment
  
  def city(i)
    cities[i]
  end
  
  def cities
    @cities ||= load(self.country).freeze
  end
  
  def test_fitness(individuals)
    individuals.each { |i| test_route(i) }
  end
  
  def country
    $settings.get('tsp.country')
  end
  
  
  private
  
  def load(country)
    print "Loading cities in #{country.capitalize}"
    f = File.open("input/#{country}.txt")
    cities = []
    f.each do |l|
      if l =~ /^[0-9]+ ([0-9|\.]+) ([0-9|\.]+)/  
        cities << [$1.to_f, $2.to_f]
        print '.'
      end
    end
    puts
    cities
  end
  
  def test_route(individual)
    route = individual.phenotype.phenome
    dist = 0.0
    
    (0..route.size-1).each do |i|
      current_pos = city(route[i])
      destination_pos = city(route[(i+1) % route.size])
      dist += Math.euclidean_distance(current_pos, destination_pos)
    end
    
    #individual.fitness = (1.0 / dist) * 100000
    individual.fitness = 1.0 / (dist ** (1.0/3.0))
  end
  
end