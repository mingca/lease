require 'wicked_pdf'

module Lease
  class Envelope < ::ActiveRecord::Base

    mount_uploader :signed_pdf, ::Lease::DocumentUploader

    belongs_to :template, required: true
    belongs_to :envelopable, polymorphic: true, required: true
    belongs_to :signable, polymorphic: true, required: true

    enum status: [:unsigned, :rejected, :signed]

    def unsigned_html(vars)
      interpolate(with_blank_sign(vars))
    end

    def with_unsigned_pdf(vars, &block)
      with_generate_pdf(unsigned_html(vars), &block)
    end

    def sign(vars)
      return nil if signed?

      html = interpolate(vars)
      with_generate_pdf(html) do |temp_pdf|
        update(signed_pdf: temp_pdf, status: :signed)
      end
    end

    private

      def with_generate_pdf(html)
        random = SecureRandom.hex(4)
        pdf_string = WickedPdf.new.pdf_from_string(html, extra: '--enable-forms')
        pdf_file_name = Rails.root.join('tmp', 'pdf_lease_documents', "pdf-lease-#{envelopable.id}-#{random}.pdf")
        pdf_file = File.new(pdf_file_name, 'a+:ASCII-8BIT')
        pdf_file.write(pdf_string)

        result = yield pdf_file if block_given?
        File.delete(pdf_file_name)
        result
      end

      # TODO: check if any field in html has not been interpolated
      def interpolate(vars)
        page = Nokogiri::HTML(template.html_file.read)
        vars.each do |dom_id, value|
          spans = page.css("[id=\"#{dom_id}\"]")
          if spans.present?
            spans.each do |span|
              span.inner_html = value&.to_s&.html_safe || ""
            end
          else
            Rails.logger.info "Lease Envelope #{self.id}: dom id #{dom_id} not found in template"
          end
        end
        page.to_html
      end

      def with_blank_sign(vars)
        vars.merge(Lease.config.lessee_sign_key => '')
      end

  end
end
