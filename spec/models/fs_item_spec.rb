require 'spec_helper'

describe FsItem do
  it "should not have slashes" do
    fsi = FsItem.new :name => "kjshdf/akjh"
    fsi.save
    fsi.new_record?.should be_true
    fsi = FsItem.new :name => 'dsfsd'
    fsi.save
    fsi.new_record?.should be_false
  end

  it "should have the correct path on level 1" do
    fsi = FsItem.new :name => 'dsfsd'
    fsi.save
    fsi.path.should == '/dsfsd'
  end

  it "should have the correct path on level 2" do
    fsi = FsItem.new :name => 'a'
    fsi.save
    fsi2 = FsItem.new :name => 'b', :parent => fsi
    fsi2.save
    fsi2.path.should == '/a/b'
  end

  it "should not have two elements with the same name" do
    fsi = FsItem.new :name => 'a'
    fsi.save
    fsi2 = FsItem.new :name => 'b', :parent => fsi
    fsi2.save
    fsi3 = FsItem.new :name => 'b', :parent => fsi
    fsi3.save
    fsi3.new_record?.should be_true
    fsi = FsItem.find(fsi.id)
    fsi.should have(1).children
    fsi4 = FsItem.new :name => 'c', :parent => fsi
    fsi4.save
    fsi = FsItem.find(fsi.id)
    fsi.should have(2).children
  end
    
  it "should update descendants paths" do
    fsi = FsItem.new :name => 'a'
    fsi.save
    fsi2 = FsItem.new :name => 'b', :parent => fsi
    fsi2.save
    fsi.name = 'b'
    fsi.save
    fsi2 = FsItem.find(fsi2.id)
    fsi2.path.should == '/b/b'
  end
end
