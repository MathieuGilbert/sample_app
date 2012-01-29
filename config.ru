# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

map "/#{ENV['APP_ROOT_FOLDER']}" do
    run SampleApp::Application 
        #SampleApp::Application.config.root_app_folder = root_app_folder
end