class Plot
  
  def save
    @plotter.save
  end
  
  def plot
    raise NotImplementedError
  end
  
end