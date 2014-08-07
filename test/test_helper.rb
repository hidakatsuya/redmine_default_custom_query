# Load the Redmine helper
require File.expand_path(File.dirname(__FILE__) + '/../../../test/test_helper')

Dir[DefaultCustomQuery.root.join('test/factories/*.rb')].each {|f| require f }

class Test::Unit::TestCase
  include FactoryGirl::Syntax::Methods
  include Redmine::I18n

  def create_member(project, user, role)
    create(:member, project: project, user: user, roles: [role])
  end
  alias_method :add_member, :create_member

  def setup_proper_project
    @user = create(:user)
    @project = create(:project, :with_default_custom_query)

    add_member @project, @user, create(:role_with_manage_default_query)
  end

  def set_default_query(project, query)
    create(:default_query, project: project, query: query)
  end

  def logged_in(user)
    log_user user.login, attributes_for(:user)[:password]
  end

  def assert_apply_query(query)
    assert_select 'h2', text: query.name

    if Redmine::VERSION.to_s < '2.4'
      assert_select '#sidebar a.query.selected', text: query.name
    else
      assert_select 'ul.queries a.selected', text: query.name
    end
  end

  def assert_show_all_issues
    assert_select 'h2', text: l(:label_issue_plural)

    if Redmine::VERSION.to_s < '2.4'
      assert_select '#sidebar a.query.selected', false
    else
      assert_select 'ul.queries a.selected', false
    end
  end
end
