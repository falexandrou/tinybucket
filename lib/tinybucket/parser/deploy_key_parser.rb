module Tinybucket
  module Parser
    class DeployKeyParser < BaseParser
      def convert(json)
        ::Tinybucket::Model::DeployKey.new(json)
      end
    end
  end
end
