class ProjectIdea < ActiveRecord::Base

  belongs_to :user
  belongs_to :claimed_user, :class_name => :User, :foreign_key => :claimed_user_id


  def formatted_created_at
    self.created_at.strftime("%A, %d %b %Y %l:%M %p")
  end

end
