require 'rails_helper'

RSpec.describe 'Things', type: :request do
  describe 'GET /things' do
    it 'returns all Things' do
      thing = FactoryBot.create(:thing)

      get '/things'

      expect(parsed_response.length).to eq(1)
      expect(parsed_response.first).to include(
        'id' => thing.id,
        'name' => thing.name
      )
    end
  end

  describe 'POST /thing' do
    context 'when valid params' do
      it 'returns a newly created Thing' do
        creature_name = Faker::Games::Myst.creature

        expect {
          post '/things', params: { name: creature_name }
        }.to change(Thing, :count).by(1)

        expect(parsed_response.keys).to eq(%w[id name created_at updated_at])
        expect(parsed_response['name']).to eq(creature_name)
      end
    end

    context 'when invalid params' do
      it 'does not create a Thing' do
        creature_name = Faker::Games::Myst.creature

        expect {
          post '/things', params: { bad: creature_name }
        }.to raise_error(ActiveRecord::NotNullViolation)
      end
    end
  end

  describe 'GET /things/:id' do
    let(:thing) { FactoryBot.create(:thing) }

    context 'when a valid :id is passed' do
      it 'returns the associated Thing' do
        get "/things/#{thing.id}"

        expect(parsed_response).to eq(thing.as_json)
      end
    end

    context 'when an invalid :id is passed' do
      it 'returns :not_found' do
        bad_id = 'abcdef'

        get "/things/#{bad_id}"

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'PUT /things/:id' do
    let(:thing) { FactoryBot.create(:thing) }

    context 'when a valid :id is passed' do
      context 'when valid Thing params are passed' do
        it 'updates a Thing' do
          new_thing_name = 'new_thing_name'

          put "/things/#{thing.id}", params: { name: new_thing_name }
          thing.reload

          expect(thing.name).to eq(new_thing_name)
        end
      end

      context 'when invalid Thing params are passed' do
        it 'does not update a Thing' do
          new_thing_name = 'new_thing_name'
          original_name = thing.name

          put "/things/#{thing.id}", params: { bad_attr: new_thing_name }
          thing.reload

          expect(thing.name).to eq(original_name)
        end
      end
    end

    context 'when an invalid :id is passed' do
      it 'returns :not_found' do
        bad_id = '123abcdef'
        original_name = thing.name
        new_thing_name = 'new_thing_name'

        put "/things/#{bad_id}", params: { name: new_thing_name }
        thing.reload

        expect(response).to have_http_status(:not_found)
        expect(thing.name).to eq(original_name)
      end
    end
  end

  describe 'DELETE /things/:id' do
    let!(:thing) { FactoryBot.create(:thing) }

    context 'when a valid :id is passed' do
      it 'deletes a Thing' do
        expect {
          delete "/things/#{thing.id}"
        }.to change(Thing, :count).by(-1)
      end
    end

    context 'when an invalid :id is passed' do
      it 'returns :not_found' do
        bad_id = 'abcdef123456'

        expect {
          delete "/things/#{bad_id}"
        }.to change(Thing, :count).by(0)

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
