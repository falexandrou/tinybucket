require 'spec_helper'

RSpec.describe Tinybucket::Model::DeployKey do
  include ApiResponseMacros
  include ModelMacros

  let(:model_json) { load_json_fixture('deploy-key') }

  let(:request_path) { nil }
  let(:key_id) { "1" }
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
      # @V1-cleanup
      stub_v1_apiresponse(request_method, request_path, opts)
    end
  end

  it_behaves_like 'model has acceptable_attributes',
                  Tinybucket::Model::DeployKey,
                  load_json_fixture('deploy-key')

  describe 'model can reloadable' do
    let(:key) { Tinybucket::Model::DeployKey.new({}) }
    before { @model = key }
    it_behaves_like 'the model is reloadable'
  end

  describe "#delete" do
    let(:request_method) { :delete }
    let(:request_path) { "/repositories/#{owner}/#{slug}/deploy-keys/#{key_id}" }
    subject { model.destroy }
    it { expect(subject).to be_truthy }
  end

end
