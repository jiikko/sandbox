require 'swagger_helper'

RSpec.describe 'api/v1/todos', type: :request do
  let(:Authorization) { 'Barer abcdefg123456' } ############### 追加

  describe 'GET #index' do
    it 'returns a success response' do
      get '/api/v1/todos', headers: { Authorization: 'Barer abcdefg123456' }
      expect(response).to have_http_status(:success)
    end
  end

  path '/api/v1/todos' do
    get 'get todo list' do
      consumes 'application/json'
      produces 'application/json'
      security [Bearer: {}]
      response 200, 'todo list' do
        schema type: :array, items: {
          type: :object,
          properties: {
            name: { type: :string },
            done: { type: :boolean },
          },
          required: [:name, :done]
        }
        run_test!
      end
    end
  end
end

