Redmine::Plugin.register :redmine_default_custom_query do
  name 'Redmine Default Custom Query'
  author 'Katsuya Hidaka'
  description 'Redmine plugin for setting default custom query of Issues for each project'
  version '1.5.0'
  requires_redmine '4.0'
  url 'https://github.com/hidakatsuya/redmine_default_custom_query'
  author_url 'https://twitter.com/hidakatsuya'

  project_module :default_custom_query do
    permission :manage_default_query, { default_custom_query_setting: [ :update ] }, require: :member
    permission :manage_global_default_query, { default_custom_query_setting: [ :index ] }, require: :admin
  end
  
  menu :admin_menu, :default_global_custom_query, { controller: 'default_custom_query_setting', action: 'index' }, caption: 'Default Custom Query'
end

require_relative 'lib/default_custom_query'
