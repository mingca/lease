module Lease
  class Config

    attr_accessor :lessee_sign_key

    def initialize
      @lessee_sign_key ||= :tenant_full_name
    end

  end
end