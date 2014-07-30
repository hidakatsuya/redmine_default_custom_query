RedmineApp::Application.routes.draw do
  controller :default_custom_query_setting, as: 'default_custom_query_setting' do
    put ':project_id/default_custom_query/update', action: 'update', as: 'update'
  end
end