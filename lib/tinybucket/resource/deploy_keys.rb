module Tinybucket
  module Resource
    class DeployKeys < Tinybucket::Resource::Base
      def initialize(repo, options)
        @repo = repo
        @args = [options]
      end

      # Find the deploy key
      #
      # @param uuid [String]
      # @param options [Hash]
      # @return [Tinybucket::Model::DeployKey]
      def find(uuid, options = {})
        deploy_keys_api.find(uuid, options).tap do |m|
          inject_repo_keys(m, @repo.repo_keys)
        end
      end

      # Create a deploy key
      #
      # @param key [String]
      # @param label [String]
      # @param options [Hash]
      # @return [Tinybucket::Model::DeployKey]
      def create(key, label = '', options = {})
        deploy_keys_api.post(key, label, options).tap do |m|
          inject_repo_keys(m, @repo.repo_keys)
        end
      end

      private

      def deploy_keys_api
        create_api('DeployKeys', @repo.repo_keys)
      end

      def enumerator
        create_enumerator(deploy_keys_api, :list, {})
      end
    end
  end
end
