require 'rspec'
require File.join( File.dirname( __FILE__ ), '..', 'lib', 'bit_array.rb' )

describe "a BitArray object" do
  it "should initialize an empty array object if no arguments are given" do
    the_object = BitArray.new

    expect( the_object ).to be_instance_of( BitArray )
    expect( the_object ).to be_empty
  end # it "should initialize an empty array object if no parameters are given"

  it "should initialize an array of a given amount of single bit values if only one argument is given" do
    expected_len = 6;
    expected_width = 1;
    the_object = BitArray.new( expected_len )

    expect( the_object ).to be_instance_of( BitArray )
    expect( the_object.size ).to eq( expected_len )
    expect( the_object.width ).to_eq( expected_width )
  end # it "should initialize an array of a given amount of single bit values if only one argument is given"

  it "should initialize an array of a given amount of values, with a give bit width bit if two arguments are given" do
    expected_len = 6;
    expected_width = 3;
    the_object = BitArray.new( expected_len, expected_width )

    expect( the_object ).to be_instance_of( BitArray )
    expect( the_object.size ).to eq( expected_len )
    expect( the_object.width ).to_eq( expected_width )
  end # it "should initialize an array of a given amount of values, each at a give bit width bit if two argument is given"

  it "should raise an error if more than two arguments are given" do
    expected_len = 6;
    expected_width = 3;
    extra_value = 0;

    expect{ BitArray.new( expected_len, expected_width, extra_value ) }.to raise_error( ArgumentError )
  end # it "should raise an error if more than two arguments are given"






end # describe "a BitArray object"
