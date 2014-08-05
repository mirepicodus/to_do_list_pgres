require 'task'
require 'pg'
require 'rspec'
require 'spec_helper'

describe Task do
  it 'is initialized with a name and list id' do
    task = Task.new('learn SQL',1,'1969-05-01')
    expect(task).to be_a Task
  end

  it 'tells you its name and list id' do
    task = Task.new('learn SQL',1,'1969-05-01')
    expect(task.name).to eq 'learn SQL'
  end

  it 'starts off with no tasks' do
    expect(Task.all).to eq []
  end

  it 'lets you save tasks to the database' do
    task = Task.new('learn SQL',1,'1969-05-01')
    task.save
    expect(Task.all).to eq [task]
  end

  it 'is the same task if it has the same name and ID' do
    task1 = Task.new('learn SQL', 1,'1969-05-01')
    task2 = Task.new('learn SQL', 1,'1969-05-01')
    expect(task1).to eq task2
  end

  it 'deletes itself from the database' do
    task = Task.new('learn SQL', 1,'1969-05-01')
    task.save
    task.delete
    expect(Task.all).to eq []
  end

  it 'marks tasks done without deleting them' do
    task = Task.new('learn SQL', 1,'1969-05-01')
    task.save
    task.mark_done
    expect(Task.all[0].done).to eq 't'
  end

  it 'allows user to enter due date' do
    task = Task.new('learn sql', 1, '1969-05-01')
    task.save
    expect(task.date).to eq '1969-05-01'
  end

end
