class Task

  attr_accessor :name, :list_id, :date, :done
  def initialize(name, list_id, date =nil, done=false)
    @name = name
    @list_id = list_id
    @done = done
    @date = date
  end

  def self.all
    results = DB.exec("SELECT * FROM tasks;")
    tasks = []
    results.each do |result|
      name = result['name']
      list_id = result['list_id'].to_i
      done = result['done']
      date = result['date']
      tasks << Task.new(name, list_id, date, done)
    end
    tasks
  end

  def save
    if date == nil
      DB.exec("INSERT INTO tasks (name, list_id, date, done) VALUES ('#{@name}', #{@list_id}, NULL, 'f');")
    else
      DB.exec("INSERT INTO tasks (name, list_id, date, done) VALUES ('#{@name}', #{@list_id}, '#{@date}', 'f');")
    end
  end

  def delete
    DB.exec("DELETE FROM tasks WHERE name='#{@name}';")
  end

  def mark_done
    DB.exec("UPDATE tasks SET done = 'true' WHERE name = '#{name}'")
  end

  def ==(another_task)
    self.name == another_task.name && self.list_id == another_task.list_id
  end

end
