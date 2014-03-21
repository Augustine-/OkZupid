class Profile < ActiveRecord::Base
  belongs_to :user
  has_many :posts
  
  def generate_posts(id)
    Post.create(profile_id: id, prompt: "My self summary")
    Post.create(profile_id: id, prompt: "What I'm doing with my life")
    Post.create(profile_id: id, prompt: "Six things I couldn't live without")
    Post.create(profile_id: id, prompt: "On a typical Friday night I'm...")
  end
end
