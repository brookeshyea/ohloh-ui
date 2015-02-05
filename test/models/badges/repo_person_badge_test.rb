require 'test_helper'

class RepoPersonBadgeTest < ActiveSupport::TestCase
  let(:user) do
    account = create(:account)
    Edit.create!(target_type: 'Enlistment', target_id: 1, key: nil, account_id: account.id)
    account
  end

  let(:repo_person_badge) { RepoPersonBadge.new(user) }

  describe 'eligibility_count' do
    it 'should return account enlistment edits' do
      repo_person_badge.eligibility_count.must_equal 1
    end
  end

  describe 'short_desc' do
    it 'should return string' do
      repo_person_badge.short_desc.must_equal 'edits project repositories'
    end
  end

  describe 'name' do
    it 'should return name' do
      repo_person_badge.name.must_equal 'Repo Man/Woman'
    end
  end

  describe 'level_limits' do
    it 'should return limits' do
      repo_person_badge.level_limits.must_equal [1, 5, 15, 35, 70, 110, 200, 500, 1000, 2000, 4000, 10_000]
    end
  end

  describe 'position' do
    it 'should return 20' do
      repo_person_badge.position.must_equal 20
    end
  end
end
