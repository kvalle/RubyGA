class BlottoEnvironment < Environment
  
  def initialize
    @reployment_fraction = $settings.get('blotto.reployment_fraction')
    @loss_fraction       = $settings.get('blotto.loss_fraction')
    @battles             = $settings.get('blotto.battles')
  end
  
  def test_fitness(individuals)
    individuals.each do |i|
      test_individual(i, individuals)
    end
  end
  
  
  private
  
  def test_individual(current, individuals)
    wins = ties = 0
    
    # Fight all other individuals
    individuals.each do |enemy|
      next if current == enemy # don't fight self
      
      strategy         = current.phenotype.phenome.dup
      enemy_strategy   = enemy.phenotype.phenome.dup
      battles_won      = battles_lost   = 0
      current_strength = enemy_strength = 1.0
      
      # Run each battle
      strategy.each_with_index do |s,i|
        # Calculate battle result, with force strengths
        diff = (strategy[i] * current_strength) - (enemy_strategy[i] * enemy_strength)
        
        # won battle
        if diff > 0.0
          battles_won += 1
          reploy!(strategy, diff, @battles - i)
          enemy_strength -= @loss_fraction
        
        # lost battle
        elsif diff < 0.0
          battles_lost += 1
          reploy!(enemy_strategy, -diff, @battles - i)
          current_strength -= @loss_fraction
        end
      end
      
      # Record war result
      wins += 1 if battles_won > battles_lost
      ties += 1 if battles_won == battles_lost
    end
    
    current.fitness = (2 * wins) + ties
    current.fitness /= ((individuals.size - 1) * 2)
  end
  
  # Retaining of forces across battles
  def reploy!(strategy, diff, num_remaining_battles)
    # how many troops reployed to each succeeding battle
    reployment = (diff * @reployment_fraction) / num_remaining_battles
    strategy.map! { |s| s + reployment }
  end
  
end