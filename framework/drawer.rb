class Drawer
  
  def initialize(width=500, height=500)
    @points = []
    @lines  = []
    return unless defined?(Magick)
    
    @canvas = Magick::Image.new(width, height)
    @draw   = Magick::Draw.new
  end
  
  def point(x, y)
    @points << [x,y]
  end
  
  def line(x1, y1, x2, y2)
    @lines << [[x1,y1], [x2,y2]]
  end
  
  def save(target)
    return unless defined?(Magick)
    plot
    @draw.draw(@canvas)
    @canvas.write(target)
  end
  
  
  private
  
  def plot
    plot_points
    plot_lines
  end
  
  def plot_points
    @draw.fill('red')
    @points.each do |p|
      @draw.circle(p[0], p[1], p[0]+2, p[1]+2)
    end
  end
  
  def plot_lines
    @draw.fill('black')
    @lines.each do |l|
      @draw.line(l[0][0], l[0][1], l[1][0], l[1][1])
    end
  end
  
end