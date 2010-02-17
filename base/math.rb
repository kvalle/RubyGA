module Math
  
  def self.logn(x, n)
    self.log(x) / self.log(n)
  end
  
  # Euclidean distance between two point in ND space.
  # Input arguments must be equal size arrays.
  def self.euclidean_distance(p1,p2)
    dist = 0.0
    p1.each_index do |i|
      dist += (p1[i] - p2[i]) ** 2
    end
    Math.sqrt(dist)
  end
  
end