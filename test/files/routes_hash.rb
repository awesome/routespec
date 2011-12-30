@routes_hash = {:lines=>
  {1=>
    {:raw=>
      "dynamic_controller /:controller/render_event_response(.:format) {:action=>\"render_event_response\"}",
     :helper=>"dynamic_controller",
     :http_verb=>"GET",
     :path=>"/:controller/render_event_response(.:format)",
     :action=>"render_event_response",
     :controller=>nil,
     :symbols=>["controller", "format"],
     :address=>["dynamic"],
     :status_code=>200,
     :helper_path=>
      "dynamic_controller_path(:controller => controller, :format => format)",
     :vars=>["controller = \"REPLACE\"", "format = nil"]},
   3=>
    {:raw=>
      "info_panel_edit GET /info_panel/edit(.:format) {:controller=>\"info_panel\", :action=>\"edit\"}",
     :helper=>"info_panel_edit",
     :http_verb=>"GET",
     :path=>"/info_panel/edit(.:format)",
     :action=>"edit",
     :controller=>"info_panel",
     :symbols=>["format"],
     :address=>["info_panel"],
     :status_code=>200,
     :helper_path=>"info_panel_edit_path(:format => format)",
     :vars=>["format = nil"]},
   4=>
    {:raw=>
      "POST /errors(.:format) {:action=>\"create\", :controller=>\"errors\"}",
     :helper=>nil,
     :http_verb=>"POST",
     :path=>"/errors(.:format)",
     :action=>"create",
     :controller=>"errors",
     :symbols=>["format"],
     :address=>["errors"],
     :status_code=>201,
     :helper_path=>"\"/errors\#{format ? \".\" : nil}\#{format}\"",
     :vars=>["format = nil"]},
   5=>
    {:raw=>
      "PUT /errors/:id(.:format) {:action=>\"update\", :controller=>\"errors\"}",
     :helper=>nil,
     :http_verb=>"PUT",
     :path=>"/errors/:id(.:format)",
     :action=>"update",
     :controller=>"errors",
     :symbols=>["id", "format"],
     :address=>["errors"],
     :status_code=>200,
     :helper_path=>"\"/errors/\#{id}\#{format ? \".\" : nil}\#{format}\"",
     :vars=>["id = \"REPLACE\"", "format = nil"]},
   6=>
    {:raw=>
      "DELETE /errors/:id(.:format) {:action=>\"destroy\", :controller=>\"errors\"}",
     :helper=>nil,
     :http_verb=>"DELETE",
     :path=>"/errors/:id(.:format)",
     :action=>"destroy",
     :controller=>"errors",
     :symbols=>["id", "format"],
     :address=>["errors"],
     :status_code=>200,
     :helper_path=>"\"/errors/\#{id}\#{format ? \".\" : nil}\#{format}\"",
     :vars=>["id = \"REPLACE\"", "format = nil"]},
   7=>
    {:raw=>
      "/index.cfm(.:format) {:controller=>\"legacy\", :action=>\"index\"}",
     :helper=>nil,
     :http_verb=>"GET",
     :path=>"/index.cfm(.:format)",
     :action=>"index",
     :controller=>"legacy",
     :symbols=>["format"],
     :address=>["legacy"],
     :status_code=>200,
     :helper_path=>"\"/index\#{format ? \".\" : nil}cfm.\#{format}\"",
     :vars=>["format = nil"]},
   8=>
    {:raw=>
      "/listingid=:id(.:format) {:id=>/[0-9]+/, :controller=>\"legacy\", :action=>\"listingid\"}",
     :helper=>nil,
     :http_verb=>"GET",
     :path=>"/listingid=:id(.:format)",
     :action=>"listingid",
     :controller=>"legacy",
     :symbols=>["id", "format"],
     :address=>["legacy"],
     :status_code=>200,
     :helper_path=>"\"/listingid=\#{id}\#{format ? \".\" : nil}\#{format}\"",
     :vars=>["id = \"REPLACE\"", "format = nil"]},
   9=>
    {:raw=>
      "/mls/:id(.:format) {:controller=>\"agents_and_offices/listings\", :action=>\"mls\"}",
     :helper=>nil,
     :http_verb=>"GET",
     :path=>"/mls/:id(.:format)",
     :action=>"mls",
     :controller=>"agents_and_offices/listings",
     :symbols=>["id", "format"],
     :address=>["agents_and_offices", "listings"],
     :status_code=>200,
     :helper_path=>"\"/mls/\#{id}\#{format ? \".\" : nil}\#{format}\"",
     :vars=>["id = \"REPLACE\"", "format = nil"]},
   10=>
    {:raw=>
      "agent_listing_enquiries POST /agents/:agent_id/listings/:listing_id/enquiries(.:format) {:action=>\"create\", :controller=>\"agents_and_offices/enquiries\"}",
     :helper=>"agent_listing_enquiries",
     :http_verb=>"POST",
     :path=>"/agents/:agent_id/listings/:listing_id/enquiries(.:format)",
     :action=>"create",
     :controller=>"agents_and_offices/enquiries",
     :symbols=>["agent_id", "listing_id", "format"],
     :address=>["agents_and_offices", "enquiries"],
     :status_code=>201,
     :helper_path=>
      "agent_listing_enquiries_path(:agent_id => agent_id, :listing_id => listing_id, :format => format)",
     :vars=>
      ["agent_id = \"REPLACE\"", "listing_id = \"REPLACE\"", "format = nil"]},
   11=>
    {:raw=>
      "new_agent_listing_enquiry GET /agents/:agent_id/listings/:listing_id/enquiries/new(.:format) {:action=>\"new\", :controller=>\"agents_and_offices/enquiries\"}",
     :helper=>"new_agent_listing_enquiry",
     :http_verb=>"GET",
     :path=>"/agents/:agent_id/listings/:listing_id/enquiries/new(.:format)",
     :action=>"new",
     :controller=>"agents_and_offices/enquiries",
     :symbols=>["agent_id", "listing_id", "format"],
     :address=>["agents_and_offices", "enquiries"],
     :status_code=>200,
     :helper_path=>
      "new_agent_listing_enquiry_path(:agent_id => agent_id, :listing_id => listing_id, :format => format)",
     :vars=>
      ["agent_id = \"REPLACE\"", "listing_id = \"REPLACE\"", "format = nil"]},
   12=>
    {:raw=>
      "agent_listing_gallery_photo GET /agents/:agent_id/listings/:listing_id/galleries/:gallery_id/photos/:id(.:format) {:action=>\"show\", :controller=>\"agents_and_offices/photos\"}",
     :helper=>"agent_listing_gallery_photo",
     :http_verb=>"GET",
     :path=>
      "/agents/:agent_id/listings/:listing_id/galleries/:gallery_id/photos/:id(.:format)",
     :action=>"show",
     :controller=>"agents_and_offices/photos",
     :symbols=>["agent_id", "listing_id", "gallery_id", "id", "format"],
     :address=>["agents_and_offices", "photos"],
     :status_code=>200,
     :helper_path=>
      "agent_listing_gallery_photo_path(:agent_id => agent_id, :listing_id => listing_id, :gallery_id => gallery_id, :id => id, :format => format)",
     :vars=>
      ["agent_id = \"REPLACE\"",
       "listing_id = \"REPLACE\"",
       "gallery_id = \"REPLACE\"",
       "id = \"REPLACE\"",
       "format = nil"]}},
 :lines_without_controller=>
  {2=>
    "                                       no_controller        /render_event_response(.:format)                                                    {:action=>\"render_event_response\"}\n"}}
