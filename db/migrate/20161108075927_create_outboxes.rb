class CreateOutboxes < ActiveRecord::Migration[5.0]
  def change
    create_table :outboxes do |t|
      t.string :message_type
      t.string :mobile_number
      t.string :shortcode
      t.string :message_id
      t.string :message
      t.string :client_id
      t.string :secret_key

      t.timestamps
    end
  end
end
