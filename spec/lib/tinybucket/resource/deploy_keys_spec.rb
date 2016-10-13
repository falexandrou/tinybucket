require 'spec_helper'

RSpec.describe Tinybucket::Resource::DeployKeys do
  include ApiResponseMacros

  let(:key_id) { "1" }
  let(:owner) { 'test_owner' }
  let(:slug) { 'test_repo' }

  let(:repo) do
    Tinybucket::Model::Repository.new({}).tap do |m|
      m.repo_owner = owner
      m.repo_slug  = slug
    end
  end

  let(:options) { {} }
  let(:resource) { Tinybucket::Resource::DeployKeys.new(repo, options) }

  describe '#find' do
    let(:request_path) { "/repositories/#{owner}/#{slug}/deploy-keys/#{key_id}" }
    # @V1-cleanup
    before { stub_v1_enum_response(:get, request_path) }
    subject { resource.find(key_id) }
    it { expect(subject).to be_an_instance_of(Tinybucket::Model::DeployKey) }
  end

  describe 'Enumerable Methods' do
    let(:request_path) { "/repositories/#{owner}/#{slug}/deploy-keys" }
    # @V1-cleanup
    before { stub_v1_enum_response(:get, request_path) }

    describe '#take(1)' do
      subject { resource.take(1) }
      it { expect(subject).to be_an_instance_of(Array) }
    end

    describe '#each' do
      it 'iterate models' do
        resource.each do |m|
          expect(m).to be_an_instance_of(Tinybucket::Model::DeployKey)
        end
      end
    end
  end
end
