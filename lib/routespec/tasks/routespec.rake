namespace :routespec do
  desc "\"$ rake routes\" output to Rails.root/spec/routespec/rake_routes.txt; Target specific controller with CONTROLLER=x."
  task :routes do
    output_file_name = "#{Rails.root}/spec/routespec/support/routes.txt"
    Routespec::Tasks.routes(Rails.root, output_file_name)
  end

  desc "rake_routes.txt parsed to hash with output to Rails.root/spec/routespec/support/rake_routes.yml"
  task :text_to_yaml do
    input_file_name = "#{Rails.root}/spec/routespec/support/routes.txt" 
    output_file_name = "#{Rails.root}/spec/routespec/support/routes.yml" 
    Routespec::Builder.text_to_yaml(input_file_name, output_file_name)  
  end

  desc "rake_routes.yml used to create tests in Rails.root/spec/routspec/requests/ with test-template Rails.root/spec/routespec/templates/example_template.erb" 
  task :build_tests do
    input_file_name = "#{Rails.root}/spec/routespec/support/routes.yml" 
    template_file_name = "#{Rails.root}/spec/routespec/templates/default_spec.erb"
    output_dir_name = "#{Rails.root}/spec/routespec/requests"
    Routespec::Builder.yaml_to_specs(input_file_name, template_file_name, output_dir_name)
  end
end
