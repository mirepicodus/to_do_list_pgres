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
end
