class BalanceCheckController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:initialize_url, :submit_url]
    # :submit_sheet_url
    # after_action :allow_iframe, only: :submit_sheet_url
  
    def initialize_url
      render IntercomApp::IdentityVerification.initial_component
    end

    def submit_url
        if params[:component_id] == "get_verification_code"
            verified = IntercomApp::IdentityVerification.verify_submission(email: params[:email], code: params[:input_values])
            if verified 
                render IntercomApp::Balance.balance_component(email: params[:email])
            else
                render IntercomApp::IdentityVerification.verification_incomplete_component
            end
        end
    end
end