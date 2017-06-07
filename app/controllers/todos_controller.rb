class TodosController < ApplicationController
    include JSONResponse
    include ExceptionHandler
    # Set @todo before the listed actions
    before_action :set_todo, except: [:index, :create]

    # CRUD methods for Todo
    def index
        @todos = Todo.all
        json_response(@todos)
    end

    def show
        json_response(@todo)
    end

    def create
        @todo = Todo.create!(todo_params)
        json_response(@todo)
    end

    def update
        @todo.update(todo_params)
        head :no_content
    end
    
    def destroy
        @todo.destroy
        head :no_content
    end
private
    def todo_params
        params.permit(:title, :description, :due_date, :checked)
    end
    def set_todo
        @todo = Todo.find(params["id"])
    end    
end
