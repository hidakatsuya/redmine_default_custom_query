require File.expand_path('../../test_helper', __FILE__)

class ManageDefaultQueryTest < Redmine::IntegrationTest
  def setup
    @user = create(:user)
    @project = create(:project, :with_default_custom_query)
    logged_in @user
  end

  def test_logged_user_has_not_manage_default_query_permission
    add_member @project, @user, create(:role_without_manage_default_query)

    # show
    get settings_project_path(@project)

    assert_response :success
    assert_select '#tab-default_custom_query', false

    # update
    put default_custom_query_setting_update_path(@project)

    assert_response :forbidden
  end

  def test_logged_user_has_manage_default_query_permission
    add_member @project, @user, create(:role_with_manage_default_query)

    @queries = [
      create(:issue_query, :public, project: @project),
      # Global query
      create(:issue_query, :public)
    ]
     @unselectable_queries = [
      create(:issue_query, :private, project: @project),
      create(:issue_query, :roles, project: @project)
    ]

    get settings_project_path(@project, tab: 'default_custom_query')

    # Render
    assert_response :success
    assert_template partial: 'default_custom_query_setting/_form'

    assert_select 'select#settings_query_id optgroup option', count: @queries.count
    assert_select 'select#settings_query_id' do
      @queries.each do |query|
        assert_select 'option', text: query.name
      end
    end

    # New setting
    assert_difference -> { @project.default_queries.count }, 1 do
      xhr :put, default_custom_query_setting_update_path(@project),
                settings: { query_id: @queries.first.id }
    end

    assert_equal @project.default_query, @queries.first
    assert_response :success
    assert_template partial: 'default_custom_query_setting/_form'

    # Update
    assert_no_difference -> { @project.default_queries.count } do
      xhr :put, default_custom_query_setting_update_path(@project),
                settings: { query_id: @queries.last.id }
    end

    assert_equal @project.default_query, @queries.last
    assert_response :success
    assert_template partial: 'default_custom_query_setting/_form'

    # Clear
    assert_no_difference -> { @project.default_queries.count } do
      xhr :put, default_custom_query_setting_update_path(@project),
                settings: { query_id: '' }
    end

    assert_nil @project.default_query
    assert_response :success
    assert_template partial: 'default_custom_query_setting/_form'

    # Update to unselectable query
    xhr :put, default_custom_query_setting_update_path(@project),
              settings: { query_id: @unselectable_queries.first.id }

    assert_response :success
    assert_template partial: 'default_custom_query_setting/_form'
    assert_nil @project.default_query

    # should be rendered the error message
    assert_select '#errorExplanation li', 1
  end
end
