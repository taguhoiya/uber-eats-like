class ApplicationController < ActionController::API
        include DeviseTokenAuth::Concerns::SetUserByToken
        include ActionController::MimeResponds
    before_action :fake_load

    def fake_load
      sleep(1)
    end

    def fallback_index_html
        respond_to do |format|
            format.html { render body: Rails.root.join('public/index.html').read }
        end
    end
end
