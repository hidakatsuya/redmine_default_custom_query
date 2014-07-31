require 'pathname'

module DefaultCustomQuery
  def self.root
    @root ||= Pathname.new File.expand_path('..', File.dirname(__FILE__))
  end
end

# Load patches for Redmine
Rails.configuration.to_prepare do
  Dir[DefaultCustomQuery.root.join('app/patches/**/*_patch.rb')].each {|f| require f }
end

# Load hooks
Dir[DefaultCustomQuery.root.join('app/hooks/*_hook.rb')].each {|f| require f }
