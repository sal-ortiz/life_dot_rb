require File.join( File.dirname( __FILE__ ), 'bit_array.rb' )
require File.join( File.dirname( __FILE__ ), 'field_helper.rb' )




class Field < BitArray

  include FieldHelper

  public
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
        val_range.to_a[ rand * val_range.to_a.length ]
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

        #TODO: we should compensate for wrapping and stuff!

        if callback.call( self[index] ) == true then
          count += 1
        end
      end

      return count
    end


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

