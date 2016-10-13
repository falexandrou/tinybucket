require 'spec_helper'

RSpec.describe Tinybucket::Model::DeployKey do
  include ApiResponseMacros
  include ModelMacros

  let(:model_json) { load_json_fixture('deploy-key') }

  let(:request_path) { nil }

  let(:owner) { 'test_owner' }
  let(:slug) { 'test_repo' }

  let(:model) do
    m = Tinybucket::Model::DeployKey.new(model_json)
    m.repo_owner = owner
    m.repo_slug  = slug
    m
  end

  let(:request_method) { :get }
  let(:stub_options) { nil }

  before do
    if request_path
      opts = stub_options.present? ? stub_options : {}
      stub_apiresponse(request_method, request_path, opts)
    end
  end

  it_behaves_like 'model has acceptable_attributes',
                  Tinybucket::Model::DeployKey,
                  load_json_fixture('deploy-key')

  describe 'model can reloadable' do
    let(:branch) { Tinybucket::Model::DeployKey.new({}) }
    before { @model = branch }
    it_behaves_like 'the model is reloadable'
  end
end
