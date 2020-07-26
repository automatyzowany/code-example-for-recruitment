require 'rails_helper'

RSpec.describe 'TaskCreator' do
  it 'should create a task in the Test board' do
    params = { data: {'0'=>{ order: 1, name: 'testtask', task_deadline: '', task_status: 'Nie przypisano', board_id: '17', user_id: '2', task_group: ''}}, board_id: '17', user_id: '2'}
    board = create(:board)
    user = create(:user)
    result = TaskManager::TaskCreator.call(params, board)

    expect(Test.where(name: 'testtask')).to be_present
    expect(result).to be_present
  end

  it 'should not create a task without a name' do
    params = { data: {'0'=>{ order: 1, task_deadline: '', task_status: 'Nie przypisano', board_id: '17', user_id: '2', task_group: ''}}, board_id: '17', user_id: '2'}
    board = create(:board)
    user = create(:user)
    result = TaskManager::TaskCreator.call(params, board)

    expect(result).to be_falsey
  end
end
