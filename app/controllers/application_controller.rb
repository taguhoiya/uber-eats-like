class ApplicationController < ActionController::API
        include DeviseTokenAuth::Concerns::SetUserByToken
        include ActionController::MimeResponds
    before_action :fake_load

    def fake_load
      sleep(1)
    end

    def fallback_index_html
        respond_to do |format|
            format.js { render body: Rails.root.join('public/App.js').read }
        end
    end
end
