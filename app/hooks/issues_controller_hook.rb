module DefaultCustomQuery
  class IssuesControllerViewHooks < Redmine::Hook::ViewListener
    render_on :view_issues_sidebar_issues_bottom, partial: 'issues/sidebar_issues_bottom'
  end
end
