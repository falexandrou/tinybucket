module Tinybucket
  module Resource
    module User
      class OwnersTeams < Tinybucket::Resource::User::Base
        private

        def enumerator
          create_user_enumerator(:owners_teams)
        end
      end
    end
  end
end
