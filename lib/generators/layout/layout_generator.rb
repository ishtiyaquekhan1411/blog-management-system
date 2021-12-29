class LayoutGenerator < Rails::Generators::Base
  source_root File.expand_path('templates', __dir__)
  argument :layout_name, type: :string, default: 'application'

  def generate_layout
    copy_file 'stylesheet.css', "public/stylesheets/#{layout_name.underscore}.css"
    template 'layout.html.erb', "app/views/layouts/#{file_name}.html.erb"
  end
end
