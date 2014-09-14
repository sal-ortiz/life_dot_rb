
module LifeFieldHelper

  def self.coord_to_index( x_coord, y_coord, width, height=nil )
    # height is optional because we don't actually need it.
    # it was included soley for semantics.
    return ( y_coord * width ) + x_coord
  end

  def self.index_to_coord( index, width, height=nil )
    return {
      :x => ( index % width ),
      :y => ( index / width )
    }
  end


  def self.within_field?( x_coord, y_coord, width, height )
    return ( 0...width ).include?( x_coord ) && ( 0...height ).include?( y_coord )
  end


end # module LifeFieldHelper
