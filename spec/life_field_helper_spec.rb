
require File.join( File.dirname( __FILE__ ), '.', 'lib', 'spec_helper.rb' )         # our spec helper.
require File.join( File.dirname( __FILE__ ), '..', 'lib', 'life_field_helper.rb' )  # our source code to be tested.


describe "the LifeFieldHelper module" do


  describe "the LifeFieldHelper::coord_to_index method" do

    it "should have an optional fourth parameter" do
      test_x_pos = ( DEFAULT_WIDTH / 2 )
      test_y_pos = ( DEFAULT_HEIGHT / 2 )

      expect { LifeFieldHelper.coord_to_index( test_x_pos, test_y_pos, DEFAULT_WIDTH ) }.not_to raise_error

      actual_val = LifeFieldHelper.coord_to_index( test_x_pos, test_y_pos, DEFAULT_WIDTH )
      expected_val = LifeFieldHelper.coord_to_index( test_x_pos, test_y_pos, DEFAULT_WIDTH, DEFAULT_HEIGHT )
      expect( actual_val ).to eq( expected_val )
    end

    it "should accurately converty x and y coordinates to linear indexes" do
      horz_range = ( 0..(DEFAULT_WIDTH-1) )
      vert_range = ( 0..(DEFAULT_HEIGHT-1) )
      expected_val = 0

      vert_range.each do |y_pos|
        horz_range.each do |x_pos|
          expect( LifeFieldHelper.coord_to_index( x_pos, y_pos, DEFAULT_WIDTH, DEFAULT_HEIGHT ) ).to eq( expected_val )
          expected_val += 1
        end
      end
    end # it "should accurately converty x and y coordinates to linear indexes"

  end # describe "the LifeFieldHelper::coord_to_index method"

  describe "the LifeFieldHelper::within_field? method" do

    it "should correctly gauge whether a set of coordinates are within a field, given a width and height" do
      horz_range = ( 0..(DEFAULT_WIDTH-1) )
      vert_range = ( 0..(DEFAULT_HEIGHT-1) )

      horz_range.each do |x_pos|
        vert_range.each do |y_pos|
          expect( LifeFieldHelper.within_field?( x_pos, y_pos, DEFAULT_WIDTH, DEFAULT_HEIGHT ) ).to be_true
        end
      end

      # just to be sure, any overly verbose, let's test a few that we know are out of range.
      expect( LifeFieldHelper.within_field?( (horz_range.first - 1), (vert_range.first - 1), DEFAULT_WIDTH, DEFAULT_HEIGHT ) ).to be_false
      expect( LifeFieldHelper.within_field?( (horz_range.first - 1), vert_range.first, DEFAULT_WIDTH, DEFAULT_HEIGHT ) ).to be_false
      expect( LifeFieldHelper.within_field?( (horz_range.first - 1), vert_range.last, DEFAULT_WIDTH, DEFAULT_HEIGHT ) ).to be_false
      expect( LifeFieldHelper.within_field?( (horz_range.first - 1), (vert_range.last + 1), DEFAULT_WIDTH, DEFAULT_HEIGHT ) ).to be_false

      expect( LifeFieldHelper.within_field?( horz_range.first, (vert_range.first - 1), DEFAULT_WIDTH, DEFAULT_HEIGHT ) ).to be_false
      #expect( LifeFieldHelper.within_field?( horz_range.first, vert_range.first, DEFAULT_WIDTH, DEFAULT_HEIGHT ) ).to be_true  # redundant
      #expect( LifeFieldHelper.within_field?( horz_range.first, vert_range.last, DEFAULT_WIDTH, DEFAULT_HEIGHT ) ).to be_true   # redundant
      expect( LifeFieldHelper.within_field?( horz_range.first, (vert_range.last + 1), DEFAULT_WIDTH, DEFAULT_HEIGHT ) ).to be_false

      expect( LifeFieldHelper.within_field?( horz_range.last, (vert_range.first - 1), DEFAULT_WIDTH, DEFAULT_HEIGHT ) ).to be_false
      #expect( LifeFieldHelper.within_field?( horz_range.last, vert_range.first, DEFAULT_WIDTH, DEFAULT_HEIGHT ) ).to be_true   # redundant
      #expect( LifeFieldHelper.within_field?( horz_range.last, vert_range.last, DEFAULT_WIDTH, DEFAULT_HEIGHT ) ).to be_true    # redundant
      expect( LifeFieldHelper.within_field?( horz_range.last, (vert_range.last + 1), DEFAULT_WIDTH, DEFAULT_HEIGHT ) ).to be_false

      expect( LifeFieldHelper.within_field?( (horz_range.last + 1), (vert_range.first - 1), DEFAULT_WIDTH, DEFAULT_HEIGHT ) ).to be_false
      expect( LifeFieldHelper.within_field?( (horz_range.last + 1), vert_range.first, DEFAULT_WIDTH, DEFAULT_HEIGHT ) ).to be_false
      expect( LifeFieldHelper.within_field?( (horz_range.last + 1), vert_range.last, DEFAULT_WIDTH, DEFAULT_HEIGHT ) ).to be_false
      expect( LifeFieldHelper.within_field?( (horz_range.last + 1), (vert_range.last + 1), DEFAULT_WIDTH, DEFAULT_HEIGHT ) ).to be_false
    end

  end # describe "the LifeFieldHelper::coord_to_index method"


end # describe "the LifeFieldHelper module"
