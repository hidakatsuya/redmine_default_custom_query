require_dependency 'projects_helper'

module ProjectsHelper
  unloadable

  def project_settings_tabs_with_default_query_setting_tab
    tabs = project_settings_tabs_without_default_query_setting_tab

    if User.current.allowed_to?(:manage_default_query, @project) &&
        @project.module_enabled?(:default_custom_query)
      tabs << {
        name: 'default_custom_query',
        action: :manage_default_query,
        partial: 'default_custom_query_setting/form',
        label: :label_project_default_custom_query
      }
    end
    tabs
  end
  alias_method_chain :project_settings_tabs, :default_query_setting_tab
end