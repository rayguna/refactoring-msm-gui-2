# == Schema Information
#
# Table name: characters
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  actor_id   :integer
#  movie_id   :integer
#
class Character < ApplicationRecord

  # def movie
  #   key = self.movie_id

  #   matching_set = Movie.where({ :id => key })

  #   the_one = matching_set.at(0)

  #   return the_one
  # end

  #one-liner and simpler
  #belongs_to(:movie, class_name: "Movie", foreign_key: "movie_id")

  #even simpler
  #belongs_to(:movie, foreign_key: "movie_id")

  #simplify even further
  belongs_to(:movie)

end
