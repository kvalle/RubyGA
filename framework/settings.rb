class Settings
  attr_reader :input_task
  
  # Load settings based on task and 
  # freeze them to prevent changes during runtime
  def initialize(task)
    @input_task = task.freeze
    begin
      @general = YAML.load_file('settings/general.yml').freeze
      @task    = YAML.load_file('settings/' + task + '.yml').freeze
    rescue
      raise "No such domain: '" + task + "'. Settings file needed."
    end 
  end
  
  # Get a setting value on the form "plot.save"
  def get(setting)
    parts = setting.split('.')
    return traverse(@task, parts)    if has_setting?(@task, parts)
    return traverse(@general, parts) if has_setting?(@general, parts)
    raise Exception, "Setting does not exist: " + setting
  end
  
  
  # Methods for loading classes based on settings
  
  def genotype_class;
    get_class('classes.genotype')
  end
  
  def phenotype_class
    get_class('classes.phenotype')
  end
  
  def developer_class
    get_class('classes.developer')
  end
  
  def environment_class
    get_class('classes.environment')
  end
  
  def selection_mechanism_class(mode)
    get_class(mode + '.selection_mechanism')
  end
  
  
  # Getting plotter class names
  def plotter_classes
    get('plot.plotter').map { |c| eval(c.capitalize + 'Plot') }
  end
  
  # Plot classes file paths (array)
  def plotter_class_paths
    get('plot.plotter').map { |c| 'plot/' + c }
  end
  
  
  # Get path to class file from setting
  def class_path(setting)
    setting.split('.').last + '/' + $settings.get(setting).to_s
  end
  
  
  private
  
  # Get class name from setting
  def get_class(type)
    eval(camel_case(self.get(type)) + camel_case(type.split('.').last))
  end
  
  # Create correct camel case class name from setting
  def camel_case(string)
    string.split('_').map { |s| s.capitalize }.join('')
  end
  
  # Check if task or general settings file has
  # a specific setting
  def has_setting?(settings, parts)
    begin
      traverse(settings,parts) != nil
    rescue
      false
    end
  end
  
  # Find a specific setting in settings array
  def traverse(settings, parts)
    parts.each { |p| settings = settings[p] }
    settings
  end
    
end