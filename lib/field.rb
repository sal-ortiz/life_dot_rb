require File.join( File.dirname( __FILE__ ), 'bit_array.rb' )
require File.join( File.dirname( __FILE__ ), 'field_helper.rb' )




class Field < BitArray

  include FieldHelper

  BIT_WIDTH = 2 

  attr_reader :width
  attr_reader :height


  def initialize( field_width, field_height )
    @width = field_width
    @height = field_height

    super( (field_width * field_height), BIT_WIDTH )
  end

  def inspect
    output = String.new
    ( self.to_a ).each_index do |index|
      output = output + "\n" if ( index % width ).zero? && !index.zero?
      output = output + self[index].to_s
    end
    return output
  end

  def cell( x_pos, y_pos, new_val=nil )
    if( new_val ) then
      return set_cell( x_pos, y_pos, new_val )
    else
      return get_cell( x_pos, y_pos )
    end
  end


  def area
    return height * width
  end


  def randomize( val_range )
    # num cells should be less than the total number of spaces (width*height)!
    srand
    self.fill do |index|
      val_range.to_a[ rand*val_range.to_a.length ]
    end
  end


  def cell_count( left_coord=0, top_coord=0, right_coord=width, bot_coord=height, &block )

    if block_given? then
      callback = block
    else
      callback = Proc.new { |cell|    return !!cell   }
    end

    count = 0
    block_width = right_coord - left_coord
    block_height = bot_coord - top_coord

    ( block_width*block_height ).times do |loop_val|
      index = FieldHelper.coord_to_index( left_coord, top_coord, width, height )  # start with our upper-left index...
      index += (loop_val / block_width) * block_width                             # adjust for our vertical position...
      index += (loop_val % block_width)                                           # adjust for our horizontal position.

      if callback.call( self[index] ) == true then
        count += 1
      end
    end

    return count
  end

=begin
  def neighbors( center_x, center_y, wrap=true )
    retval = Array.new 
    field_index = ( center_y * width ) + center_x

    [8,7,6,5,3,2,1,0].each do |loop_val|  # we skip 4 because, given our algorithm, it will point us to our center cell.
  
      cell_pos_x = center_x + ( ( loop_val % 3) - 1 )    # our cell's x position, with a -1 to 1 modifier, adjusted for wraparound.
      cell_pos_y = center_y + ( ( loop_val / 3 ) - 1 )   # our cell's y position, with a -1 to 1 modifier, adjusted for wraparound.

      if( wrap ) then
        # adjust our coordinates for field wraparound...
        cell_pos_x %= width
        cell_pos_y %= height
      elsif FieldHelper.within_field?( cell_pos_x, cell_pos_y, width, height ) then
        # ...otherwise, keep our calculations to within our field.
        next
      end
      current_field_index = FieldHelper.coord_to_index( cell_pos_x, cell_pos_y, width, height )   # our coordinates converted to a single-dimensional array index.

      # if our calculated position points to a live cell, 
      # then we add it to our list of neighbors.
      if (1..2).include?( self[ current_field_index ] ) then
        retval.push( {  :x => cell_pos_x,
                        :y => cell_pos_y    } )
      end
    end

    return retval
  end
=end


  private
    def get_cell( x_pos, y_pos )
      index = ( y_pos * width ) + x_pos
      return self[ index ]
    end

    def set_cell( x_pos, y_pos, val )
      index = ( y_pos * width ) + x_pos
      return self[ index ] = val
    end


end # class Field

