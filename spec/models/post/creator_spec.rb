# frozen_string_literal: true

describe Post::Creator do
  context 'valid params' do
    let!(:user) { create(:user) }
    let(:params) do
      { title: 'test_title',
        body: 'test_body',
        ip: '192.168.0.1',
        login: user.login }
    end

    context 'user exist' do
      it 'post create' do
        expect do
          result = Post::Creator.new(params).run
          expect(result.success?).to eq(true)
        end.to change { Post.count }.by(1)
        product_last = Post.last
        expect(product_last.title).to eq(params[:title])
        expect(product_last.body).to eq(params[:body])
        expect(product_last.ip).to eq(params[:ip])
        expect(product_last.user_id).to eq(user.id)
      end
    end

    context 'user does not exist' do
      let(:params) do
        { title: 'test_title',
          body: 'test_body',
          ip: '192.168.0.1',
          login: " #{user.login} test1" }
      end
      it 'post and user create' do

        expect do
          result = Post::Creator.new(params).run
          expect(result.success?).to eq(true)
        end.to change { Post.count && User.count}.by(1)
        product_last = Post.last
        expect(product_last.title).to eq(params[:title])
        expect(product_last.body).to eq(params[:body])
        expect(product_last.ip).to eq(params[:ip])
        expect(product_last.user_id).to eq(User.find_by(login: params[:login]).id)
      end
    end
  end

  context 'invalid params' do
    let(:params) do
      { title: '',
        body: 'test_body',
        ip: '192.168.0.1',
        login: 'user.login' }
    end

    it 'post does not create' do
      expect do
        result = Post::Creator.new(params).run
        expect(result.fail?).to eq(true)
      end.not_to change { Post.count }
    end
  end
end
