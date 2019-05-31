class User < ActiveRecord::Base
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true

  has_many :project_ideas
  has_one :claimed_project, :class_name => :ProjectIdea, :foreign_key => :claimed_user_id

end
