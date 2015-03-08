require_dependency 'projects_helper'

module DefaultCustomQuery
  module ProjectsHelperPatch
    extend ActiveSupport::Concern

    included do
      unloadable
      alias_method_chain :project_settings_tabs, :default_query_setting_tab
    end

    def project_settings_tabs_with_default_query_setting_tab
      tabs = project_settings_tabs_without_default_query_setting_tab

      if User.current.allowed_to?(:manage_default_query, @project) &&
          @project.module_enabled?(:default_custom_query)
        tabs << {
          name: 'default_custom_query',
          action: :manage_default_query,
          partial: 'default_custom_query_setting/form',
          label: :'default_custom_query.label_setting'
        }
      end
      tabs
    end
  end
end

DefaultCustomQuery::ProjectsHelperPatch.tap do |mod|
  ProjectsHelper.send :include, mod unless ProjectsHelper.include?(mod)
end
