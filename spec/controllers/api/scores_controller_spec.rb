# frozen_string_literal: true

describe Api::ScoresController do
  describe 'POST create' do
    let!(:user) { create(:user) }
    let!(:post_first) { create(:post, user: user) }

    context 'valid params' do
      let(:params) { { post_id: post_first.id, level: 3 } }

      it 'score create' do
        post :create, params: params
        post_update = Post.find_by(id: post_first.id)
        expect(json_response).to eql post_update.avg_score
      end

      it 'has a 200 status code' do
        post :create, params: params
        expect(response.status).to eq(200)
      end
    end

    context 'invalid params' do
      let(:params) { { post_id: post_first.id, level: '' } }

      it 'return errors' do
        post :create, params: params
        expect(json_response[:errors]).not_to be_empty
      end

      it 'post not create' do
        post :create, params: params
        expect(json_response[:name]).to eql nil
      end

      it 'has a 422 status code' do
        post :create, params: params
        expect(response.status).to eq(422)
      end
    end
  end
end
