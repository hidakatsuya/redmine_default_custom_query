require_dependency 'issues_controller'

module DefaultCustomQuery
  module IssuesControllerPatch
    unloadable

    extend ActiveSupport::Concern

    included do
      unloadable

      before_filter :with_default_query, only: [:index], if: :default_query_module_enabled?
      alias_method_chain :retrieve_query_from_session, :default_custom_query
    end

    def with_default_query
      case
      when params[:query_id].present?
        # Nothing to do
      when api_request?
        # Nothing to do
      when show_all_issues?
        params[:set_filter] = 1
      when filter_applied?
        # Nothing to do
      when filter_cleared?
        apply_default_query!
      when session[:query]
        query_id, project_id = session[:query].values_at(:id, :project_id)
        unless query_id && (project_id == @project.id) && available_query?(query_id)
          apply_default_query!
        end
      else
        apply_default_query!
      end
    end

    def retrieve_query_from_session_with_default_custom_query
      if default_query_module_enabled?
        if session[:query]
          retrieve_query_from_session_without_default_custom_query
        else
          @query = find_default_query
        end
      else
        retrieve_query_from_session_without_default_custom_query
      end
    end

    private

    def find_default_query
      @project.default_query
    end

    def apply_default_query!
      default_query = find_default_query
      if default_query
        params[:query_id] = default_query.id
      end
    end

    def filter_applied?
      params[:set_filter] && params.key?(:op) && params.key?(:f)
    end

    def filter_cleared?
      params[:set_filter] && [:op, :f].all? {|k| !params.key?(k) }
    end

    def show_all_issues?
      params[:without_default]
    end

    def default_query_module_enabled?
      @project && @project.module_enabled?(:default_custom_query)
    end

    def available_query?(query_id)
      IssueQuery.only_public
                .where('project_id is null or project_id = ?', @project.id)
                .where(id: query_id).exists?
    end
  end
end

IssuesController.send :include, DefaultCustomQuery::IssuesControllerPatch
