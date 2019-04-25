class User < ApplicationRecord

  leasable

  alias_attribute :full_name, :name
end
