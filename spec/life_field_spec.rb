require 'rspec'
require File.join( File.dirname( __FILE__ ), '..', 'lib', 'life_field.rb' )



describe "a LifeField object" do
  field = nil   # a global instance of a field to run our tests on.
  test_width = 10
  test_height = 10
  test_num_cells = 33
 
  before(:each) do
    field = LifeField.new( test_width, test_height )
  end

  it "should initialize a field object given a width and height" do
    expect( field ).to be_instance_of( LifeField )
    expect( field.width ).to eq( test_width )
    expect( field.height ).to eq( test_height )
  end # it "should initialize an object given a field width and height"

  it "should initialize an empty field object of a given a width and height" do
    expect( field.data ).to be_instance_of( BitArray )
    expect( field.data ).to be_empty
  end # it "should initialize an object given a field width and height"


  describe "the LifeField::randomize method" do

    it "should generate a random placement of 'cells' in the field" do
      another_field = LifeField.new( test_width, test_height )    # an extra instance of a field to run our tests against.

      field.randomize( test_num_cells )
      another_field.randomize( test_num_cells )

      #expect( field.data ).not_to match( another_field.data ) # breaks with a SystemStackError error ("stack level too deep").
      field.data.each_index do |index|
        expect( field.data[ index ] ).to eq( another_field.data[ index ] )
      end

    end # it "should initialize an object given a field width and height"

  end # describe "the LifeField::randomize method"


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
