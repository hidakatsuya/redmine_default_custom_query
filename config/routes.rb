RedmineApp::Application.routes.draw do
  get 'default_custom_query_setting/index', to: 'default_custom_query_setting#index'
  put 'default_custom_query/update', :controller => 'default_custom_query_setting', action: 'global_update', as: 'global_default_custom_query_setting_update'
  put ':project_id/default_custom_query/update', :controller => 'default_custom_query_setting', action: 'update', as: 'default_custom_query_setting_update'
end
