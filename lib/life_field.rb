require File.join( File.dirname( __FILE__), 'bit_array.rb' )

class LifeField


  BIT_WIDTH = 2 

  attr_reader :width
  attr_reader :height
  #attr_reader :data

  def data
    return @data.data
  end

  def initialize( field_width, field_height )
	  @data = BitArray.new( (field_width * field_height), BIT_WIDTH )

    @width = field_width
    @height = field_height
  end


  def getCell( xPos, yPos )
    index = ( yPos * @width ) + xPos
    return @data[ index ]
  end

  def setCell( xPos, yPos, val )
    index = ( yPos * @width ) + xPos
    return @data[ index ] = val
  end


  def randomize( num_cells )
    # num cells should be less than the total number of spaces (width*height)!

    srand
    until num_cells.zero? do
      current_index = ( (rand*@width) * (rand*@height) ).to_i

      if @data[current_index].zero? then
        @data[current_index] = 1
        num_cells -= 1
      end
    end
  end

  def neighbors( field_index )
    # TODO: Besides cleaning up your ruby code...this algorithm might be broken, fix it.
    retval = Array.new 

    [8,7,6,5,3,2,1,0].each do |loop_val|
      current_field_index = ( ((((field_index / @width) + ((loop_val/3)-1)) % @height) * @width) + (((field_index % @width)+((loop_val % 3)-1)) % @width) )
      # NOTE: FOR AN "INFINITE" FIELD: this code binds our field vertically ^^^^^^^^^             ...and this code binds our field horizontally ^^^^^^^^
      if (1..2).include?(@data[current_field_index]) then retval.push(current_field_index) end
    end

    return retval
  end

end # class LifeField

