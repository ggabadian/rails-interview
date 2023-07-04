require 'rails_helper'

describe Api::TodoItemsController do
  render_views

  describe 'GET index' do
    let!(:todo_list) { TodoList.create(name: 'Setup RoR project') }
    let!(:todo_item) { todo_list.todo_items.create!(name: :name, description: :desc, completed: false) }

    context 'when format is HTML' do
      it 'raises a routing error' do
        expect {
          get :index, params: {todo_list_id: todo_list.id}
        }.to raise_error(ActionController::RoutingError, 'Not supported format')
      end
    end

    context 'when format is JSON' do
      it 'returns a success code' do
        get :index, format: :json, params: {todo_list_id: todo_list.id}

        expect(response.status).to eq(200)
      end

      it 'includes todo list items records' do
        get :index, format: :json, params: {todo_list_id: todo_list.id}

        todo_list_items = JSON.parse(response.body)

        aggregate_failures 'includes the id and name' do
          expect(todo_list_items.count).to eq(1)
          expect(todo_list_items[0].keys).to match_array(['id', 'name', 'description', 'completed'])
          expect(todo_list_items[0]['id']).to eq(todo_item.id)
          expect(todo_list_items[0]['name']).to eq(todo_item.name)
          expect(todo_list_items[0]['completed']).to eq(todo_item.completed)
        end
      end
    end
  end
end
