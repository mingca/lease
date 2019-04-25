Lease.setup do |config|

	# Tenant sign span id ( This is used to find the sign area in the document and fill in the tenant full name)
	config.lessee_sign_key = :occupant_name_2

end
FileUtils.mkdir_p "#{Rails.root}/tmp/pdf_lease_documents"