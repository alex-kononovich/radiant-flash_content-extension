# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'

class FlashContentExtension < Radiant::Extension
  version "1.0"
  description "Provide libraries to insert flash content"
  url "http://github.com/flskif/radiant-flash_content-extension"
  
  # extension_config do |config|
  #   config.gem 'some-awesome-gem
  #   config.after_initialize do
  #     run_something
  #   end
  # end

  # See your config/routes.rb file in this extension to define custom routes
  
  def activate
    Page.send :include, FlashContentTags
    # tab 'Content' do
    #   add_item "Flash Content", "/admin/flash_content", :after => "Pages"
    # end
  end
end
