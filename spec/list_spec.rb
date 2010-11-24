require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Stash::List do
  before :each do
    @list = Stash::List[:foobar]
    @list.clear
  end
  
  it "clears lists" do
    @list << "x"
    @list << "y"
    @list << "z"
    @list.clear
    @list.to_a.should == []
  end
    
  it "pushes to lists" do
    # Normal syntax
    @list.push "zomg"
    
    # Cool syntax
    @list << "wtf"
    
    @list.to_a.should == ["zomg", "wtf"]
  end
  
  it "unshifts to lists" do
    @list.unshift "omfg"
    @list.unshift "lulz"
    
    @list.to_a.should == ["lulz", "omfg"]
  end
  
  it "knows its length" do
    @list.length.should == 0
    
    @list << "x"
    @list << "y"
    @list << "z"
    @list.length.should == 3
  end
  
  it "knows if it's empty" do
    @list.should be_empty
    
    @list << "something"
    @list.should_not be_empty
  end
end