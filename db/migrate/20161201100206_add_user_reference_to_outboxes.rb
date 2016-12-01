class AddUserReferenceToOutboxes < ActiveRecord::Migration[5.0]
  def change
    add_reference :outboxes, :user, index: true, foreign_key: true
  end
end
