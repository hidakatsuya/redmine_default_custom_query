require_dependency 'issue_query'

module DefaultCustomQuery
  module IssueQueryPatch
    extend ActiveSupport::Concern

    included do
      unloadable

      has_many :projects_default_queries, dependent: :nullify, foreign_key: :query_id
    end

    def public_visibility?
      visibility == Query::VISIBILITY_PUBLIC
    end
  end
end

DefaultCustomQuery::IssueQueryPatch.tap do |mod|
  IssueQuery.send :include, mod unless IssueQuery.include?(mod)
end
