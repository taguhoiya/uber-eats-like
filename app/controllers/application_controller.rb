class ApplicationController < ActionController::API
        include DeviseTokenAuth::Concerns::SetUserByToken
    before_action :fake_load

    def fake_load
      sleep(1)
    end
end
