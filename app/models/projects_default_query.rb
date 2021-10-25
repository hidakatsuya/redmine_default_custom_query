class ProjectsDefaultQuery < ActiveRecord::Base

  belongs_to :project
  belongs_to :query, class_name: 'IssueQuery'

  validates :project_id, :query_id, numericality: { allow_nil: true }
  validates :project_id, uniqueness: true, presence: true
  validate :query_must_be_selectable

  def self.initialize_for(project_id)
    default_query = where(project_id: project_id).first

    unless default_query
      default_query = self.new
      default_query.project_id = project_id
    end
    default_query
  end

  def query
    return unless super

    unless new_record? || selectable_query?(super)
      update_attribute :query_id, nil
    end
    super
  end

  def self.get_global_query()
    current_global_query = where(project_id: -1).first
    
    unless current_global_query
      current_global_query = self.new
      current_global_query.project_id = -1
    end
    current_global_query
  end

  private

  def query_must_be_selectable
    return if errors.any? || query_id.blank? || !query_id_changed?

    issue_query = IssueQuery.where(id: query_id).first

    unless selectable_query?(issue_query)
      errors.add :query_id, :invalid
    end
  end

  def selectable_query?(query)
    query && query.public_visibility? &&
    (query.project.nil? || query.project == project)
  end
end
