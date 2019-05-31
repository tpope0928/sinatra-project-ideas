class AddClaimedProjectIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :claimed_project_id, :integer
  end
end
