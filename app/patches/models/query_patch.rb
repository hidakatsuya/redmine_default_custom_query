require_dependency 'query'

module DefaultCustomQuery
  module QueryPatch
    extend ActiveSupport::Concern

    included do
      unloadable

      scope :only_public, -> { where(visibility: Query::VISIBILITY_PUBLIC) }
    end
  end
end

DefaultCustomQuery::QueryPatch.tap do |mod|
  Query.send :include, mod unless Query.include?(mod)
end
