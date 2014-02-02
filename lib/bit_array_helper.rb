module BitArrayHelper

  def self.num_bits( val )
    bit_width = 0
    until ( (2**bit_width) > val ) do
      bit_width += 1
    end

    return bit_width
  end

  def self.pack_array( data, bit_width )
    packed_data = 0
    data.each_index do |index|
      packed_data |= ( data[index] & ( (2**bit_width) - 1 ) ) << ( index * bit_width )
    end

    return packed_data
  end

  def self.unpack_array( data, len, bit_width )
    unpacked_data = Array.new   # init an empty array.
    len.times do |index|
      unpacked_data.push( ( data & ( ((2**bit_width)-1) << (index * bit_width) ) ) >> (index * bit_width) )
    end

    return unpacked_data
  end

end # module BitArrayHelper
