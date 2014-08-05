require 'rspec'
require 'pg'
require 'list'
require 'spec_helper'

describe List do
  it 'is initialized with a name' do
    list = List.new('Epicodus stuff')
    expect(list).to be_a List
  end

  it 'tells you its name' do
    list = List.new('Epicodus stuff')
    expect(list.name).to eq 'Epicodus stuff'
  end

  it 'is the same list if it has the same name' do
    list1 = List.new('Epicodus stuff')
    list2 = List.new('Epicodus stuff')
    expect(list1).to eq list2
  end

  it 'starts off with no lists' do
    expect(List.all).to eq []
  end

  it 'lets you save lists to the database' do
    list = List.new('learn SQL')
    list.save
    expect(List.all).to eq [list]
  end

  it 'sets its ID when you save it' do
    list = List.new('learn SQL')
    list.save
    expect(list.id).to be_a Fixnum
  end

  it 'can be initialized with its database ID' do
    list = List.new('Epicodus stuff', 1)
    expect(list).to be_a List
  end

  it 'lists all tasks in a given list' do
    list= List.new('Epicodus stuff2')
    list.save
    task = Task.new('do homework',list.id, '1969-05-01')
    task1 = Task.new('clean dishes',list.id, '1969-05-01')
    task.save
    task1.save
    expect(list.tasks).to eq [task,task1]
  end

  it 'deletes list and all tasks assosiated with list' do
    list = List.new('Epicodus stuff')
    list.save
    task = Task.new('do homework',list.id,'1969-05-01')
    task1 = Task.new('clean dishes',list.id,'1969-05-01')
    task.save
    task1.save
    list.delete
    expect(List.all).to eq []
    expect(Task.all).to eq []
  end

  it 'sorts tasks by due date asc' do
    list = List.new('Epicodus stuff')
    list.save
    task = Task.new('do homework',list.id,'1970-05-01')
    task1 = Task.new('clean dishes1',list.id,'1975-05-01')
    task2 = Task.new('clean dishes2',list.id,'1969-05-01')
    task.save
    task1.save
    task2.save
    expect(list.sort_tasks_by_date_asc).to eq [task2, task, task1]
  end

  it 'sorts tasks by due date desc' do
    list = List.new('Epicodus stuff')
    list.save
    task = Task.new('do homework',list.id,'1970-05-01')
    task1 = Task.new('clean dishes1',list.id,'1975-05-01')
    task2 = Task.new('clean dishes2',list.id,'1969-05-01')
    task.save
    task1.save
    task2.save
    expect(list.sort_tasks_by_date_desc).to eq [task1, task, task2]
  end
end
