#
# NOTES:
#   our board logic, in order to avoid using a second 'scratch' board for processing, goes as follows:
#   PRE-PROCESSED CELLS:
#     a '0' represents a cell that is currently 'alive.'
#     a '1' represents a cell that is currently 'dead.'
#   POST-PROCESSED CELLS:
#     a '0' represents a cell that is currently 'dead' and will remain 'dead' in the following cycle.
#     a '1' represents a cell that is currently 'alive' but will be 'dead' in the following cycle.
#     a '2' represents a cell that is currently 'dead' but will be 'alive' in the following cycle.
#     a '3' represents a cell that is currently 'alive' and will remain 'alive' in the following cycle.
#   this logic for the POST-PROCESSED CELLS allows us to 'normalize' the field by dividing each cell's value by 2 
#    to return to a PRE-PROCESSED CELL state for the next 'day,' or cycle.
#
# TODO: 
#   * how about getting instances of this to communicate with other instances of itself and act within a cluster (...and better yet, do it without needing a master node)
#

require File.join( File.dirname( __FILE__ ), 'lib', 'life_field.rb' )

class Life

  attr_reader :field
  attr_reader :field_width
  attr_reader :field_height

  def initialize( field_width, field_height )
    @field = LifeField.new( field_width, field_height )

    @field_width = field_width
    @field_height = field_height
  end
 
  # ====== randomize our field.
  def randomize( num_cells = (@field_width * @field_height)/2 )
    num_cells = (@field_width * @field_height) if (num_cells > @field_width * @field_height)
    @field.randomize( num_cells )
  end

  # ====== apply our 'game of life' logic.
  def process

    # OUR LOGIC: (http://en.wikipedia.org/wiki/Conway's_Game_of_Life)
    #   * Any live cell with fewer than two live neighbours dies, as if caused by under-population.
    #   * Any live cell with two or three live neighbours lives on to the next generation.
    #   * Any live cell with more than three live neighbours dies, as if by overcrowding.
    #   * Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

    # this is where the actual 'life' logic happens...
    ( field_width * field_height ).times do |loop_val|
      num_neighbors = field.neighbors(  LifeFieldHelper.index_to_coord(loop_val,field_width)[:x],
                                        LifeFieldHelper.index_to_coord(loop_val,field_width)[:y] ).length

      case num_neighbors
        when 2
          field.data[loop_val] = if ( field.data[loop_val] == 1 ) then 3 else 0 end
        when 3
          field.data[loop_val] = if ( field.data[loop_val] == 1 ) then 3 else 2 end
        #else # this else block is redundant...an added bonus of our board logic!
        #  field.data[loop_val] = if ( field.data[loop_val] == 1 ) then 1 else 0 end
      end
    end

  end

  # ====== normalize our data to show either 'alive' or 'dead'.  This is run after processing.
  def update
    # everything needs to be either 1 or 0 after processing so let's normalize our data.
    ( field_width * field_height ).times do |loop_val|
      field.data[loop_val] /= 2
    end

  end

end # class life


# ==================================================================


# ===== cheap and dirty data dump...
def draw_field(game_of_life_object)
  ( game_of_life_object.field_width * game_of_life_object.field_height ).times do |loop_val|
    print game_of_life_object.field.data[loop_val]
    print "\n" if ( (loop_val+1) % game_of_life_object.field_width ).zero? # end-of-line?
  end
end



# ===== what ever happened to main()?
game_of_life = Life.new(80,40)
game_of_life.randomize( ((80*40) * 0.70) )

current_day = 0
user_inp = String.new
while user_inp.chomp.empty? do
  puts "DAY: #{ current_day }:"
  draw_field(game_of_life)
  user_inp = gets

  game_of_life.process;
  game_of_life.update; 
  current_day += 1

end
