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
  

  def initialize(array_size = 0, bit_width = 1)
    @bit_width = bit_width
    @data_ = 0
    @data_len = array_size
  end

  def [](index)
    if (index >= @data_len) then
      return nil
    end

    return ( @data_ & ( ((2 ** @bit_width)-1) << (index * @bit_width) ) ) >> (index * @bit_width)
  end

  def []=(index,data)

    # TODO: What if some bastard wants to toss in an Array of Strings!?!!
    case data.class.to_s # allow us to handle various types for data
      when "Fixnum", "BigNum"
        data_array = ( Array.new ).push(data)
      when "String"
        data_array = Array.new
        data.reverse.unpack('B*').each do |loop_val| data_array.push(loop_val) end
    end # no need for an else here...

    @data_len = (index+1) if (index > @data_len)
    data_array.each do |loop_val|
      @data_ = ( (loop_val & ((2 ** @bit_width)-1)) << (index * @bit_width) ) | (@data_ & ~( ((2 ** @bit_width)-1) << (index * @bit_width) ))
      @data_len = @data_len + 1
    end
  end

  def fill( fill_value )
    # TODO: Why does the follwoing line of code hang the program?!?!
    #@data_len.times do |index|  puts "#{ index }";  self[index] = value end
  end

  def width
    return @bit_width
  end

  # ----------------------------------------------------------------
  # the following code is meant only to get BitArray to function exactly like Array without 
  #  actually rewriting, overriding, or extending the Ruby Array class.
  #  You should NOT call these members of BitArray directly.
    private

    def _data
      retval = Array.new
      @data_len.times do |loop_val| retval.push(self[loop_val]) end
      return retval
    end
    alias :_data= :[]=

    def method_missing(method, *args, &block)
      if _data.respond_to?( method ) then
        _data.send(method, *args)
        _data.each_index do |loop_val|  self[loop_val] = _data[loop_val] end
      else
        self.send(method, *args)
      end
    end

    def inspect
      return _data.inspect
    end

    def length
      return _data.length
    end


  # ----------------------------------------------------------------

end # class BitArray

