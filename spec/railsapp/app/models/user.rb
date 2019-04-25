class User < ApplicationRecord

  has_many :leasable

  alias_attribute :full_name, :name
end
