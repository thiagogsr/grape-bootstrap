require 'spec_helper'

describe GrapeBootstrap::PersonAPI do
  def app
    GrapeBootstrap::PersonAPI
  end

  describe 'GET /v1/people' do
    context 'when there are no people' do
      it 'returns an empty array' do
        get '/v1/people'

        expect(JSON.parse(last_response.body)).to eql []
      end
    end

    context 'when there are people' do
      let!(:person) { Person.create!({ name: 'Grape Bootstrap' }) }

      it 'returns all people' do
        get '/v1/people'

        expect(JSON.parse(last_response.body).count).to eql 1
      end
    end
  end

  describe 'GET /v1/person/:id' do
    let(:person) { Person.create!({ name: 'Grape Bootstrap' }) }

    it 'returns a person by id' do
      get "/v1/person/#{person._id}"

      expect(last_response.body).to eql person.to_json
    end
  end

  describe 'POST /v1/people' do
    context 'when name is present' do
      it 'create a person' do
        expect { post '/v1/people', name: 'Grape with MongoDB' }.to \
          change(Person, :count).by(1)
      end
    end

    context 'when name is not present' do
      it 'returns error' do
        post '/v1/people'

        expect(last_response.body).to eql({ error: 'name is missing' }.to_json)
      end
    end
  end

  describe 'PUT /v1/person/:id' do
    let(:person) { Person.create!({ name: 'Grape Bootstrap' }) }

    context 'when id and name are present' do
      it 'update the person' do
        put "/v1/person/#{person._id}", name: 'Grape running with Rack'

        expect(last_response.body).to be_truthy
      end
    end

    context 'when id is not present' do
      it 'returns error' do
        put "/v1/person/", name: 'Grape running with Rack'

        expect(last_response.body).to eql 'Not Found'
      end
    end

    context 'when name is not present' do
      it 'returns error' do
        put "/v1/person/#{person._id}"

        expect(last_response.body).to eql({ error: 'name is missing' }.to_json)
      end
    end
  end

  describe 'DELETE /v1/person/:id' do
    let(:person) { Person.create!({ name: 'Grape Bootstrap' }) }

    context 'when id is present' do
      it 'destroy the user' do
        delete "/v1/person/#{person._id}"

        expect(last_response.body).to be_truthy
      end
    end

    context 'when id is not present' do
      it 'destroy the user' do
        delete "/v1/person/"

        expect(last_response.body).to eql 'Not Found'
      end
    end
  end
end