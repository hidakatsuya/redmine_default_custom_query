require_dependency 'project'

module DefaultCustomQuery
  module ProjectPatch
    unloadable

    extend ActiveSupport::Concern

    included do
      unloadable

      has_many :default_queries, dependent: :delete_all, class_name: 'ProjectsDefaultQuery'
    end

    def default_query
      default_queries.first.try :query
    end

    def init_default_query
      default_queries.first || default_queries.new
    end
  end
end

Project.send :include, DefaultCustomQuery::ProjectPatch
