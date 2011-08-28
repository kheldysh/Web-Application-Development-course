class Exercise < ActiveRecord::Base

  def tag_with_square_brackets
    "[ #{self.tag} ]"
  end

end
