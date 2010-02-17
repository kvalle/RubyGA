class SelectionMechanism
  
  def initialize(mode)
    @mode = mode
  end
  
  def select(individuals, number)
    raise NotImplementedError
  end
  
end