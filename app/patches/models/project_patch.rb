require_dependency 'project'

module DefaultCustomQuery
  module ProjectPatch
    unloadable

    extend ActiveSupport::Concern

    included do
      unloadable

      has_one :projects_default_query, dependent: :delete
    end

    def default_query
      projects_default_query.try(:query)
    end

    def init_projects_default_query
      projects_default_query || build_projects_default_query
    end
  end
end

Project.send :include, DefaultCustomQuery::ProjectPatch