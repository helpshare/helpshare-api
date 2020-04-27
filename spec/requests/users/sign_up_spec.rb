# frozen_string_literal: true

require 'rails_helper'

describe 'POST /users/sign_up', type: :request do
  subject(:request) { post url, params: params }

  let(:parsed_body) { JSON.parse(response.body) }
  let(:url) { '/api/users/sign_up' }
  let(:email) { 'user1@helpshare.com' }
  let(:password) { 'password' }
  let(:params) { credentials }

  before do
    request
  end

  context 'with valid credentials' do
    let(:credentials) { { email: email, password: password } }

    it 'creates user and returns 200', :aggregate_failures do
      expect(response.status).to eq(200)
      expect(User.count).to eq(1)
    end
  end

  context 'with invalid credentials' do
    let(:credentials) { { email: email, password: 'i' } }

    it 'does not create user and return 422', :aggregate_failures do
      expect(response.status).to eq(422)
      expect(User.count).to eq(0)
    end
  end
end
