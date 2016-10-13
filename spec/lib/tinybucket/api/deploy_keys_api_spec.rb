require 'spec_helper'

RSpec.describe Tinybucket::Api::DeployKeysApi do
  include ApiResponseMacros

  let(:key_id) { "1" }
  let(:key_payload)  do
    {
      :key => "ssh-rsa AAAAaaaaabbbcccccddddd1234556 user@computer",
      :label => "Key label",
    }
  end

  let(:request_path) { nil }
  let(:options) { {} }
  let(:owner) { 'test_owner' }
  let(:slug)  { 'test_repo' }

  let(:api) do
    api = Tinybucket::Api::DeployKeysApi.new
    api.repo_owner = owner
    api.repo_slug  = slug
    api
  end

  it { expect(api).to be_a_kind_of(Tinybucket::Api::BaseApi) }

  let(:request_method) { :get }
  let(:stub_options) { nil }

  before do
    if request_path
      opts = stub_options.present? ? stub_options : {}
      # @V1-cleanup
      stub_v1_apiresponse(request_method, request_path, opts)
    end
  end

  describe 'list' do
    subject { api.list(options) }

    context 'without owner' do
      let(:owner) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'without slug' do
      let(:slug) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'with owner and slug' do
      let(:request_path) { "/repositories/#{owner}/#{slug}/deploy-keys" }
      it { expect(subject).to be_an_instance_of(Tinybucket::Model::Page) }
    end
  end

  describe 'find' do
    subject { api.find(key_id, options) }

    context 'without owner' do
      let(:owner) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'without slug' do
      let(:slug) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'with owner and slug' do
      let(:request_path) do
        "/repositories/#{owner}/#{slug}/deploy-keys/#{key_id}"
      end
      it { expect(subject).to be_instance_of(Tinybucket::Model::DeployKey) }
    end
  end

  describe 'post' do
    subject { api.post(key_payload[:key], key_payload[:label], options) }

    context 'without owner' do
      let(:owner) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'without slug' do
      let(:slug) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'with owner and slug' do
      let(:request_method) { :post }
      let(:request_path) { "/repositories/#{owner}/#{slug}/deploy-keys" }
      it { expect(subject).to be_instance_of(Tinybucket::Model::DeployKey) }
    end
  end

  describe 'delete' do
    subject { api.delete(key_id) }

    context 'without owner' do
      let(:owner) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'without slug' do
      let(:slug) { nil }
      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'without key_id' do
      let(:key_id) { nil }
      it { expect { api.delete(key_id) }.to raise_error(ArgumentError) }
    end

    context 'with owner and slug' do
      let(:request_method) { :delete }
      let(:request_path) { "/repositories/#{owner}/#{slug}/deploy-keys/#{key_id}" }
      it { expect(subject).to be_truthy }
    end
  end

end
