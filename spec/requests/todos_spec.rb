RSpec.describe 'Todos API', type: :request do
  # Define list of Todos and an existing todo id
  let!(:todos) { create_list(:todo, 10) }
  let(:todo_id) { todos.first.id }

  # Test listing of todos
  describe 'list all todos (GET /todos)' do
    # Do an HTTP request before any of the following
    before { get '/todos' }

    it 'returns the list of todos' do
      expect(JSON.parse(response.body)).not_to be_empty
      expect(JSON.parse(response.body).size).to eq(10)
    end

    it 'returns with status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test retrieving an actual todo by id
  describe 'retrieve a specific todo (GET /todos/:id)' do
    # Do an HTTP request before any of the following
    before { get "/todos/#{todo_id}" }

    context 'when the todo exists' do
      it 'returns the todo' do
        expect(JSON.parse(response.body)).not_to be_empty
        expect(JSON.parse(response.body)["id"]).to eq(todo_id)
      end

      it 'returns with status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the todo does not exist' do
      let(:todo_id) { 1000 }

      it 'returns not found error message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end

      it 'returns with status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  # Test of creating a new todo
  describe 'creates a new todo (POST /todos)' do
    let(:todo_attributes) {{ title: "Homework", description: "Do the math homework" }}

    context 'when the request is valid' do
      before { post '/todos', params: todo_attributes }

      it 'returns the created todo' do
        expect(JSON.parse(response.body)).not_to be_empty
        expect(JSON.parse(response.body)["title"]).to eq("Homework")
      end

      it 'returns with status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is not valid' do
      let(:todo_attributes) {{ title: "Gardening" }}
      before { post '/todos', params: todo_attributes }

      it 'returns not found error message' do
        expect(response.body).to match(/Validation failed: Description can't be blank/)
      end

      it 'returns with status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  # Test of update a todo by id
  describe 'updates a todo (PUT /todos/:id)' do
    let(:todo_attributes) {{ title: "Cook" }}

    context 'when the record exists' do
      before { put "/todos/#{todo_id}", params: todo_attributes }

      it 'the todo gets updated' do
        expect(response.body).to be_empty
      end

      it 'returns with status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test of deleting a todo
  describe 'deletes a specified todo (DELETE /todos/:id)' do
    # Do an HTTP request before any of the following
    before { delete "/todos/#{todo_id}" }

    it 'returns with status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end