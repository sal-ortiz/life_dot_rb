require 'simplecov'
SimpleCov.start

require 'rspec'



# a default message returned by our custom matchers.
def default_failure_message( expected, actual )
  "expected: #{ expected.inspect }\n" +
  "     got: #{ actual.inspect }\n"
end

# match if two arrays contain the exact same data at the 
# same index, ignoring object id's.
RSpec::Matchers.define :be_a_duplicate_array_of do |expected|
  match do |actual|
    failure_message_for_should do |actual|
      default_failure_message( expected, actual )
    end
    failure_message_for_should_not do |actual|
      default_failure_message( expected, actual )
    end

    actual.each_index do |index|
      break if actual[index] != expected[index]
    end

    # implicitly returns most recent 'actual[index] != expected[index]'
  end
end

