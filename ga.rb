#!/usr/bin/env ruby

#
# Genetic Algorithm Framework
# 
# usage: $ ruby ga.rb taskname
# available tasks: onemax, blotto
# See also settings/general.yml and settings/task.yml.
#


# Libraries
require 'pp'
require 'yaml'
begin
  require 'rubygems' # Packaging [rubyforge.org/projects/rubygems]
  require 'scruffy'  # Drawing graphs [scruffy.rubyforge.org]
  require 'RMagick'  # Drawing images [rmagick.rubyforge.org]
rescue
end

# Basic type classes
require 'base/float'
require 'base/math'
require 'base/array'
require 'base/bit'

# GA Framework Classes
require 'framework/settings'
require 'framework/genotype'
require 'framework/phenotype'
require 'framework/developer'
require 'framework/individual'
require 'framework/population'
require 'framework/selector'
require 'framework/selection_mechanism'
require 'framework/environment'
require 'framework/plot'
require 'framework/plotter'
require 'framework/drawer'
require 'framework/evosim'


class GA
  attr_reader :simulator
  
  def initialize(task)
    $settings = Settings.new(task)
    
    # Task-specific classes
    require_class('classes.genotype')
    require_class('classes.phenotype')
    require_class('classes.developer')
    require_class('classes.environment')
    require_class('adult.selection_mechanism')
    require_class('parent.selection_mechanism')
    $settings.plotter_class_paths.each { |p| require p }
    
    @simulator = EvoSim.new
  end
  
  # Run simulator and return the best individual
  def run
    @simulator.run
    @simulator.population.best
  end
  
  def require_class(setting)
    require $settings.class_path(setting)
  end
  
end

# Select current task (or use command line)
# Tasks: onemax, blotto, tsp
task = 'tsp'

# Run task
ga = GA.new(ARGV[0] || task)
result = ga.run