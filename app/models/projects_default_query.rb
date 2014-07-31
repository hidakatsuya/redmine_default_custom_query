class ProjectsDefaultQuery < ActiveRecord::Base
  unloadable

  include Redmine::SafeAttributes

  belongs_to :project, dependent: :delete
  belongs_to :query, dependent: :delete

  safe_attributes 'query_id'

  class << self
    def init(project)
      find_or_initialize_by_project_id(project)
    end
  end
end
