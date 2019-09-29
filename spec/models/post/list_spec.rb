# frozen_string_literal: true

describe Post::List do
  let!(:user) { create(:user) }
  let!(:post) { create(:post, user: user, avg_score: 4) }
  let!(:post_next) { create(:post, user: user, avg_score: 5) }
  let!(:post_last) { create(:post, user: user, avg_score: 3) }

  context 'valid params' do
    it 'list create' do
      result = Post::List.new(top: 3).run

      expect(result.success?).to eq(true)
      expect(result.data.count).to eq(3)
      expect(result.data.first).to eq(post_next.attributes)
      expect(result.data.last).to eq(post_last.attributes)
    end
  end

  context 'invalid params' do
    it 'list does not create' do
      result = Post::List.new(top: '').run
      expect(result.fail?).to eq(true)
    end
  end
end
  