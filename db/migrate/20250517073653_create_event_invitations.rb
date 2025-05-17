class CreateEventInvitations < ActiveRecord::Migration[8.0]
  def change
    create_table :event_invitations do |t|
      t.references :invited_event, null: false, foreign_key: { to_table: :events }, index: true
      t.references :guest_invited, null: false, foreign_key: { to_table: :users }, index: true

      t.timestamps
    end
  end
end
