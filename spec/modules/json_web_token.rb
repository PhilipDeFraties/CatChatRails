require 'rails_helper'

RSpec.describe JsonWebToken do
  let(:payload) { { user_id: 1 } }
  let(:token) { JsonWebToken.jwt_encode(payload) }

  describe '#jwt_encode' do
    it 'encodes the payload into a JWT token' do
      expect(token).to be_a(String)
    end
  end

  describe '#jwt_decode' do
    it 'decodes the JWT token into the original payload' do
      decoded_payload = JsonWebToken.jwt_decode(token)
      expect(decoded_payload).to eq(payload.with_indifferent_access)
    end

    it 'raises an error if the token is invalid' do
      invalid_token = 'invalid_token'
      expect { JsonWebToken.jwt_decode(invalid_token) }.to raise_error(JWT::DecodeError)
    end
  end
end