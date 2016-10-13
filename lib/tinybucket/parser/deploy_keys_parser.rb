module Tinybucket
  module Parser
    class DeployKeysParser < BaseParser
      def convert(json)
        Tinybucket::Model::Page.new(json, Tinybucket::Model::DeployKey)
      end
    end
  end
end
