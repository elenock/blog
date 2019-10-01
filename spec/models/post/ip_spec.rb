# frozen_string_literal: true

describe Post::Ip do
  let!(:user) { create(:user) }
  let!(:user_next) { create(:user) }
  let!(:post) { create(:post, user: user, ip: "192.168.0.1") }
  let!(:post_next) { create(:post, user: user_next, ip: "192.168.0.1") }
  let!(:post_last) { create(:post, user: user, ip: "192.168.0.2") }

  context "ip has many users" do
    it "list_ip create" do
      result = Post::Ip.new.run
      expect(result.success?).to eq(true)
      expect(result.data.first[:ip]).to eq("192.168.0.1")
      expect(result.data.first[:users]).to eq([user.login, user_next.login])
    end
  end

  context "ip has one user" do
    let!(:post_next) { create(:post, user: user_next, ip: "192.168.0.3") }

    it "list_ip does not create" do
      result = Post::Ip.new.run
      expect(result.fail?).to eq(true)
    end
  end
end
