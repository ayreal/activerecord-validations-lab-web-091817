require 'pry'
class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, length: { minimum: 10 }
  validates :summary, length: { maximum: 100 }
  validates :category, inclusion: { in: ["Fiction", "Non-Fiction"] }
  validate  :is_clickbait?

  CLICKBAIT_PATTERNS = [
   /Won't Believe/i,
   /Secret/i,
   /Top [0-9]*/i,
   /Guess/i
 ]

 def is_clickbait?
   if CLICKBAIT_PATTERNS.none? { |pat| pat.match title }
     errors.add(:title, "must be clickbait")
   end
 end

  # def is_clickbait?
  #   #check the title of the post and see if it includes any of the buzzwords
  #   #binding.pry
  #   buzzwords = ["Won't Believe", "Secret", "Top", "Guess"]
  #   post_title = self.title
  #   if post_title != nil
  #     buzzwords.any? { |buzzword| post_title.include?(buzzword)}
  #   end
  # end
end
