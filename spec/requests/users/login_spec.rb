# frozen_string_literal: true

require 'rails_helper'

describe 'POST /users/login', type: :request do
  subject(:request) { post url, params: params }

  let(:parsed_body) { JSON.parse(response.body) }
  let(:url) { '/api/users/login' }
  let(:user) { create(:user, email: email, password: password) }
  let(:email) { 'user@helpshare.com' }
  let(:password) { 'password' }
  let(:params) { credentials }

  before do
    user
    request
  end

  context 'with valid credentials' do
    let(:credentials) { { email: user.email, password: password } }

    it 'returns auth token' do
      auth_token = parsed_body.dig('auth_token')

      expect(auth_token).to match(/^ey*/)
    end
  end

  context 'with invalid credentials' do
    let(:credentials) { { email: user.email, password: 'invalid' } }

    it 'returns an error' do
      error_message = parsed_body.dig('data', 'attributes', 'message')
      expected_error_message = HelpshareErrors::Unauthenticated.new.message

      expect(error_message).to eq(expected_error_message)
    end
  end
end
