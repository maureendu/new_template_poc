class AddEmployers < ActiveRecord::Migration[7.0]
  def change
    create_table :employers do |t|
      t.integer "tmp_employer_id", null: false
      t.string "client_slug", limit: 50, null: false
      t.boolean "enabled", null: false
    end

    add_reference :projects, :employer, foreign_key: true, null: false
    add_index :projects, [:external_id, :employer_id], unique: true
  end
end
