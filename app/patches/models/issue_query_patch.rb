require_dependency 'issue_query'

module DefaultCsutomQuery
  module IssueQueryPatch
    extend ActiveSupport::Concern

    included do
      unloadable

      has_many :projects_default_query, dependent: :nullify, foreign_key: :query_id
    end
  end
end

IssueQuery.send :include, DefaultCsutomQuery::IssueQueryPatch