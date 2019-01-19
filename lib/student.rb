class Student

  attr_reader :id, :name, :grade

  def initialize(id= nil, name, grade)
    @name = name
    @grade = grade
  end

  def self.create_table
   sql =  <<-SQL
    CREATE TABLE IF NOT EXISTS students(
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade INTEGER
      )
   SQL
   DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
    DROP TABLE students
    SQL
  DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) VALUES (?, ?)
    SQL
  DB[:conn].execute(sql, self.name, self.grade).flatten
  @id = DB[:conn].execute("SELECT id FROM students WHERE id = (SELECT MAX(id) FROM students)")[0][0]
  end

  def self.create(name:, grade:)
    new_student = Student.new(name, grade)
    new_student.save
    new_student
  end

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

end
