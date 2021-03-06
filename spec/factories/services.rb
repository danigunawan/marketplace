# frozen_string_literal: true

FactoryBot.define do
  factory :service do
    sequence(:title) { |n| "service #{n}" }
    sequence(:description) { |n| "service #{n} description" }
    sequence(:terms_of_use) { |n| "service #{n} terms of use" }
    sequence(:tagline) { |n| "service #{n} tagline" }
    sequence(:open_access) { false }
    provider

    factory :open_access_service do
      sequence(:connected_url) { "https://sample.url" }
      sequence(:open_access) { true }
    end
    sequence(:webpage_url) { "https://wabpage.url"  }
    sequence(:manual_url) { "https://manual.url"  }
    sequence(:helpdesk_url) { "https://helpdesk.url"  }
    sequence(:tutorial_url) { "https://tutorial.url"  }
    sequence(:terms_of_use_url) { "https://terms.of.use.url"  }
    sequence(:corporate_sla_url) { "https://corporate.sla.url"  }
    sequence(:access_policies_url) { "https://access.policies.url"  }

    sequence(:places) { |n| "service #{n} place" }
    sequence(:languages) { |n| "service #{n} lanuage" }
    sequence(:dedicated_for) { |n| "service #{n} dedicated for" }
    sequence(:restrictions) { |n| "service #{n} restrictions" }
    sequence(:phase) { |n| "service #{n} phase" }
  end
end
