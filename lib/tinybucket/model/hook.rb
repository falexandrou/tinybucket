module Tinybucket
  module Model
    # Profile
    #
    # @see https://confluence.atlassian.com/bitbucket/users-endpoint-423626336.html#usersEndpoint-GETtheuserprofile
    #   users Endpoint - Bitbucket Cloud REST API document
    #
    # @!attribute [rw] read_only
    #   @return [Boolean]
    # @!attribute [rw] description
    #   @return [String]
    # @!attribute [rw] links
    #   @return [Hash]
    # @!attribute [rw] email
    #   @return [String]
    # @!attribute [rw] url
    #   @return [String]
    # @!attribute [rw] created_at
    #   @return [String]
    # @!attribute [rw] skip_cert_verification
    #   @return [Boolean]
    # @!attribute [rw] source
    #   @return [Hash]
    # @!attribute [rw] active
    #   @return [Boolean]
    # @!attribute [rw] subject
    #   @return [Hash]
    # @!attribute [rw] type
    #   @return [String]
    # @!attribute [rw] events
    #   @return [Array]
    # @!attribute [rw] uuid
    #   @return [String]
    class Hook < Base
      acceptable_attributes \
        :read_only, :description, :links, :url, \
        :created_at, :skip_cert_verification, :source, \
        :active, :subject, :type, :events, :uuid

      def update(options)
        hook_api.update(uuid, options)
      end

      def destroy
        hook_api.delete(uuid)
      end

      private

      def hook_api
        create_api('Hooks')
      end

      def load_model
        hook_api.find(uuid)
      end
    end
  end
end
