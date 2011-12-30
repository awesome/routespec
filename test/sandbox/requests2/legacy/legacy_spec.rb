require "spec_helper"

#
# routes
#  /index.cfm(.:format) {:controller=>"legacy", :action=>"index"}
#  /listingid=:id(.:format) {:id=>/[0-9]+/, :controller=>"legacy", :action=>"listingid"}
#
describe "legacy response status codes" do
  describe "GET /index.cfm(.:format)" do
    it "should have a response", :vcr do
      format = nil
      get "/index#{format ? "." : nil}cfm.#{format}"
      response.status.should be(200)
    end
  end

  describe "GET /listingid=:id(.:format)" do
    it "should have a response", :vcr do
      id = "REPLACE"
      format = nil
      get "/listingid=#{id}#{format ? "." : nil}#{format}"
      response.status.should be(200)
    end
  end

end