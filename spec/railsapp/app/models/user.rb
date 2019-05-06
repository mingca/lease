class User < ApplicationRecord

  lease_envelopable
  lease_signable

  alias_attribute :full_name, :name
end
