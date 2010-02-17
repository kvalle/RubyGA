class Plotter
  
  def initialize(name)
    # Do not plot if plotting library missing
    return unless defined?(Scruffy) 
    
    @name  = name
    @graph = Scruffy::Graph.new(
      :theme => Scruffy::Themes::Base.new({
        :background => '#ffffff',
        :colors => ['red', 'blue', 'green', 'pink', 'purple'],
        :marker => '#000000',
        :font_family => 'Helvetica'
      })
    )
    @graph.renderer = Scruffy::Renderers::Standard.new    
    @tags = {}
  end
  
  def point(tag, value)
    @tags.has_key?(tag) ? @tags[tag] << value : @tags[tag] = [value]
  end
  
  def plot(tag, style = :line)
    name = tag.gsub('_',' ').capitalize
    @graph.add(style, name, @tags[tag])
  end
  
  # Render and save final graph
  def save
    return unless defined?(Scruffy)
    return unless @tags.size > 0
    
    x = x_axis_limit
    m = x / 10
    m == 0 ? m = 1 : nil
    
    @graph.point_markers = (1..x).to_a.select { |i| i % m == 0 }
    @graph.value_formatter = Scruffy::Formatters::Number.new(:precision => 2)
    @tags.each_key { |tag| plot(tag) } 
    
    ymax = $settings.get('plot.ymax')
    if (ymax && ymax < y_axis_limit) or not ymax
      ymax = y_axis_limit
    end
    
    @graph.render(
      :min_value => 0,
      :max_value => ymax,
      :width => 600, 
      :to => "output/#{$settings.input_task}_#{@name}.svg"
    )
  end
  
  
  private
  
  def x_axis_limit
    max = []
    @tags.each_value do |points|
      max << points.size
    end
    max.sort.last
  end
  
  def y_axis_limit
    max = []
    @tags.each_value do |points|
      max << points.max
    end
    max.sort.last
  end
  
end