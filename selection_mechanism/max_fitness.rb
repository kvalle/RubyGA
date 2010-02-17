class MaxFitnessSelectionMechanism < SelectionMechanism
  
  def select(individuals, number)
    Individual.sorted(individuals).first(number)
  end
  
end