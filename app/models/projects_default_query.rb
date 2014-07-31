class ProjectsDefaultQuery < ActiveRecord::Base
  unloadable

  include Redmine::SafeAttributes

  belongs_to :project
  belongs_to :query, class_name: 'IssueQuery'

  safe_attributes 'query_id'

  validates :project_id, :query_id, numericality: { allow_nil: true }
  validates :project_id, uniqueness: true
  validate :query_must_be_selectable_query

  private

  def query_must_be_selectable_query
    return if errors.any? || query_id.blank? || !query_id_changed?

    new_query = IssueQuery.find_by_id(query_id)

    unless new_query
      errors.add :query_id, :invalid
    else
      unless project.selectable_queries_as_default.include?(new_query)
        errors.add :query_id, :invalid
      end
    end
  end
end
