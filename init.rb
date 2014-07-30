Redmine::Plugin.register :redmine_default_custom_query do
  name 'Redmine Default Custom Query plugin'
  author 'Katsuya Hidaka'
  description 'The default custom query per projects'
  version '0.1.0'
  url 'https://github.com/hidakatsuya/redmine_default_custom_query'
  author_url 'https://github.com/hidakatsuya'

  project_module :default_custom_query do
    permission :manage_default_query, { default_custom_query_setting: [ :update ] }, require: :member
  end
end

# Load patches for Redmine
Rails.configuration.to_prepare do
  Dir[File.expand_path('app/patches/**/*_patch.rb', File.dirname(__FILE__))].each {|f| require f }
end
