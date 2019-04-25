module Lease
  class Engine < Rails::Engine

    isolate_namespace Lease

    initializer 'lease.initialize' do
      ::ActiveRecord::Base.send :extend, ::Lease::ActiveRecord
    end

  end
end
