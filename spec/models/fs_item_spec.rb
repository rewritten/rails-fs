require 'spec_helper'

describe FsItem do
  it "should not have slashes" do
    fsi = FsItem.new :name => "kjshdf/akjh"
    fsi.valid?.should be_false
    fsi = FsItem.new :name => 'dsfsd'
    fsi.valid?.should be_true
  end

  it "should have the correct path on level 1" do
    fsi = FsItem.create :name => 'dsfsd'
    fsi.path.should == '/dsfsd'
  end

  it "should have the correct path on level 2" do
    fsi = Directory.create :name => 'a'
    fsi2 = FsItem.create :name => 'b', :parent => fsi
    fsi2.path.should == '/a/b'
  end

  it "should not have two children with the same name" do
    fsi = Directory.create :name => 'a'
    fsi2 = FsItem.create :name => 'b', :parent => fsi
    fsi3 = FsItem.new :name => 'b', :parent => fsi
    fsi3.valid?.should be_false
    fsi4 = FsItem.create :name => 'c', :parent => fsi
    fsi = FsItem.find(fsi.id)
    fsi.should have(2).children
  end
    
  it "should update descendants paths" do
    fsi = Directory.create :name => 'a'
    fsi2 = FsItem.create :name => 'b', :parent => fsi
    fsi.name = 'b'
    fsi.save
    fsi2 = FsItem.find(fsi2.id)
    fsi2.path.should == '/b/b'
  end

  it "should have a directory as parent" do
    f = FileItem.create :name => 'a'
    sf = FsItem.new :name => 'b', :parent => f
    sf.valid?.should be_false
  end

end
