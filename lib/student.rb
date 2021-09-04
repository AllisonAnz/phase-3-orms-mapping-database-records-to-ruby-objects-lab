# Continue building our the Student Class of our app 
# help administrators keep track of their students 
# each student has two attributes a name & grade

class Student
  attr_accessor :id, :name, :grade

  # Creates a new instance with corresponding attributes and values
  def self.new_from_db(row)
    # create a new Student object given a row from the database
    new_student = self.new # same as running Student.new 
    new_student.id = row[0]
    new_student.name = row[1]
    new_student.grade = row[2]
    new_student 
  end

  # returns all student instances from the db
  # retrieve all the rows from the "Students" database
  # remember each row should be a new instance of the Student class
  def self.all
    sql = 
      <<-SQL 
        SELECT* FROM students 
      SQL

    DB[:conn].execute(sql).map do |row|
      self.new_from_db(row)
    end
  end

  # returns an instance of student that matches the name from the DB
  # accepts the name of a student 
  # run a SQL query to get the result from the database where the students name matches the name passed into the argument
  # take the result and create a new student instance using the .new_from_db
  def self.find_by_name(name)
    # find the student in the database given a name, return a new instance of the Student class
    sql = 
      <<-SQL 
        SELECT* FROM students 
        WHERE name = ?
        LIMIT 1
      SQL

      DB[:conn].execute(sql, name).map do |row|
        self.new_from_db(row)
      end.first
  end

  #----Methods from the first lab----------------------------
  # link: https://github.com/AllisonAnz/phase-3-orms-mapping-classes-to-database-tables-lab
  # save a student to the db
  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) 
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end
  
  # create the student table in the db
  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL

    DB[:conn].execute(sql)
  end

  # drop that table
  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end

  #---------More Methods------------------------------------
  # .all_students_in_grade_9 
  # return an array of all students in grade 9 
  def self.all_students_in_grade_9
    sql = <<-SQL 
      SELECT COUNT(*)
      FROM students 
      WHERE grade = 9;
    SQL

    DB[:conn].execute(sql).map do |row|
      self.new_from_db(row)
    end
  end

  # .students_below_12th_grade 
  # return an array of all students in 11 or below 
  def self.students_below_12th_grade
    sql = <<-SQL
      SELECT *
      FROM students
      WHERE grade < 12
    SQL

    DB[:conn].execute(sql).map do |row|
      self.new_from_db(row)
    end
  end

   def self.first_student_in_grade_10
    sql = <<-SQL
      SELECT *
      FROM students
      WHERE grade = 10
      ORDER BY students.id LIMIT 1
    SQL

    DB[:conn].execute(sql).map do |row|
      self.new_from_db(row)
    end.first
  end

   def self.first_X_students_in_grade_10(number)
    sql = <<-SQL
      SELECT *
      FROM students
      WHERE grade = 10
      ORDER BY students.id
      LIMIT ?
    SQL

    DB[:conn].execute(sql, number).map do |row|
      self.new_from_db(row)
    end
  end

  def self.all_students_in_grade_X(grade)
    sql = <<-SQL
      SELECT *
      FROM students
      WHERE grade = ?
      ORDER BY students.id
    SQL

    DB[:conn].execute(sql, grade).map do |row|
      self.new_from_db(row)
    end
  end
end
