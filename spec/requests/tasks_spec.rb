# spec/requests/tasks_spec.rb
require 'rails_helper'

RSpec.describe 'tasks API', type: :request do
  # initialize test data 
  let(:user) { create(:user) }
  let!(:tasks) { create_list(:task, 10, user: user) }
  let(:task_id) { tasks.first.id }
  # authorize request
  let(:headers) { valid_headers }

  # Test suite for GET /tasks
  describe 'GET /tasks' do
    before { get '/tasks', params: {}, headers: headers }
    it 'returns tasks' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /tasks/:id
  describe 'GET /tasks/:id' do
    before { get "/tasks/#{task_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the task' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(task_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:task_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Task/)
      end
    end
  end

  # Test suite for POST /tasks
  describe 'POST /tasks' do
    # valid payload
    let(:valid_attributes) do  
      { 
        user_id: user.id,
        description: 'description',
        website: 'example.com',
        status: 'finished',
        expiration_date: Time.now
      }.to_json
    end

    context 'when the request is valid' do
      before { post '/tasks', params: valid_attributes, headers: headers }
      it 'creates a task' do
        expect(json['user_id']).to eq(user.id)
        expect(json['description']).to eq('description')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:valid_attributes) { { description: nil }.to_json }
      before { post '/tasks', params: valid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Description can't be blank, Website can't be blank/)
      end
    end
  end

  # Test suite for PUT /tasks/:id
  describe 'PUT /tasks/:id' do
    let(:valid_attributes) do
      { 
        description: 'description two',
        website: 'www.shopping.com',
        status: 'finished',
        expiration_date: Time.now
      }.to_json
    end

    context 'when the record exists' do
      before { put "/tasks/#{task_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /tasks/:id
  describe 'DELETE /tasks/:id' do
    before { delete "/tasks/#{task_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end