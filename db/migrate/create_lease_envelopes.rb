class CreateLeaseEnvelopes < ActiveRecord::Migration[5.1]
  def change
    create_table :lease_envelopes do |t|
      t.integer :template_id
      t.integer :status, default: 0
      t.string :signed_pdf
      t.references :envelopable, polymorphic: true, index: { name: 'index_lease_envelopes_on_envelopable_type_and_id' }
      t.references :signable, polymorphic: true, index: { name: 'index_lease_envelopes_on_signable_type_and_id' }

      t.timestamps
    end
  end
end
