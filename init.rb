Redmine::Plugin.register :redmine_default_custom_query do
  name 'Redmine Default Custom Query plugin'
  author 'Katsuya Hidaka'
  description 'Redmine plugin for setting the default custom query to issues list per projects'
  version '0.0.1'
  requires_redmine '2.3'
  url 'https://github.com/hidakatsuya/redmine_default_custom_query'
  author_url 'https://twitter.com/hidakatsuya'

  project_module :default_custom_query do
    permission :manage_default_query, { default_custom_query_setting: [ :update ] }, require: :member
  end
end

require_relative 'lib/default_custom_query'
