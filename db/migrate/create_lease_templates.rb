class CreateLeaseTemplates < ActiveRecord::Migration[5.1]
  def change
    create_table :lease_templates do |t|
      t.string :state
      t.string :html_file
    end
  end
end
