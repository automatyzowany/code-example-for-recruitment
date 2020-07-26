require 'rails_helper'

RSpec.describe 'TaskDestroyer' do
  it 'should destroy the task' do
    params = { data: {"701"=>{ DT_RowId: "701", task_timer: "00:00:00", order: "6", name: "sdvsdv2", task_deadline: "", task_status: "Nie przypisano", board_id: "17", task_group: "", created_at: "2020-07-06T14:24:19.246+02:00", updated_at: "2020-07-17T10:21:57.248+02:00"}}, triggeredRow: "", board_id: "17", id: "701"}
    board = create(:board)
    user = create(:user)
    task = create(:test)
    result = TaskManager::TaskDestroyer.call(params, board)

    expect(result).to be_empty
  end

  it 'should destroy an update if update exists' do
    params = { data: {"701"=>{ DT_RowId: "701", task_timer: "00:00:00", order: "6", name: "sdvsdv2", task_deadline: "", task_status: "Nie przypisano", board_id: "17", task_group: "", created_at: "2020-07-06T14:24:19.246+02:00", updated_at: "2020-07-17T10:21:57.248+02:00"}}, triggeredRow: "", board_id: "17", id: "701"}
    board = create(:board)
    user = create(:user)
    task = create(:test)
    update = create(:update)
    result = TaskManager::TaskDestroyer.call(params, board)

    expect(Update.find(343).deleted_at).to be_present 
  end
end
