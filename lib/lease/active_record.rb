module Lease
  module ActiveRecord

    def leasable
      has_many :envelopes, as: :envelopable, inverse_of: :envelopable, validate: true, autosave: true, class_name: '::Lease::Envelope'
    end

  end
end
