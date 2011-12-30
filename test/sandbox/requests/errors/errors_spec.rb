require "spec_helper"

#
# routes
#  POST /errors(.:format) {:action=>"create", :controller=>"errors"}
#  PUT /errors/:id(.:format) {:action=>"update", :controller=>"errors"}
#  DELETE /errors/:id(.:format) {:action=>"destroy", :controller=>"errors"}
#
describe "errors response status codes" do
  describe "POST /errors(.:format)" do
    it "should have a response", :vcr do
      format = nil
      post "/errors#{format ? "." : nil}#{format}"
      response.status.should be(201)
    end
  end

  describe "PUT /errors/:id(.:format)" do
    it "should have a response", :vcr do
      id = "REPLACE"
      format = nil
      put "/errors/#{id}#{format ? "." : nil}#{format}"
      response.status.should be(200)
    end
  end

  describe "DELETE /errors/:id(.:format)" do
    it "should have a response", :vcr do
      id = "REPLACE"
      format = nil
      delete "/errors/#{id}#{format ? "." : nil}#{format}"
      response.status.should be(200)
    end
  end

end