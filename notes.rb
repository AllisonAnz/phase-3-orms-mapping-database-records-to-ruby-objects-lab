class Song 
    ....

    # convert what the db gives us into a Ruby object 
    # This method creates all the Ruby objects for the other methods
    # Since we're retrieving data from a db, we're using new 
    # WE don't need to create records 
    # With this method we're reading data from SQLite and temporarily representing that data in ruby
    def self.new_from_db(row)
      new_song = self.new  # self.new is the same as running Song.new
      new_song.id = row[0]
      new_song.name =  row[1]
      new_song.length = row[2]
      new_song  # return the newly created instance
    end 

     def self.all
        # return an array of rows from the db that matches our query 
        # iterate over each row and use the self.new_from_db method to create a new Ruby object for each row
        sql = <<-SQL
          SELECT *
          FROM songs
        SQL

        DB[:conn].execute(sql).map do |row|
          self.new_from_db(row)
        end
  
    # Similar to Song.all except we have to include a name in our SQL statement 
    # We use a ? where we want the name param to be passed in 
    # We include name as the second argument to the execute method
    def self.find_by_name(name)
        sql = <<-SQL
          SELECT *
          FROM songs
          WHERE name = ?
          LIMIT 1
        SQL
            
        DB[:conn].execute(sql, name).map do |row|
          self.new_from_db(row)
    # .first chained to the end block 
    # The return value of the .map method is an array 
    # we're simply grabbing the .first element from the returned array
    end.first
  end

end