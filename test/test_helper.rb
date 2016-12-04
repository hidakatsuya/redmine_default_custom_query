require File.expand_path(File.dirname(__FILE__) + '/../../../test/test_helper')

Dir[DefaultCustomQuery.root.join('test/factories/*.rb')].each {|f| require f }

module DefaultCustomQuery
  module TestHelper
    include FactoryGirl::Syntax::Methods
    include Redmine::I18n

    def create_member(project, user, role)
      create(:member, project: project, user: user, roles: [role])
    end
    alias_method :add_member, :create_member

    def create_project_and_member_with_default_query
      user = create(:user)
      project = create(:project, :with_default_custom_query)
      add_member project, user, create(:role_with_manage_default_query)

      [project, user]
    end

    def set_default_query(project, query)
      create(:default_query, project: project, query: query)
    end

    def logged_in(user)
      log_user user.login, attributes_for(:user)[:password]
    end

    def assert_apply_query(query)
      assert_select 'h2', text: query.name
      assert_select 'ul.queries a.selected', text: query.name
    end

    def assert_show_all_issues
      assert_select 'h2', text: l(:label_issue_plural)
      assert_select 'ul.queries a.selected', false
    end
  end
end

Redmine::IntegrationTest.send :include, DefaultCustomQuery::TestHelper
