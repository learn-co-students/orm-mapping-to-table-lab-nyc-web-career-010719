

require_relative "../config/environment.rb"
class Student

  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id=1)
    @id = id
    @name = name
    @grade = grade
  end

  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL
    DB[:conn].execute(sql)
  end#end of create table

  def save
    sql = <<-SQL
    INSERT INTO students (name, grade)
    VALUES (?, ?)
    SQL
    DB[:conn].execute(sql, self.name, self.grade)
  end

  def self.create(name:, grade:)
  student = Student.new(name, grade)
  student.save
  student
end

def self.drop_table
  sql = <<-SQL
  DROP TABLE students
  SQL
  DB[:conn].execute(sql)
end

end
