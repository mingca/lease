module Lease
  class DocumentUploader < CarrierWave::Uploader::Base

    # Include RMagick or MiniMagick support:
    # include CarrierWave::RMagick
    # include CarrierWave::MiniMagick

    # Choose what kind of storage to use for this uploader:
    if Rails.application.config.enable_s3
      storage :fog
    else
      storage :file
    end

    # Override the directory where uploaded files will be stored.
    # This is a sensible default for uploaders that are meant to be mounted:
    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

    # Add a white list of extensions which are allowed to be uploaded.
    # For images you might use something like this:
    def extension_white_list
      %w[html htm pdf]
    end

    def self.mime_type_white_list
      types = ['text/html', 'application/pdf']
      types.join(', ')
    end
  end
end
