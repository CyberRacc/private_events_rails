class AddStatusToInvitations < ActiveRecord::Migration[7.1]
  def change
    add_column :invitations, :status, :string, default: "pending"
  end
end
