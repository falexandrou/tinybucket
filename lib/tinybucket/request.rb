module Tinybucket
  module Request
    protected

    def get_path(path, params = {}, parser = nil, options = {})
      request(:get, path, params, parser, options)
    end

    def patch_path(path, params = {}, parser = nil, options = {})
      request(:patch, path, params, parser, options)
    end

    def post_path(path, params = {}, parser = nil, options = {})
      request(:post, path, params, parser, options)
    end

    def put_path(path, params = {}, parser = nil, options = {})
      request(:put, path, params, parser, options)
    end

    def delete_path(path, params = {}, parser = nil, options = {})
      request(:delete, path, params, parser, options)
    end

    private

    def request(method, path, params, parser, options)
      conn = connection(options, parser)
      # @V1-cleanup => This will keep me awake at nights
      # Horrible hack - I blame BitBucket for releasing their v2 api
      # partially and also for bitbucket_rest_api for being such a douchy gem
      # sadly deploy keys is still in 1.0
      if path.include?('/deploy-keys')
        endpoint = conn.url_prefix.to_s.gsub(/\/2\.0/i, '/1.0')
        conn.url_prefix = URI(endpoint)
      end

      path = (conn.path_prefix + path).gsub(%r{//}, '/') \
        if conn.path_prefix != '/'

      response = conn.send(method) do |request|
        case method.intern
        when :get, :delete
          request.body = params.delete('data') if params.key?('data')
          request.url(path, params)
        when :post, :put, :patch
          request.path = path
          request.headers = {'Content-Type': 'application/json'} if path.include?('/deploy-keys')
          request.body = extract_data_from_params(params) unless params.empty?
        else
          raise ArgumentError, 'unknown http method: ' + method
        end
      end

      # 1.0 api sadness - i apologized a few lines above
      # @V1-cleanup
      if path.match(/\/deploy\-keys$/) && method == :get
        return Tinybucket::Model::Page.new({
          pagelen: 10,
          values: response.body,
          page: 1,
          size: response.body.length
        }, Tinybucket::Model::DeployKey)
      end

      response.body
    end

    def extract_data_from_params(params)
      if params.key?('data') && !params['data'].nil?
        params['data']
      else
        params
      end
    end
  end
end
