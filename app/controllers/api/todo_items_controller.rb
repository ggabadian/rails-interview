module Api
  class TodoItemsController < ApplicationController
    protect_from_forgery with: :null_session

    # GET /api/todolists/:todo_list_id/todo_items
    def index
      @todo_list_items = TodoList.find(params.require(:todo_list_id)).todo_items

      respond_to :json
    end

    # PUT /api/todolists/:todo_list_id/todo_items/:id
    def update
      @todo_item = TodoList.find(params.require(:todo_list_id)).todo_items.find(params.require(:id))
      @todo_item.update!(update_params)
      respond_to :json
    end

    private

    def update_params
      params.require(:todo_item).permit(:name, :description, :completed)
    end
  end
end
