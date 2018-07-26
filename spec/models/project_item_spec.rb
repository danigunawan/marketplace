# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProjectItem do
  it { should validate_presence_of(:service) }
  it { should validate_presence_of(:project) }
  it { should validate_presence_of(:status) }

  it { should belong_to(:project) }
  it { should belong_to(:service) }
  it { should have_many(:project_item_changes).dependent(:destroy) }

  describe "#new_change" do
    it "change is not created when no message and status is given" do
      project_item = create(:project_item)

      expect { project_item.new_change }.to_not change { ProjectItemChange.count }
    end

    it "change project_item status" do
      project_item = create(:project_item, status: :created)

      project_item.new_change(status: :registered, message: "ProjectItem registered")
      project_item_change = project_item.project_item_changes.last

      expect(project_item).to be_registered
      expect(project_item_change).to be_registered
      expect(project_item_change.message).to eq("ProjectItem registered")
    end

    it "does not change status when only message is given" do
      project_item = create(:project_item, status: :created)

      project_item.new_change(message: "some update")
      project_item_change = project_item.project_item_changes.last

      expect(project_item).to be_created
      expect(project_item_change).to be_created
      expect(project_item_change.message).to eq("some update")
    end

    it "set change author" do
      project_item = create(:project_item, status: :created)
      author = create(:user)

      project_item.new_change(message: "update", author: author)
      project_item_change = project_item.project_item_changes.last

      expect(project_item_change.author).to eq(author)
    end
  end

  describe "#active?" do
    it "is true when processing is not done" do
      expect(build(:project_item, status: :created)).to be_draft
      expect(build(:project_item, status: :registered)).to be_draft
      expect(build(:project_item, status: :in_progress)).to be_draft
    end

    it "is false when processing is done" do
      expect(build(:project_item, status: :ready)).to_not be_draft
      expect(build(:project_item, status: :rejected)).to_not be_draft
      expect(build(:project_item, status: :deactivated)).to_not be_draft
    end
  end
end
