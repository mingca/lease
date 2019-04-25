require 'wicked_pdf'

module Lease
  class Envelope < ::ActiveRecord::Base

    mount_uploader :signed_pdf, ::Lease::DocumentUploader

    belongs_to :template
    belongs_to :envelopable, polymorphic: true
    belongs_to :signable, polymorphic: true

    enum status: [:unsigned, :rejected, :signed]

    def unsigned_html(vars)
      interpolate(with_blank_sign(vars))
    end

    def with_unsigned_pdf(vars, &block)
      with_generate_pdf(unsigned_html(vars), &block)
    end

    def sign(vars)
      return false if signed?

      html = interpolate(with_sign(vars))
      with_generate_pdf(html) do |temp_pdf|
        update(signed_pdf: temp_pdf)
      end
    end

    private

      def with_generate_pdf(html, &block)
        random = SecureRandom.hex(4)
        pdf_string = WickedPdf.new.pdf_from_string(html, extra: '--enable-forms')
        pdf_file_name = Rails.root.join('tmp', 'pdf_lease_documents', "pdf-lease-#{envelopable.id}-#{random}.pdf")
        pdf_file = File.new(pdf_file_name, 'a+:ASCII-8BIT')
        pdf_file.write(pdf_string)

        yield pdf_file

        File.delete(pdf_file_name)
      end

      def interpolate(vars)
        page = Nokogiri::HTML(template.html_file.read)
        vars.each do |id, value|
          span = page.at_css("[id=\"#{id}\"]")
          span.content = value
        end
        page.to_html
      end

      def with_blank_sign(vars)
        vars.merge(Lease.config.lessee_sign_key => '')
      end

      def with_sign(vars)
        vars.merge(Lease.config.lessee_sign_key => signable.full_name)
      end

  end
end
