class BalanceCheckController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:initialize_url, :submit_url]
  
    def initialize_url
      render Intercom::IdentityVerification.send_code_canvas
    end

    def submit_url
        if params[:component_id] == "get_verification_code"
            email = params[:customer][:email]
            verification_code = params[:input_values][:enter_verification_code]
            if Intercom::IdentityVerification.verify_submission(email: email, verification_code: verification_code) 
                render Intercom::Balance.balance_component(email: email)
            else
                render Intercom::IdentityVerification.identity_verification_failed_canvas
            end
        end
    end
end