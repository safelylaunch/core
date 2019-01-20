# frozen_string_literal: true

module Auth
  module Oauth
    class GoogleCallback < WebBouncer::OauthCallback
      def call(_oauth_response)
        account = Account.new(id: 1)
        # account = auth_identitie_repo.find_account(uid: oauth_response['uid'], type: 'google')
        #
        # unless account
        #   account = account_repo.create(account_data(oauth_response))
        #   auth_identitie_repo.create(account_id: account.id, **oauth_data(oauth_response))
        # end

        Success(account)
      end

      private

      # def auth_identitie_repo
      #   @auth_identitie_repo ||= AuthIdentityRepository.new
      # end
      #
      # def account_repo
      #   @account_repo ||= AccountRepository.new
      # end
      #
      # def oauth_data(data)
      #   {
      #     uid:   data['uid'],
      #     token: data['credentials']['token'],
      #     type:  'google'
      #   }
      # end
      #
      # def account_data(data)
      #   {
      #     name:       data['info']['name'],
      #     uuid:       SecureRandom.uuid,
      #     email:      data['info']['email'],
      #     avatar_url: data['info']['image'],
      #     role:       'user'
      #   }
      # end
    end
  end
end
