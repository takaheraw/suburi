require 'swagger_helper'

describe 'Users API' do

  path '/users/{id}' do

    get 'Retrieves a user' do
      tags        'Users'
      description 'Retrieves a specific user by id'
      produces    'application/json'
      security    [ apiKey: [] ]
      parameter   name: :id, in: :path, type: :integer, description: 'USER ID'

      response '200', 'user found' do
        schema type: :object,
          properties: {
            id:    { type: :integer },
            email: { type: :string  },
            role:  { type: :string  },
          },
          required: [ 'id', 'email', 'role' ]

        run_test!
      end
    end

  end

end
