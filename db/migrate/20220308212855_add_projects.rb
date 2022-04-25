class AddProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :bill_method, null: false
      t.integer :budgeted_hours
      t.string :close_reason
      t.datetime :deleted_at
      t.text :description, null: false
      t.string :external_id, limit: 50, null: false
      t.boolean :full_time, null: false
      t.json :locations
      t.integer :markup
      t.integer :number_of_roles, null: false
      t.string :preferred_experience_level
      t.boolean :project_based, null: false
      t.float :rate
      t.boolean :remote_ok, null: false
      t.integer :remote_percentage
      t.json :request_payload, null: false
      t.datetime :start_date, null: false
      t.string :title, null: false
      t.boolean :travel_required
    end
  end
end

