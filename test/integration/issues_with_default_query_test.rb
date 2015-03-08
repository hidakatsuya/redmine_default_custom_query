require File.expand_path('../../test_helper', __FILE__)

class IssuesWithDefaultQueryTest < Redmine::IntegrationTest
  def setup
    @project, @user = create_project_and_member_with_default_query
    logged_in @user

    @default_query, @query = create_list(:issue_query, 2, :public, project: @project)
  end

  def test_basic_features_when_default_query_is_not_set_in_project
    get project_issues_path(@project)

    assert_response :success
    assert_select 'script#add-default-issues-button', false

    get project_issues_path(@project)

    assert_response :success
    assert_show_all_issues
  end

  def test_basic_features_when_default_query_is_set_in_project
    set_default_query @project, @default_query

    get project_issues_path(@project)

    # should be rendered the "Show default issues" button
    assert_response :success
    assert_select 'script#add-default-issues-button'

    get project_issues_path(@project)

    assert_response :success
    assert_apply_query @default_query
  end

  def test_click_view_all_issues_button
    set_default_query @project, @default_query

    # click "View all issues" button
    get project_issues_path(@project, set_filter: 1, without_default: 1)

    assert_response :success
    assert_show_all_issues
  end

  def test_select_other_query
    set_default_query @project, @default_query

    get project_issues_path(@project, query_id: @query.id)

    assert_response :success
    assert_apply_query @query
  end

  def test_default_query_has_been_deleted
    set_default_query @project, @default_query

    delete query_path(@default_query)

    assert_nil @project.default_query
    assert_response :redirect
  end

  def test_visibility_of_default_query_has_been_changed_to_PRIVATE
    set_default_query @project, @default_query

    @default_query.update_attribute :visibility, Query::VISIBILITY_PRIVATE

    get project_issues_path(@project)

     assert_response :success
    assert_nil @project.default_query
  end

  def test_visibility_of_default_query_has_been_changed_to_ROLES
    set_default_query @project, @default_query

    @default_query.visibility = Query::VISIBILITY_ROLES
    @default_query.roles << create(:role)
    @default_query.save!

    get project_issues_path(@project)

    assert_response :success
    assert_nil @project.default_query
  end

  def test_initial_default_query
    set_default_query @project, @default_query

    @other_project = create(:project, :with_default_custom_query)
    add_member @other_project, @user, create(:role_with_manage_default_query)

    # @other_project's global query
    @global_query = create(:issue_query, :public, project: nil)

    # select @global_query in @other_project
    get project_issues_path(@other_project, query_id: @global_query.id)
    get project_issues_path(@project)

    assert_response :success
    assert_apply_query @default_query
  end
end
