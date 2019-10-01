# frozen_string_literal: true

describe Score::Creator do
  let!(:user) { create(:user) }
  let!(:post) { create(:post, user: user) }

  context "valid params" do
    let(:params) { { post_id: post.id, level: 3 } }

    it "score create" do
      expect do
        result = Score::Creator.new(params).run
        expect(result.success?).to eq(true)
      end.to change(Score, :count).by(1)
      score_last = Score.last
      post_upd = Post.find_by(id: post.id)
      expect(score_last.post_id).to eq(params[:post_id])
      expect(post_upd.avg_score).to eq(params[:level])
      expect(post_upd.score_count).to eq(1)
    end

    it "post_update with score create" do
      # let!(:score) { { post_id: post.id, level: 5 } }
      score = Score::Creator.new(params)
      score.post_update!
      post_update = Post.find_by(id: score.post_id)
      expect(post_update.avg_score).not_to eq(post.avg_score)
    end
  end

  context "invalid params" do
    let(:params) { { post_id: post.id, level: "" } }

    it "score does not create" do
      expect do
        result = Score::Creator.new(params).run
        expect(result.fail?).to eq(true)
      end.not_to change(Score, :count)
    end
  end
end
