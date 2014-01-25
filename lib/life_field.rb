require File.join( File.dirname( __FILE__), 'bit_array.rb' )

class LifeField

  def initialize(field_width, field_height)
	  @data = BitArray.new( (field_width * field_height), 2 )

    @width = field_width
    @height = field_height

    # initialize an empty field.
    @data.fill(0)  # this may take a while for larger fields.

  end

  def data
    @data
  end

  def randomize(num_cells)
    srand

    until num_cells.zero? do
      current_index = rand( @width*@height )

      if @data[current_index].zero? then
        @data[current_index] = 1
        num_cells-=1
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

