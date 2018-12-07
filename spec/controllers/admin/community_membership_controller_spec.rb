require 'spec_helper'

describe Admin::CommunityMembershipsController, type: :controller do
  let(:community) { FactoryGirl.create(:community) }
  let(:person1) { FactoryGirl.create(:person, member_of: community) }
  let(:person2) { FactoryGirl.create(:person, member_of: community) }

  before(:each) do
    @request.host = "#{community.ident}.lvh.me"
    @request.env[:current_marketplace] = community
    user = create_admin_for(community)
    sign_in_for_spec(user)
  end

  describe "#index" do
    it 'works' do
      person1
      person2
      get :index, params: {community_id: community.id}
      service = assigns(:service)
      memberships = service.memberships
      expect(memberships.size).to eq 3
    end

    it 'filters admin' do
      person1
      person2
      get :index, params: {community_id: community.id, status: ['admin']}
      service = assigns(:service)
      memberships = service.memberships
      expect(memberships.size).to eq 1
    end

    it 'filters banned' do
      membership1 = person1.community_membership
      membership1.update_column(:status, 'banned')
      person2
      get :index, params: {community_id: community.id, status: ['banned']}
      service = assigns(:service)
      memberships = service.memberships
      expect(memberships.size).to eq 1
    end

    it 'filters posting_allowed' do
      membership1 = person1.community_membership
      membership1.update_column(:can_post_listings, true)
      person2
      get :index, params: {community_id: community.id, status: ['posting_allowed']}
      service = assigns(:service)
      memberships = service.memberships
      expect(memberships.size).to eq 1
    end

    it 'filters admin or banned' do
      person1
      membership1 = person2.community_membership
      membership1.update_column(:status, 'banned')
      get :index, params: {community_id: community.id, status: ['admin', 'banned']}
      service = assigns(:service)
      memberships = service.memberships
      expect(memberships.size).to eq 2
    end

    it 'filters admin or banned or posting_allowed' do
      membership1 = person1.community_membership
      membership1.update_column(:can_post_listings, true)
      membership1 = person2.community_membership
      membership1.update_column(:status, 'banned')
      get :index, params: {community_id: community.id, status: ['admin', 'banned', 'posting_allowed']}
      service = assigns(:service)
      memberships = service.memberships
      expect(memberships.size).to eq 3
    end
  end

  describe "#ban" do
    it 'works' do
      membership = person1.community_membership
      expect(membership.status).to eq 'accepted'
      get :ban, params: {community_id: community.id, id: membership.id}
      membership.reload
      expect(membership.status).to eq 'banned'
    end
  end

  describe "#unban" do
    it 'works' do
      membership = person1.community_membership
      membership.update_column(:status, 'banned')
      expect(membership.status).to eq 'banned'
      get :unban, params: {community_id: community.id, id: membership.id}
      membership.reload
      expect(membership.status).to eq 'accepted'
    end
  end

  describe "#promote_admin" do
    it 'works' do
      membership = person1.community_membership
      expect(membership.admin).to eq false
      get :promote_admin, params: {community_id: community.id, add_admin: person1.id}
      membership.reload
      expect(membership.admin).to eq true
      get :promote_admin, params: {community_id: community.id, remove_admin: person1.id}
      membership.reload
      expect(membership.admin).to eq false
    end
  end

  describe "#posting_allowed" do
    it 'works' do
      membership = person1.community_membership
      expect(membership.can_post_listings).to eq false
      get :posting_allowed, params: {community_id: community.id, allowed_to_post: person1.id}
      membership.reload
      expect(membership.can_post_listings).to eq true
      get :posting_allowed, params: {community_id: community.id, disallowed_to_post: person1.id}
      membership.reload
      expect(membership.can_post_listings).to eq false
    end
  end

  describe "#resend_confirmation" do
    let(:person_with_unconfirmed_email) do
      person = FactoryGirl.create(:person, member_of: community)
      email = person.emails.first
      email.update_column(:confirmed_at, nil)
      person.community_membership.update_column(:status, CommunityMembership::PENDING_EMAIL_CONFIRMATION)
      person
    end

    it 'works' do
      person = person_with_unconfirmed_email
      membership = person.community_membership
      ActionMailer::Base.deliveries.clear
      put :resend_confirmation, params: {community_id: community.id, id: membership.id}
      Delayed::Worker.new.work_off
      expect(ActionMailer::Base.deliveries.count).to eq 1
      delivered_email = ActionMailer::Base.deliveries.last
      expect(delivered_email.to).to eq [person.emails.first.address]
    end
  end
end
