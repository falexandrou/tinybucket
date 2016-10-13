module Tinybucket
  module Model
    # Deploy Key
    #
    # @!attribute [rw] pk
    #   @return [String]
    # @!attribute [rw] key
    #   @return [String]
    # @!attribute [rw] label
    #   @return [String]
    class DeployKey < Base
      include Tinybucket::Model::Concerns::RepositoryKeys

      acceptable_attributes :pk, :key, :label

      def destroy
        deploy_keys_api.delete(pk)
      end

      private

      def deploy_keys_api
        create_api('DeployKeys', repo_keys)
      end

      def load_model
        deploy_keys_api.find(name, {})
      end
    end
  end
end
