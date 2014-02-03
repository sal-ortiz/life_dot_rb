require File.join( File.dirname( __FILE__ ), 'bit_array.rb' )
require File.join( File.dirname( __FILE__ ), 'life_field_helper.rb' )




class LifeField


  BIT_WIDTH = 2 

  attr_reader :width
  attr_reader :height

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

  def neighbors( center_x, center_y, wrap=true )
    retval = Array.new 
    field_index = ( center_y * @width ) + center_x

    [8,7,6,5,3,2,1,0].each do |loop_val|  # we skip 4 because, given our algorithm, it will point us to our center cell.
  
      cell_pos_x = center_x + ( ( loop_val % 3) - 1 )    # our cell's x position, with a -1 to 1 modifier, adjusted for wraparound.
      cell_pos_y = center_y + ( ( loop_val / 3 ) - 1 )   # our cell's y position, with a -1 to 1 modifier, adjusted for wraparound.

      if( wrap ) then
        # adjust our coordinates for field wraparound...
        cell_pos_x %= @width
        cell_pos_y %= @height
      elsif LifeFieldHelper.withing_field?( cell_pos_x, cell_pos_y, @width, @height ) then
        # ...otherwise, keep our calculations to within our field.
        next
      end
      current_field_index = LifeFieldHelper.coord_to_index( cell_pos_x, cell_pos_y, @width, @height )   # our coordinates converted to a single-dimensional array index.

      # if our calculated position points to a live cell, 
      # then we add it to our list of neighbors.
      if (1..2).include?( @data[ current_field_index ] ) then
        retval.push( {  :x => cell_pos_x,
                        :y => cell_pos_y    } )
      end
    end

    return retval
  end

end # class LifeField

