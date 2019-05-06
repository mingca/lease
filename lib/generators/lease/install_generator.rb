module Lease
  module Generators
    class InstallGenerator < Rails::Generators::Base

      source_root File.expand_path('../../../../', __FILE__)

      desc 'Install Lease'

      def copy_uploader
        copy_file 'app/uploaders/lease/document_uploader.rb', Rails.root.join('app', 'uploaders', 'lease', 'document_uploader.rb')
      end

      def copy_migrations
        copy_migration 'create_lease_envelopes'
        copy_migration 'create_lease_templates'
      end

      def copy_initializer
        create_file Rails.root.join('config', 'initializers', 'lease.rb'), <<-CONTENT
Lease.setup do |config|

  # Tenant sign span id ( This is used to find the sign area in the document and fill in the tenant full name)
  config.lessee_sign_key = :tenant_full_name

end

FileUtils.mkdir_p "#{Rails.root}/tmp/pdf_lease_documents"
CONTENT
      end

      protected

        def copy_migration(filename)
          if migration_exists?(Rails.root.join('db', 'migrate'), filename)
            say_status('skipped', "Migration #{filename}.rb already exists")
          else
            copy_file "db/migrate/#{filename}.rb", Rails.root.join('db', 'migrate', "#{migration_number}_#{filename}.rb")
          end
        end

        def migration_exists?(dirname, filename)
          Dir.glob("#{dirname}/[0-9]*_*.rb").grep(/\d+_#{filename}.rb$/).first
        end

        def migration_id_exists?(dirname, id)
          Dir.glob("#{dirname}/#{id}*").length > 0
        end

        def migration_number
          @migration_number ||= Time.now.strftime("%Y%m%d%H%M%S").to_i

          while migration_id_exists?(Rails.root.join('db', 'migrate'), @migration_number) do
            @migration_number += 1
          end

          @migration_number
        end

    end
  end
end
