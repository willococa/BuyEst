class AddUidToAdmins < ActiveRecord::Migration[7.0]
  def change
    add_column :admins, :uid, :string
    add_index :admins, :uid, :unique =>  true

    # Set a default value for existing admins
    Admin.find_each do |admin|
      admin.update(uid: SecureRandom.uuid)
    end

    # Set a default value for new admins
    change_column_default :admins, :uid, from: nil, to: "'#{SecureRandom.uuid}'"
  end
end
