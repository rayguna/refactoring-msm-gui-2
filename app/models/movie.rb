# == Schema Information
#
# Table name: movies
#
#  id          :integer          not null, primary key
#  description :text
#  duration    :integer
#  image       :string
#  title       :string
#  year        :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  director_id :integer
#
class Movie < ApplicationRecord
  validates(:director_id, presence: true)
  validates(:title, uniqueness: true)

  
  # def characters
  #   my_id = self.id

  #   matching_set = Character.where({ :id => my_id })

  #   return  matching_characters
  # end

  #in the above, however, it is a one to many relationships. The function we use should be: 
  has_many(:characters, class_name:"Character", foreign_key:"character_id")


  # def director
  #   key = self.director_id

  #   matching_set = Director.where({ :id => key })

  #   the_one = matching_set.at(0)

  #   return the_one
  # end

  #simplify to:

  belongs_to(:director)

end
