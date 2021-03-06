require 'spec_helper'

describe '#incr(key)' do
  before { @key = 'mock-redis-test:33888' }

  it "returns the value after the increment" do
    @redises.set(@key, 1)
    @redises.incr(@key).should == 2
  end

  it "treats a missing key like 0" do
    @redises.incr(@key).should == 1
  end

  it "increments negative numbers" do
    @redises.set(@key, -10)
    @redises.incr(@key).should == -9
  end

  it "works multiple times" do
    @redises.incr(@key).should == 1
    @redises.incr(@key).should == 2
    @redises.incr(@key).should == 3
  end

  it "raises an error if the value does not look like an integer" do
    @redises.set(@key, "one")
    lambda do
      @redises.incr(@key)
    end.should raise_error(RuntimeError)
  end

  it_should_behave_like "a string-only command"
end
