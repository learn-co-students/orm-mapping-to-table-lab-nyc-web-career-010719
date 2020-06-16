class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_accessor :name,:grade
  attr_reader :id

  def initialize( name,grade,id=nil)
    @name = name
    @grade = grade
    @id = id
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
  end

  def self.drop_table
    sql = <<-SQL
    DROP TABLE students;

    SQL
    DB[:conn].execute(sql)
  end

  def save
  sql = <<-SQL
    INSERT INTO students (name, grade)
    VALUES (?, ?)
  SQL

  DB[:conn].execute(sql, self.name, self.grade)
  sql = <<-SQL
    SELECT id
    FROM students
    ORDER BY id DESC LIMIT 1
    SQL
   last_id= DB[:conn].execute(sql).flatten
  # binding.pry
  @id = last_id[0]
  end

  def  self.create (args = {})
    # sql = <<-SQL
    # CREATE TABLE IF NOT EXISTS students (
    #     id INTEGER PRIMARY KEY,
    #     name TEXT,
    #     grade TEXT
    #     )
    # SQL
    s = Student.new(args[:name],args[:grade])
    s.save
    s
    # DB[:conn].execute(sql)
  end



end
