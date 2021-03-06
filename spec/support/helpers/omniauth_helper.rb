# frozen_string_literal: true

module OmniauthHelper
  def stub_omniauth(provider, options = {})
    first_name = options.fetch(:first_name, "John"),
    last_name = options.fetch(:last_name, "Doe"),

    OmniAuth.config.add_mock(
      provider,
      info: {
        first_name: first_name,
        last_name: last_name,
        email: options.fetch(:email, "#{first_name}.#{last_name}@email.pl")
      },
      provider: provider,
      uid: options.fetch(:uid, 123)
    )
  end

  def checkin_sign_in_as(user)
    stub_omniauth(
      :checkin,
      first_name: user.first_name,
      last_name: user.last_name,
      email: user.email,
      uid: user.uid
    )

    visit user_checkin_omniauth_authorize_path
  end
end
