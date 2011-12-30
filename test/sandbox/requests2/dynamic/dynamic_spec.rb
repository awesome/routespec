require "spec_helper"

#
# routes
#  dynamic_controller /:controller/render_event_response(.:format) {:action=>"render_event_response"}
#
describe "dynamic response status codes" do
  describe "GET /:controller/render_event_response(.:format)" do
    it "should have a response", :vcr do
      controller = "REPLACE"
      format = nil
      get dynamic_controller_path(:controller => controller, :format => format)
      response.status.should be(200)
    end
  end

end