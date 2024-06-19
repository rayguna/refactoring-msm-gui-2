# refactoring-msm-gui-1

Target: https://msm-gui.matchthetarget.com/

Lesson: https://learn.firstdraft.com/lessons/156-refactoring-msm-gui-2

Video: https://share.descript.com/view/wy5mgzsL2WX

Grade: https://grades.firstdraft.com/resources/14a6cc63-4260-483c-95ec-562a19b04e0f

(24 min) Resource: chapters.firstdraft.com - chpt. 43

Use the interactive app like the ERD tool. 

<hr>

Notes

1. Start out by calling the command rake sample_data to populate the table with data.

2. Within the models/movie.rb and character.rb we use Director.where or Movie.where to associate one table to another via foreign_key id.
3. (up to 5 min) We can alternatively create actor methods within the character.rb to encapsulate queries to join tables.
4. (6 min) Even better - use meta method.

The meta method simplifies the following encapsulated query which is used to join two tables:

```
#app/models/character.rb

  def movie
    key = self.movie_id

    matching_set = Movie.where({ :id => key })

    the_one = matching_set.at(0)

    return the_one
  end
```

The meta method replaces the above code into:

```
belongs_to(:movie, {:class_name => "Movie", :foregn_key => "movie_id"})
```

The above is the syntax for RUby 2.7. In Ruby 3, the syntax is:

```
belongs_to(:movie, class_name: "Movie", foreign_key: "movie_id")
```

(8 min) Test this change by visiting: https://redesigned-computing-machine-g54j6jv77gqcv9gv-3000.app.github.dev/actors/2

The syntax is:

```
belongs_to(:method name, class_name: "class_name", foreign_key: "foreign_key")
```

2. (13 min) **Amazing!** Active record can easily call a method from another table even without encapsulation, but using a shorthand one-liner syntax, such as: Character.joins(:movie.where("movies.year>1994")). This is the exraordinary power of Active record.

(14 min) **Even more amazing!** If you accidentally omit the class name when defining the table joins using the one-liner code, Ruby will assume that the class that you are joining to has the same name as the method name, so the above one-liner can simply be written in a simpler manner as:

```
belongs_to(:movie, foreign_key: "movie_id")
```

(16 min) Even simpler, as long as the foreign_key id contains the class name:

```
belongs_to(:movie)
```

3. In some cases, where the foreign key id does not contain the class name (when you have many-to-many relationships), the simple one-liner will now work.

(21 min) Within the class Director:

```
def characters
  my_id = self.id

  matching_set = Character.where({ :id => my_id })

  return  matching_characters
end 
```

In this case, the one liner would be of the form: has_many(:characters):

```
has_many(:movie, class_name: "Character", foreign_key: "character_id")
```

You can further simplify it into the following just like in the above:

```
has_many(:movie)
```

4. Let's apply it:

- class Movie (one to many) #models/movie.rb
```
has_many(:characters, class_name: "Character", foreign_key: "character_id")
```

- class Character(many to one) #models/character.rb
```
belongs_to(:movie)
```

Bottom line: 
- For one to many, use the method: has_many()
- For many to one, use the method: belongs_to()

5. (25 min) Using the interactive app to build table relationships. Direct relationship means one to many. Indirect means many to one.

6. There is another shorthand which includes iterating through each element:

```
  def filmography
    the_many = Array.new

    self.characters.each do |joining_record|
      destination_record = joining_record.movie

      the_many.push(destination_record)
    end

    return the_many
  end
  ```

Change the above to the shorthand notations into:

```
  #iterate through each character and join to movie.
  has_many(:filmography,through: :characters, source: :movie)
```

<hr>
