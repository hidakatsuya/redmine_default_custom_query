require_dependency 'projects_helper'

module DefaultCustomQuery
  module ProjectsHelperPatch

    def project_settings_tabs
      tabs = super
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

ProjectsController.send :helper, DefaultCustomQuery::ProjectsHelperPatch
