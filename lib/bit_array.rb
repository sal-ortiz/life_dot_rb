require File.join( File.dirname( __FILE__ ), 'bit_array_helper.rb' )


# Bitarray is meant to behave exactly like Array, but the data is stored in bit-delimited values.
#  it's intended to allow us to control the size of our data.  
#  For example, our game-of-life algorithm require only 2 bits per cell, 
#  rather than Ruby's 32~64bit FixNum value.
#
# when creating an object with BitArray.new, it takes the same params as Array.new but with an extra
# param at the end to designate our bit width.  If no value is given, the default width of 1 bit is used.
#
class BitArray

  public

    attr_reader :bit_width
    attr_reader :length
    attr_reader :data

    def initialize( array_size = 0, new_bit_width = 1 )
      @bit_width = new_bit_width
      @data = 0
      @length = array_size
    end

    def []( index )
      return get_value( index )
    end

    def []=( index, val )
      return set_value( index, val )
    end

    def fill( val=nil, &block )
      ary = if block_given? then
        index = 0
        ( Array.new(length) ).map do |val|
          index += 1 and val = block.call( index-1 )
        end
      else
        Array.new( length, val )
      end

      return set_array( ary )
    end

    def width
      return bit_width
    end

    def inspect
      return data.inspect
    end

    def to_a
      return BitArrayHelper.unpack_array( data, length, bit_width )
    end


    def method_missing( method, *args, &block )
      array_data = data
      if array_data.respond_to?( method.to_sym ) then
        return array_data.send( method.to_sym, *args )
      elsif self.respond_to?( method.to_sym )
        return self.send( method.to_sym, *args )
      elsif self.to_a.respond_to?( method.to_sym )
        return ( self.to_a ).send( method.to_sym, *args )
      #else
      #  return super.send( method.to_sym, *args )
      end
    end


  # ----------------------------------------------------------------
  private
    def set_array( ary )
      return @data = BitArrayHelper.pack_array( ary, bit_width )
    end

    def set_value( index, val )
      ary = self.to_a and  ary[ index ] = val
      self.set_array( ary )
      return val
    end

    def get_value( index )
      ary = self.to_a
      return (index < length) ? ary[ index ] : nil
    end

  # ----------------------------------------------------------------


  public

end # class BitArray

