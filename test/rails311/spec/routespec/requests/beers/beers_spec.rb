require "spec_helper"

#
# routes
#  beers GET /beers(.:format) {:action=>"index", :controller=>"beers"}
#  POST /beers(.:format) {:action=>"create", :controller=>"beers"}
#  new_beer GET /beers/new(.:format) {:action=>"new", :controller=>"beers"}
#  edit_beer GET /beers/:id/edit(.:format) {:action=>"edit", :controller=>"beers"}
#  beer GET /beers/:id(.:format) {:action=>"show", :controller=>"beers"}
#  PUT /beers/:id(.:format) {:action=>"update", :controller=>"beers"}
#  DELETE /beers/:id(.:format) {:action=>"destroy", :controller=>"beers"}
#
describe "beers response status codes" do
  describe "GET /beers(.:format)" do
    it "should have a response", :vcr do
      format = nil
      get beers_path(:format => format)
      response.status.should be(200)
    end
  end

  describe "POST /beers(.:format)" do
    it "should have a response", :vcr do
      format = nil
      post "/beers#{format ? "." : nil}#{format}"
      response.status.should be(201)
    end
  end

  describe "GET /beers/new(.:format)" do
    it "should have a response", :vcr do
      format = nil
      get new_beer_path(:format => format)
      response.status.should be(200)
    end
  end

  describe "GET /beers/:id/edit(.:format)" do
    it "should have a response", :vcr do
      id = "REPLACE"
      format = nil
      get edit_beer_path(:id => id, :format => format)
      response.status.should be(200)
    end
  end

  describe "GET /beers/:id(.:format)" do
    it "should have a response", :vcr do
      id = "REPLACE"
      format = nil
      get beer_path(:id => id, :format => format)
      response.status.should be(200)
    end
  end

  describe "PUT /beers/:id(.:format)" do
    it "should have a response", :vcr do
      id = "REPLACE"
      format = nil
      put "/beers/#{id}#{format ? "." : nil}#{format}"
      response.status.should be(200)
    end
  end

  describe "DELETE /beers/:id(.:format)" do
    it "should have a response", :vcr do
      id = "REPLACE"
      format = nil
      delete "/beers/#{id}#{format ? "." : nil}#{format}"
      response.status.should be(200)
    end
  end

end