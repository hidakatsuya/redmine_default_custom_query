require_dependency 'issue_query'

module DefaultCsutomQuery
  module IssueQueryPatch
    extend ActiveSupport::Concern

    included do
      unloadable

      has_many :projects_default_query, dependent: :nullify, foreign_key: :query_id

      scope :only_public, -> {
        if Redmine::VERSION.to_s < '2.4'
          where(is_public: true)
        else
          where(visibility: Query::VISIBILITY_PUBLIC)
        end
      }
    end

    def public_visibility?
      if Redmine::VERSION.to_s < '2.4'
        is_public?
      else
        visibility == Query::VISIBILITY_PUBLIC
      end
    end
  end
end

IssueQuery.send :include, DefaultCsutomQuery::IssueQueryPatch