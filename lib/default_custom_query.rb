require 'pathname'

module DefaultCustomQuery
  def self.root
    @root ||= Pathname.new File.expand_path('..', File.dirname(__FILE__))
  end
end

Rails.configuration.to_prepare do
  # Load patches for Redmine
  Dir[DefaultCustomQuery.root.join('app/patches/**/*_patch.rb')].each {|f| require_dependency f }

  # Load application helper
  ::DefaultCustomQueryHelper.tap do |mod|
    ActionView::Base.send :include, mod unless ActionView::Base.include?(mod)
  end
end

# Load hooks
Dir[DefaultCustomQuery.root.join('app/hooks/*_hook.rb')].each {|f| require_dependency f }
