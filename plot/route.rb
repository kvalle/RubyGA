class RoutePlot < Plot
  
  def initialize
  end
  
  def plot(population)
    @population = population
  end
  
  def save
    h = 500
    w = 500
    @drawer = Drawer.new(w+20,h+20)
    
    route = @population.best.phenotype.phenome.dup
    cities = @population.environment.cities.dup
    
    # normalize coords
    x_max = x_min = cities.first[0]
    y_max = y_min = cities.first[1]
    
    cities.each do |pos|
      x_max = pos[0] if pos[0] > x_max
      y_max = pos[1] if pos[1] > y_max
      x_min = pos[0] if pos[0] < x_min
      y_min = pos[1] if pos[1] < y_min
    end
    
    # Plot cities and route
    route.each_with_index do |city_index, route_index|
      current_i = route[route_index]
      next_i = route[(route_index+1) % route.size]
      
      #puts "#{current_i} => #{next_i}"
      
      pos = cities[current_i]
      
      x = (pos[0] - x_min) * h / (x_max - x_min)
      y = (pos[1] - y_min) * w / (y_max - y_min)
      
      x = h-x+10
      y = w-y+10
      @drawer.point(y,x)
      
      pos2 = cities[next_i]
      
      x2 = (pos2[0] - x_min) * h / (x_max - x_min)
      y2 = (pos2[1] - y_min) * w / (y_max - y_min)
      x2 = h-x2+10
      y2 = w-y2+10
      
      @drawer.line(y, x, y2, x2)
    end
    
    @drawer.save('output/tsp.png')
  end
  
  def plot_point(pos)
    x = (pos[0] - x_min) * h / (x_max - x_min)
    y = (pos[1] - y_min) * w / (y_max - y_min)
    
    x = h-x+10
    y = w-y+10
    @drawer.point(y,x)
    
    [x,y]
  end
  
end