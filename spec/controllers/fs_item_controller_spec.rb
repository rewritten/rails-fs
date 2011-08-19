require 'spec_helper'

describe FsItemController do
  it "should return root objects" do
    f1 = FileItem.create :name => 'f1'
    get :children, :path => ''
    _expected = [f1].map{|f| f.to_json()}.to_json
    ActiveSupport::JSON.decode(response.body).should == ActiveSupport::JSON.decode(_expected)
  end
end
