# frozen_string_literal: true

describe Api::PostsController do
  describe 'GET ip' do
    context 'product exist' do
      let!(:user) { create(:user) }
      let!(:user_next) { create(:user) }
      let!(:post) { create(:post, user: user, ip: '192.168.0.1') }
      let!(:post_next) { create(:post, user: user_next, ip: '192.168.0.1') }
      let!(:post_last) { create(:post, user: user, ip: '192.168.0.2') }

      context 'ip has many users' do
        it 'has a 200 status code' do
          get :ip
          expect(response.status).to eq(200)
        end

        it 'posts has be on page' do
          get :ip
          expect(json_response.first[:ip]).to eql post[:ip]
          expect(json_response.first[:users]).to eq([user.login, user_next.login])
        end
      end

      context 'ips has only one user' do
        let!(:post_next) { create(:post, user: user_next, ip: '192.168.0.3') }

        it 'has a 422 status code' do
          get :ip
          expect(response.status).to eq(422)
        end
      end
    end
  end

  describe 'POST create' do
    context 'post is valid' do
      context 'user does not exist' do
        let(:params) { { title: 'Title1', body: 'body1', ip: '192.168.0.1', login: 'login_new' } }

        it 'post create' do
          post :create, params: params
          expect(json_response[:title]).to eql params[:title]
        end

        it 'has a 200 status code' do
          post :create, params: params
          expect(response.status).to eq(200)
        end
      end

      context 'user exists' do
        let!(:user) { create(:user) }
        let(:params) { { title: 'Title1', body: 'body1', ip: '192.168.0.1', login: user.login } }

        it 'post create' do
          post :create, params: params
          expect(json_response[:title]).to eql params[:title]
        end

        it 'has a 200 status code' do
          post :create, params: params
          expect(response.status).to eq(200)
        end
      end
    end

    context 'post is not valid' do
      let(:params) { { title: '', body: 'body1', ip: '192.168.0.1', login: 'login_new' } }

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

  describe 'POST top' do
    let!(:user) { create(:user) }
    let!(:post_first) { create(:post, user: user, avg_score: 4) }
    let!(:post_next) { create(:post, user: user, avg_score: 5) }
    let!(:post_last) { create(:post, user: user, avg_score: 3) }
    let(:params) { { top: 2 } }

    context 'posts are founded' do
      it 'post on page' do
        post :top, params: params
        expect(json_response.first).to eql(title: post_next.title, body: post_next.body)
      end

      it 'has a 200 status code' do
        post :top, params: params
        expect(response.status).to eq(200)
      end
    end

    context 'top is empty' do
      let(:params) { nil }

      it 'post is not on page' do
        post :top, params: params
        expect(json_response[:data]).to eql nil
      end

      it 'has a 422 status code' do
        post :top, params: params
        expect(response.status).to eq(422)
      end
    end
  end
end
