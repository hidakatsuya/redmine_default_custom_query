require_dependency 'project'

module DefaultCustomQuery
  module ProjectPatch
    unloadable

    extend ActiveSupport::Concern

    included do
      unloadable

      has_one :projects_default_query, dependent: :delete
      has_one :default_query, through: :projects_default_query, source: :query
    end

    def selectable_queries_as_default
      queries.visible.where(is_public: true)
    end

    def init_projects_default_query
      projects_default_query || build_projects_default_query
    end
  end
end

Project.send :include, DefaultCustomQuery::ProjectPatch