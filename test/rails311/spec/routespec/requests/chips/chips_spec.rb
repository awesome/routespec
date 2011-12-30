require "spec_helper"

#
# routes
#  chips GET /chips(.:format) {:action=>"index", :controller=>"chips"}
#  POST /chips(.:format) {:action=>"create", :controller=>"chips"}
#  new_chip GET /chips/new(.:format) {:action=>"new", :controller=>"chips"}
#  edit_chip GET /chips/:id/edit(.:format) {:action=>"edit", :controller=>"chips"}
#  chip GET /chips/:id(.:format) {:action=>"show", :controller=>"chips"}
#  PUT /chips/:id(.:format) {:action=>"update", :controller=>"chips"}
#  DELETE /chips/:id(.:format) {:action=>"destroy", :controller=>"chips"}
#
describe "chips response status codes" do
  describe "GET /chips(.:format)" do
    it "should have a response", :vcr do
      format = nil
      get chips_path(:format => format)
      response.status.should be(200)
    end
  end

  describe "POST /chips(.:format)" do
    it "should have a response", :vcr do
      format = nil
      post "/chips#{format ? "." : nil}#{format}"
      response.status.should be(201)
    end
  end

  describe "GET /chips/new(.:format)" do
    it "should have a response", :vcr do
      format = nil
      get new_chip_path(:format => format)
      response.status.should be(200)
    end
  end

  describe "GET /chips/:id/edit(.:format)" do
    it "should have a response", :vcr do
      id = "REPLACE"
      format = nil
      get edit_chip_path(:id => id, :format => format)
      response.status.should be(200)
    end
  end

  describe "GET /chips/:id(.:format)" do
    it "should have a response", :vcr do
      id = "REPLACE"
      format = nil
      get chip_path(:id => id, :format => format)
      response.status.should be(200)
    end
  end

  describe "PUT /chips/:id(.:format)" do
    it "should have a response", :vcr do
      id = "REPLACE"
      format = nil
      put "/chips/#{id}#{format ? "." : nil}#{format}"
      response.status.should be(200)
    end
  end

  describe "DELETE /chips/:id(.:format)" do
    it "should have a response", :vcr do
      id = "REPLACE"
      format = nil
      delete "/chips/#{id}#{format ? "." : nil}#{format}"
      response.status.should be(200)
    end
  end

end