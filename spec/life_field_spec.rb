
require File.join( File.dirname( __FILE__ ), '.', 'lib', 'spec_helper.rb' )       # our spec helper.
require File.join( File.dirname( __FILE__ ), '..', 'lib', 'life_field.rb' )       # our source code to be tested.


describe "a LifeField object" do
  field = nil   # a global instance of a field to run our tests on.
  DEFAULT_WIDTH = 10
  DEFAULT_HEIGHT = 10
  DEFAULT_NUM_CELLS = (DEFAULT_WIDTH * DEFAULT_HEIGHT)  / 3


  before(:each) do

    field = LifeField.new( DEFAULT_WIDTH, DEFAULT_HEIGHT )
  end

  it "should initialize a field object given a width and height" do
    expect( field ).to be_instance_of( LifeField )
    expect( field.width ).to eq( DEFAULT_WIDTH )
    expect( field.height ).to eq( DEFAULT_HEIGHT )
  end # it "should initialize an object given a field width and height"

  it "should initialize an empty field data object of a given a width and height" do
    bad_values = [1, 2, 3]  # values in field.data for which our tests fail.

    expect( field.data ).to be_instance_of( Array )
    expect( field.data ).to_not be_empty
    expect( field.data ).not_to include( *bad_values )
  end # it "should initialize an object given a field width and height"
  


  describe "the LifeField::randomize method" do

    it "should place the exact given number of cells on the field" do
      field.randomize( DEFAULT_NUM_CELLS )
      cell_count = 0

      field.data.each_index do |index|
        cell_count += 1 unless field.data[ index ].zero?
      end

      expect( cell_count ).to eq( DEFAULT_NUM_CELLS )

    end # it "should place the exact given number of cells on the field"

    it "should generate a random placement of 'cells' in the field" do
      another_field = LifeField.new( DEFAULT_WIDTH, DEFAULT_HEIGHT )    # an extra instance of a field to run our tests against.
      field.randomize( DEFAULT_NUM_CELLS )
      another_field.randomize( DEFAULT_NUM_CELLS )

      is_unique = nil
      field.data.each_index do |index|
        is_unique = true and break if !is_unique && ( field.data[index] != another_field.data[index] )
      end

      expect( is_unique ).to be_true

    end # it "should initialize an object given a field width and height"

  end # describe "the LifeField::randomize method"


  describe "the LifeField::getCell and LifeField::setCell methods" do

    it "should 'deactivate' a cell when passed a 0" do
    end # it "should 'deactivate' a cell when passed a 0" do

    it "should 'deactivate' a cell when passed a 0" do
      width = DEFAULT_WIDTH / 2
      height = DEFAULT_HEIGHT / 2

      expect( field.getCell(width, height) ).to eq( 0 )
      expect( field.setCell(width, height, 1) ).to eq( 1 )
      expect( field.getCell(width, height) ).to eq( 1 )
    end # it "should 'deactivate' a cell when passed a 0" do

  end # describe "the LifeField::neighbors method"


  describe "the LifeField::neighbors method" do

    it "should correctly count a cell's neighbors in the middle of the field" do
    end # it "should correctly count a cell's neighbors in the middle of the field"


    it "should wrap horizontally across the field when counting a cell's neighbors at the left edge of the field" do
    end # it "should wrap horizontally across the field when counting a cell's neighbors at the left edge of the field"

    it "should wrap horizontally across the field when counting a cell's neighbors at the right edge of the field" do
    end # it "should wrap horizontally across the field when counting a cell's neighbors at the right edge of the field"


    it "should wrap vertically across the field when counting a cell's neighbors at the upper edge of the field" do
    end # it "should wrap vertically across the field when counting a cell's neighbors at the upper edge of the field"

    it "should wrap vertically across the field when counting a cell's neighbors at the lower edge of the field" do
    end # it "should wrap vertically across the field when counting a cell's neighbors at the lower edge of the field"

  end # describe "the LifeField::neighbors method"


end # describe "a LifeField object"
