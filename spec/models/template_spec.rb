require 'spec_helper'

describe Lease::Template do

  it 'should created templates' do
    template = described_class.new(
      state: 'Illinois',
      html_file: fixture_file_upload(Rails.root.join('../fixtures/files/lease-illinois.html'), 'text/html')
    )
    expect(template.valid?).to be_truthy
  end
end
