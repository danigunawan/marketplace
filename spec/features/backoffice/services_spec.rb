# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Services in backoffice" do
  include OmniauthHelper

  let(:user) { create(:user, roles: [:service_owner]) }

  before { checkin_sign_in_as(user) }

  context "When browsing owned services" do
    scenario "I can see only owned services" do
      create(:service, title: "my service", owner: user)
      create(:service, title: "other owner service")

      visit backoffice_services_path

      expect(page).to have_content("my service")
      expect(page).to_not have_content("other owner service")
    end
  end

  context "Browsing services" do
    scenario "I can see my service" do
      service = create(:service, title: "my service", owner: user)

      visit backoffice_service_path(service)

      expect(page).to have_content("my service")
    end

    scenario "It is denied to see not owned service" do
      service = create(:service, title: "other owner service")

      visit backoffice_service_path(service)

      expect(page).to have_content("not authorized")
    end
  end

  scenario "I can create new service", js: true do
    provider = create(:provider)

    visit backoffice_services_path
    click_on "Create new service"

    fill_in "Title", with: "service title"
    fill_in "Description", with: "service description"
    fill_in "Terms of use", with: "service terms of use"
    fill_in "Tagline", with: "service tagline"
    fill_in "Service website", with: "https://sample.url"
    fill_in "Places", with: "Europe"
    fill_in "Languages", with: "English"
    fill_in "Dedicated for", with: "single researcher"
    fill_in "Terms of use url", with: "https://sample.url"
    fill_in "Access policies url", with: "https://sample.url"
    fill_in "Corporate sla url", with: "https://sample.url"
    fill_in "Webpage url", with: "https://sample.url"
    fill_in "Manual url", with: "https://sample.url"
    fill_in "Helpdesk url", with: "https://sample.url"
    fill_in "Tutorial url", with: "https://sample.url"
    fill_in "Restrictions", with: "Reaserch affiliation needed"
    fill_in "Phase", with: "Production"
    fill_in "Activate message", with: "Welcome!!!"
    select provider.name, from: "service_provider_id"

    check "Open access"
    fill_in "service_contact_emails_0", with: "person1@test.ok"
    page.find("#add-email-field").click
    fill_in "service_contact_emails_1", with: "person2@test.ok"

    expect { click_on "Create Service" }.
      to change { user.owned_services.count }.by(1)

    expect(page).to have_content("service title")
    expect(page).to have_content("service description")
    expect(page).to have_content("service terms of use")
    expect(page).to have_content("service tagline")
    expect(page).to have_content("https://sample.url")
    expect(page).to have_content("true")
    expect(page).to have_content("person1@test.ok")
    expect(page).to have_content("person2@test.ok")
    expect(page).to have_content("Welcome!!!")
  end

  scenario "I can edit owned service" do
    service = create(:service, title: "my service", owner: user)

    visit backoffice_service_path(service)
    click_on "Edit"

    fill_in "Title", with: "updated title"
    click_on "Update Service"

    expect(page).to have_content("updated title")
  end
end
