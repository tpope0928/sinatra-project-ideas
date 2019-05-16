class AddStatusToProjectIdeas < ActiveRecord::Migration
  def change
    add_column :project_ideas, :status, :boolean, :default => false
  end
end
