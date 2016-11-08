class CreateInboxes < ActiveRecord::Migration[5.0]
  def change
    create_table :inboxes do |t|
    	
    	t.string :message_type
    	t.string :mobile_number
    	t.string :shortcode
    	t.string :request_id
    	t.string :message
    	t.string :timestamp  

      t.timestamps
    end
  end
end
