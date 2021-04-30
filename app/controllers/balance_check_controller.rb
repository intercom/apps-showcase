class BalanceCheckController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:initialize_url, :submit_url]
  
    def initialize_url
      render IdentityVerification.send_code_canvas
    end

    def submit_url
        if params[:component_id] == "get_verification_code"
            verified = IdentityVerification.verify_submission(email: params[:email], code: params[:input_values])
            if verified 
                render Balance.balance_component(email: params[:email])
            else
                render IdentityVerification.identity_verification_failed_canvas
            end
        end
    end
end