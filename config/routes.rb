RedmineApp::Application.routes.draw do
  put ':project_id/default_custom_query/update', :controller => 'default_custom_query_setting', action: 'update', as: 'default_custom_query_setting_update'
end
