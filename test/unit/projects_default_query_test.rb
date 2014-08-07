require File.expand_path('../../test_helper', __FILE__)

class ProjectsDefaultQueryTest < ActiveSupport::TestCase
  should belong_to(:project)
  should belong_to(:query).class_name('IssueQuery')

  should validate_uniqueness_of(:project_id)
  should validate_presence_of(:project_id)
  should validate_numericality_of(:project_id)
  should validate_numericality_of(:query_id)
end
