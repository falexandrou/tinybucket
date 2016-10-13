module Tinybucket
  module Api
    # Hooks Api client
    #
    # @!attribute [rw] repo_owner
    #   @return [String] repository owner name.
    # @!attribute [rw] repo_slug
    #   @return [String] repository slug. (about {https://developer.atlassian.com/bitbucket/api/2/reference/resource/repositories/%7Busername%7D/%7Brepo_slug%7D
    class DeployKeysApi < BaseApi
      include Tinybucket::Api::Helper::DeployKeysHelper

      attr_accessor :repo_owner, :repo_slug

      # Send 'GET a Deploy Keys list for a repository' request
      #
      # @param options [Hash]
      # @return [Tinybucket::Model::Page]
      def list(options = {})
        get_path(
          path_to_list,
          options,
          Tinybucket::Parser::DeployKeysParser
        )
      end

      # Send 'GET an individual deploy key' request
      #
      # @param key_id [String] A UUID for the key.
      # @param options [Hash]
      # @return [Tinybucket::Model::DeployKey]
      def find(key_id, options = {})
        get_path(
          path_to_find(key_id),
          options,
          Tinybucket::Parser::DeployKeyParser
        )
      end


      # Send 'POST a deploy key for a repository' request
      #
      # @param key [String]
      # @param label [String]
      # @param options [Hash]
      # @return [Tinybucket::Model::DeployKey]
      def post(key, label = '', options = {})
        post_path(
          path_to_post,
          options.merge(
            key: key,
            label: label
          ),
          Tinybucket::Parser::DeployKeyParser
        )
      end

      # Send 'DELETE a deploy key for a repository' request
      #
      # @param options [Hash] The attributes to update
      # @return [Boolean]
      def delete(key_id, options = {})
        delete_path(
          path_to_delete(key_id),
          options
        )
        true
      end

    end
  end
end
