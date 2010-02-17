class Bit

  # Bit flip flop
  def self.flip(b)
    b ^ 1 # xor
  end
  
  # Crossover two arrays of bits
  def self.cross(g1,g2)   
    r = rand(g1.length-1) + 1 # Split bit array at random spot
    #r = g1.length/2 - 1 # Split bit array in the middle
    g1[0..r], g2[0..r] = g2[0..r], g1[0..r]
    [g1,g2]
  end
  
  # Convert binary number to decimal
  # takes in binary number in string form
  def self.bin_to_dec(binary_number)
    binary_number.to_s.to_i(2)
  end
  
  # Convert decimal to binary 
  # returns in string form to preserve leading 0's
  def self.dec_to_bin(decimal_number)
    decimal_number.to_s(2)
  end
  
  # Convert bit array to decimal array,
  # in bit groups of size n
  def self.bit_array_to_dec_array(array, n)
    i = 0
    p = []
    while array.size > i+3
      p << Bit.bin_to_dec(array[i..i+3])
      i += 4
    end
    p
  end
  
end
