class RouletteWheelSelectionMechanism < SelectionMechanism
  
  def select(individuals, number)
    selected = []
    number.times do
      chosen = spin_wheel(individuals)
      selected << chosen
      individuals.delete(chosen)
    end
    selected
  end
  
  def spin_wheel(individuals)
    exp   = individuals.map { |i| exp_val(i, individuals) }
    wheel = exp.normalize!
    
    a = 0.0
    r = rand
    wheel.each_with_index do |val,i|
      a += val
      return individuals[i] if a >= r
    end
    
    return individuals.last
  end
  
  def exp_val(i, individuals)
    raise NotImplementedError
  end
  
end