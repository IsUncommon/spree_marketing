module SpreeMarketing
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_marketing'

    config.generators do |g|
      g.test_framework :rspec
    end

    def self.activate
      [Dir[config.root.join('app/models/spree/marketing/list/*')],
        Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb'))].flatten.each do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
