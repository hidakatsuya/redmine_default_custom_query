class ProjectsDefaultQuery < ActiveRecord::Base
  unloadable

  include Redmine::SafeAttributes

  belongs_to :project, dependent: :destroy
  belongs_to :query, dependent: :destroy

  safe_attributes 'query_id'

  def self.init(project)
    find_or_initialize_by_project_id(project)
  end

  def self.selectable_queries_for(project)
    IssueQuery.visible.where(project_id: project, is_public: true)
  end
end
