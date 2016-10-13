module Tinybucket
  module Api
    module Helper
      extend ActiveSupport::Autoload

      [
        :ApiHelper,
        :BranchRestrictionsHelper,
        :BranchesHelper,
        :BuildStatusHelper,
        :CommitsHelper,
        :CommentsHelper,
        :DeployKeysHelper,
        :DiffHelper,
        :EmailsHelper,
        :HooksHelper,
        :ReposHelper,
        :RepoHelper,
        :PullRequestsHelper,
        :TeamHelper,
        :UserHelper
      ].each do |klass_name|
        autoload klass_name
      end
    end
  end
end
