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

require File.join( File.dirname( __FILE__ ), 'lib', 'field.rb' )

class Life

  attr_reader :field

  def initialize( field_width, field_height )
    @field = Field.new( field_width, field_height )
  end

 
  # ====== randomize our field.
  def randomize
    field.randomize( 0..1 )
  end

  # ====== apply our 'game of life' logic.
  def process

    # OUR LOGIC: (http://en.wikipedia.org/wiki/Conway's_Game_of_Life)
    #   * Any live cell with fewer than two live neighbours dies, as if caused by under-population.
    #   * Any live cell with two or three live neighbours lives on to the next generation.
    #   * Any live cell with more than three live neighbours dies, as if by overcrowding.
    #   * Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

    # this is where the actual 'life' logic happens...
    field.area.times do |loop_val|
      loop_val_coord = FieldHelper.index_to_coord(loop_val,field.width)
      num_neighbors = field.cell_count( loop_val_coord[:x]-1, loop_val_coord[:y]-1, loop_val_coord[:x]+1, loop_val_coord[:y]+1 ) do |val|
        [1,2].include?(val)
      end
      num_neighbors -= 1 unless field.cell( loop_val_coord[:x], loop_val_coord[:y] ).zero? || num_neighbors.zero?

      current_cell = field.cell( loop_val_coord[:x], loop_val_coord[:y] )
      new_cell_value = case num_neighbors
        when 2
          if current_cell == 1 then 3 else 0 end
        when 3
          if current_cell == 1 then 3 else 2 end
        #else # this else block is redundant...an added bonus of our board logic!
        #  if field.data[loop_val] == 1 then 1 else 0 end
      end
      field.cell( loop_val_coord[:x], loop_val_coord[:y], new_cell_value )

    end
  end

  # ====== normalize our data to show either 'alive' or 'dead'.  This is run after processing.
  def update
    # everything needs to be either 1 or 0 after processing so let's normalize our data.
    field.area.times do |loop_val|
      loop_val_coord = FieldHelper.index_to_coord(loop_val,field.width)
      old_value = field.cell( loop_val_coord[:x], loop_val_coord[:y] )
      field.cell( loop_val_coord[:x], loop_val_coord[:y], old_value/2 )
    end

  end

end # class life


# ==================================================================
game_of_life = Life.new(30,10)
game_of_life.randomize


current_day = 0
user_inp = String.new
while user_inp.chomp.empty? do
  puts "DAY: #{ current_day }:\n#{ game_of_life.field.inspect }\n\n"
  user_inp = gets

  game_of_life.process;
  game_of_life.update; 
  current_day += 1

end
