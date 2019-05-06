module Lease
  module ActiveRecord

    def lease_envelopable
      has_one :envelope, as: :envelopable, inverse_of: :envelopable, validate: true, autosave: true, class_name: '::Lease::Envelope'
    end

    def lease_signable
      has_many :envelopes, as: :signable, inverse_of: :signable, validate: true, autosave: true, class_name: '::Lease::Envelope'

      def has_unsigned_lease?
        envelopes.unsigned.exists?
      end
    end

  end
end
