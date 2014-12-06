require File.expand_path('../../test_helper', __FILE__)

class IssuesWithDefaultQueryTest < ActionController::IntegrationTest
  setup do
    setup_proper_project
    logged_in @user

    @default_query, @query = create_list(:issue_query, 2, :public, project: @project)
  end

  context 'when the default query is not set' do
    should 'not execute the script that render the button for showing default issues' do
      get project_issues_path(@project)

      assert_response :success
      assert_select 'script#add-default-issues-button', false
    end

    should 'not apply the default query' do
      get project_issues_path(@project)

      assert_response :success
      assert_show_all_issues
    end
  end

  context 'when the default query is set' do
    setup do
      set_default_query @project, @default_query
    end

    should 'execute the script that render the button for showing default issues' do
      get project_issues_path(@project)

      assert_response :success
      assert_select 'script#add-default-issues-button'
    end

    should 'be able to operate in issues with default query' do
      get project_issues_path(@project)

      # should apply the default query
      assert_response :success
      assert_apply_query @default_query

      # click the "View all issues" button
      get project_issues_path(@project, set_filter: 1, without_default: 1)

      assert_response :success
      assert_show_all_issues

      # select the other query
      get project_issues_path(@project, query_id: @query.id)

      assert_response :success
      assert_apply_query @query
    end

    context 'when deleted the query that has been set as default' do
      should 'unset the default query' do
        delete query_path(@default_query)

        assert_nil @project.default_query
        assert_response :redirect
      end
    end

    context 'when changed to PRIVATE the visilibity of the default query' do
      should 'unset the default query' do
        if Redmine::VERSION.to_s < '2.4'
          @default_query.update_attribute :is_public, false
        else
          @default_query.update_attribute :visibility, Query::VISIBILITY_PRIVATE
        end

        get project_issues_path(@project)

        assert_response :success
        assert_nil @project.default_query
      end
    end

    context 'when changed to ROLES the visibility of the default query' do
      should 'unset the default query' do
        if Redmine::VERSION.to_s < '2.4'
          skip '2.3 or less has no ROLES visility'
        else
          @default_query.visibility = Query::VISIBILITY_ROLES
          @default_query.roles << create(:role)
          @default_query.save!

          get project_issues_path(@project)

          assert_response :success
          assert_nil @project.default_query
        end
      end
    end

    context 'when view /projects/foo/issues after select a global query in other project' do
      setup do
        @other_project = create(:project, :with_default_custom_query)
        add_member @other_project, @user, create(:role_with_manage_default_query)

        # @other_project's global query
        @global_query = create(:issue_query, :public, project: nil)

        # select @global_query in @other_project
        get project_issues_path(@other_project, query_id: @global_query.id)
      end

      should 'apply default query of current project' do
        get project_issues_path(@project)

        assert_response :success
        assert_apply_query @default_query
      end
    end
  end
end
