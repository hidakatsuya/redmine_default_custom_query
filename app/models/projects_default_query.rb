class ProjectsDefaultQuery < ActiveRecord::Base
  unloadable

  include Redmine::SafeAttributes

  belongs_to :project
  belongs_to :query, class_name: 'IssueQuery'

  safe_attributes 'query_id'

  validates :project_id, :query_id, numericality: { allow_nil: true }
  validates :project_id, uniqueness: true, presence: true
  validate :query_must_be_selectable_query

  def query
    default_query = super
    return unless default_query

    if !new_record? && !default_query.public_visibility?
      update_attribute :query_id, nil
    end
    default_query
  end

  private

  def query_must_be_selectable_query
    return if errors.any? || query_id.blank? || !query_id_changed?

    unless project.queries.only_public.exists?(query_id)
      errors.add :query_id, :invalid
    end
  end
end
