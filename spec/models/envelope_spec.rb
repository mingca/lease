require 'spec_helper'

describe Lease::Envelope do
	let(:template) do
		Lease::Template.new(
			state: 'Illinois',
			html_file: fixture_file_upload(Rails.root.join('../fixtures/files/lease-illinois.html'), 'text/html')
		)
	end
	let(:user) { User.new(name: 'Ming', email: 'ming@ckdtech.co') }
	let(:envelope) { described_class.new(template: template, envelopable: user, signable: user) }
	let(:vars) do
		{
			facility_state: 'Illinois',
			facility_zip: '62462'
		}
	end

	it 'should created envelope' do
		expect(envelope).to be_valid
		envelope.save
		expect(envelope.status).to eq('unsigned')
	end
	
	it 'should invalid without envelopable' do
		envelope.envelopable = nil
		expect(envelope).to be_invalid
	end

	it 'should invalid without signable' do
		envelope.signable = nil
		expect(envelope).to be_invalid
	end

	context 'interpolation' do
		
		it 'should return unsigned_html' do
			expected_string = '<span id="facility_state">Illinois</span> <span id="facility_zip">62462</span>'
			expect(envelope.unsigned_html(vars)).to include(expected_string)
		end

	end

	context 'generate_pdf' do

		it 'should generate and yield pdf without signature' do
			envelope.with_unsigned_pdf(vars) do |temp_pdf|
				expect(temp_pdf).to be_present
				expect(temp_pdf).to be_kind_of(File)
			end
		end

		it 'should generate tenant signed pdf' do
			envelope.sign(vars)
			expect(envelope.signed_pdf).to be_present
		end
	end
end
