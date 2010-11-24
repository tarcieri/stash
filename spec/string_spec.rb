require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Stash::String do
  it "stores strings" do
    Stash[:foobar] = "baz"
    Stash[:foobar].should be_an_instance_of(Stash::String)
    Stash[:foobar].to_s.should == "baz"
  end
end
