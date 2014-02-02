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

    def initialize( array_size = 0, bit_width = 1 )
      @bit_width = bit_width
      @data = 0
      @data_len = array_size
    end

    def []( index )
      return (index < @data_len) ? data[ index ] : nil
    end

    def []=( index, val )
      data_array = data
      data_array[index] = val.to_i

      @data = BitArrayHelper.pack_array( data_array, @bit_width )
      return val
    end
    alias :data= :[]=

    def fill( val )
      @data = ( Array.new( @data_len ) ).fill( val )
    end

    def width
      return @bit_width
    end

    def inspect
      return data.inspect
    end


  # ----------------------------------------------------------------
  # the following code is meant only to get BitArray to function exactly like Array without 
  #  actually rewriting, overriding, or extending the Ruby Array class.
  #  You should NOT call these members of BitArray directly.
  private

    def data
      return BitArrayHelper.unpack_array( @data, @data_len, @bit_width )
    end

    def method_missing(method, *args, &block)
      array_data = data
      if array_data.respond_to?( method.to_sym ) then
        return array_data.send( method.to_sym, *args )
      elsif self.send.respond_to?( method.to_sym )
        return self.send( method.to_sym, *args )
      else
        super
      end
    end

  # ----------------------------------------------------------------

end # class BitArray

