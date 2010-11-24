require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Stash::Hash do
  before :each do
    @hash = Stash::Hash[:foobar]
    @hash.clear
  end
  
  it "clears hashes" do
    @hash[:foo] = "a"
    @hash[:bar] = "b"
    @hash.clear
    @hash.to_hash.should == {}
  end
  
  it "sets and gets strings from hashes" do
    @hash[:foo].should be_nil
    @hash[:foo] = "42"
    @hash[:foo].should == "42"
  end
  
  it "casts to a Ruby hash" do
    @hash.should be_empty
    @hash['foo'] = 'a'
    @hash['bar'] = 'b'
    
    @hash.to_hash.should == {'foo'=>'a', 'bar'=>'b'}
  end
end