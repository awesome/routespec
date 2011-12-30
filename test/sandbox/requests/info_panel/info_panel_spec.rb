require "spec_helper"

#
# routes
#  info_panel_edit GET /info_panel/edit(.:format) {:controller=>"info_panel", :action=>"edit"}
#
describe "info_panel response status codes" do
  describe "GET /info_panel/edit(.:format)" do
    it "should have a response", :vcr do
      format = nil
      get info_panel_edit_path(:format => format)
      response.status.should be(200)
    end
  end

end