
require File.join( File.dirname( __FILE__ ), '.', 'lib', 'spec_helper.rb' )         # our spec helper.
require File.join( File.dirname( __FILE__ ), '..', 'lib', 'bit_array_helper.rb' )   # our source code to be tested.


describe "the BitArrayHelper module" do

  it "exists and is a module" do
    expect {
      expect( BitArrayHelper.class ).to be( Module )
    }.not_to raise_error
  end # it "exists and is a module"


  describe "the BitArrayHelper::pack_data method" do

    it "should pack a given array into a integer value" do
      test_data = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ]                # expected input
      expected_data = 0b1001100001110110010101000011001000010000  # expected output

      expect( BitArrayHelper::pack_array( test_data, 4 ) ).to eq( expected_data )
    end # it "should pack a given array into a integer value"

  end # describe "the BitArrayHelper::pack_data method"


  describe "the BitArrayHelper::unpack_data method" do

    it "should convert given packed data, in the form of an integer, into an Array object" do
      test_data = 0b1001100001110110010101000011001000010000    # expected input
      expected_data = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ]          # expected output

      expect( BitArrayHelper::unpack_array( test_data, expected_data.length, 4 ) ).to match_array( expected_data )
    end # it "should convert given packed data, in the form of an integer, into an Array object"

  end # describe "the BitArrayHelper::unpack_data method"


  describe "the BitArrayHelper::num_bits method" do

    it "should correctly indicate the minimum number of bits required for a given integer" do
      max_num_bits = 1024   # test accuracy up to this number of bits.

      max_num_bits.times do |bit_width|
        expect( BitArrayHelper::num_bits( (2**bit_width)-1 ) ).to eq( bit_width )
      end

    end # it "should correctly indicate the minimum number of bits required for a given integer"

  end # describe "the BitArrayHelper::num_bits method"

end # describe "the BitArrayHelper module"
