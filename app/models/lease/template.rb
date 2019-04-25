module Lease
  class Template < ::ApplicationRecord

    mount_uploader :html_file, ::Lease::DocumentUploader

    has_many :envelopes

    validates :html_file, presence: true
  end
end