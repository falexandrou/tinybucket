module Tinybucket
  module Api
    module Helper
      module DeployKeysHelper
        include ::Tinybucket::Api::Helper::ApiHelper

        private

        def path_to_list
          base_path
        end

        def path_to_find(pk)
          build_path(base_path, [pk, 'pk'])
        end

        def path_to_post
          base_path
        end

        def path_to_delete(pk)
          build_path(base_path, [pk, 'pk'])
        end

        def base_path
          build_path('/repositories',
                     [repo_owner, 'repo_owner'],
                     [repo_slug, 'repo_slug'],
                     'deploy-keys')
        end
      end
    end
  end
end
