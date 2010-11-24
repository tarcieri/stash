require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Stash::List do
  it "pushes to lists" do
    list = Stash::List[:foobar]
    list.clear
    list.to_ary.should == []
    
    list << "zomg"
    list.to_ary.should == ["zomg"]
  end
end