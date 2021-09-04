require 'sqlite3'
require_relative '../lib/student'

DB = {:conn => SQLite3::Database.new("db/students.db")}

# student = Student.create(name: "Elvis", grade: "9th")
# p student #=> #<Student:0x00007fffc2248af0 @id=4, @name="Elvis", @grade="9th">
# puts student.name #=> Elvis
# puts student.grade #=> 9th

pat = Student.new
pat.id = 1
pat.name = "Pat"
pat.grade = "12"
