require "spec_helper"

#
# routes
#  sports GET /sports(.:format) {:action=>"index", :controller=>"sports"}
#  POST /sports(.:format) {:action=>"create", :controller=>"sports"}
#  new_sport GET /sports/new(.:format) {:action=>"new", :controller=>"sports"}
#  edit_sport GET /sports/:id/edit(.:format) {:action=>"edit", :controller=>"sports"}
#  sport GET /sports/:id(.:format) {:action=>"show", :controller=>"sports"}
#  PUT /sports/:id(.:format) {:action=>"update", :controller=>"sports"}
#  DELETE /sports/:id(.:format) {:action=>"destroy", :controller=>"sports"}
#
describe "sports response status codes" do
  describe "GET /sports(.:format)" do
    it "should have a response", :vcr do
      format = nil
      get sports_path(:format => format)
      response.status.should be(200)
    end
  end

  describe "POST /sports(.:format)" do
    it "should have a response", :vcr do
      format = nil
      post "/sports#{format ? "." : nil}#{format}"
      response.status.should be(201)
    end
  end

  describe "GET /sports/new(.:format)" do
    it "should have a response", :vcr do
      format = nil
      get new_sport_path(:format => format)
      response.status.should be(200)
    end
  end

  describe "GET /sports/:id/edit(.:format)" do
    it "should have a response", :vcr do
      id = "REPLACE"
      format = nil
      get edit_sport_path(:id => id, :format => format)
      response.status.should be(200)
    end
  end

  describe "GET /sports/:id(.:format)" do
    it "should have a response", :vcr do
      id = "REPLACE"
      format = nil
      get sport_path(:id => id, :format => format)
      response.status.should be(200)
    end
  end

  describe "PUT /sports/:id(.:format)" do
    it "should have a response", :vcr do
      id = "REPLACE"
      format = nil
      put "/sports/#{id}#{format ? "." : nil}#{format}"
      response.status.should be(200)
    end
  end

  describe "DELETE /sports/:id(.:format)" do
    it "should have a response", :vcr do
      id = "REPLACE"
      format = nil
      delete "/sports/#{id}#{format ? "." : nil}#{format}"
      response.status.should be(200)
    end
  end

end