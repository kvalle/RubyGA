class EvoSim
  attr_reader :population
  
  def initialize
    @population = Population.new
    @plotters   = $settings.plotter_classes.map { |c| c.new }
    @max_generations = $settings.get('simulator.max_generations')
    @threshold       = $settings.get('simulator.fitness_cutoff_threshold')
    @print_process   = $settings.get('print.process')
    @print_progress  = $settings.get('print.progress')
    @print_genes     = $settings.get('print.debug')
    @print_genes     = $settings.get('print.genes')
    @save_plot       = $settings.get('plot.save')
  end
  
  # Run the simulator based on the settings files and 
  # print the best individual. The loop runs until the 
  # fitness cutoff threshold or the maximum number of 
  # generations is reached.
  def run
    # Run simulator
    while @population.generation <= @max_generations
      run_generation ? next : break
    end
    
    # Let us know if we exhausted number of generations
    if @population.generation >= @max_generations
      puts "\nReached max number of generations (#{@max_generations})!" 
    end
    
    # Render and save the final plot
    @plotters.each { |p| p.save } if @save_plot 
    
    print_best_individual
    @population.best
  end
  
  
  private
  
  # Evolve one generation
  # Returns true if another generation should 
  # be run, false if fitness threshold is reached.
  def run_generation
    puts "Evolving generation #{@population.generation}" if @print_process
    
    # Set fitness value for all individuals
    puts "* Testing fitness" if @print_debug
    @population.test_fitness
    
    # Print current population best      
    puts "* Best gene: #{@population.best.genotype}" if @print_process
    puts "* Best fitness: #{@population.best.fitness.round_to(2)}" if @print_process
    
    # Adult selection
    puts "* Selecting new adults" if @print_debug
    @population.select_adults
    
    # Add current population stats to plot
    @plotters.each { |p| p.plot(@population) }
    
    # Print the current adult genes
    @population.print_adult_genes if @print_genes
    
    # Print progress bar
    puts "#{(100.0 * @population.generation.to_f / @max_generations.to_f).round_to(1)} %" if @print_progress
    
    # Break if fitness cutoff treshold reached
    if @threshold > 0 && @population.best.fitness >= @threshold
      puts "\nFitness threshold reached at #{@threshold} in generation #{@population.generation}"
      return false
    end
    
    # Reproduce
    puts "* Breeding" if @print_debug
    @population.breed
    
    # Print newline
    puts if @print_process
    true
  end
  
  def print_best_individual
    puts
    puts "Best individual:"
    puts "----------------"
    puts @population.best
  end
    
end
