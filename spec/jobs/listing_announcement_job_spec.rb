require "spec_helper"

RSpec.describe ListingAnnouncementJob, type: :job do
  let(:community) { FactoryGirl.create(:community) }
  let(:article) { FactoryGirl.create(:article) }

  context '#perform' do
    context 'for twitter' do
      it 'trigger twitter announcement class' do
        ListingAnnouncementJob.new(rticle.id, :twitter).perform_now
        expect(Announcements::Twitter).to receive(:new).with(article.id, :twitter).and_call_original
      end

      context 'Disabled twitter announcement at Community' do
        community.update(:, false)
      end

    end
  end
end
