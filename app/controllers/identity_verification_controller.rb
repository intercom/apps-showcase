class IdentityVerificationController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:initialize_url, :submit_url]

  def initialize_url
    render json: Intercom::IdentityVerification.send_code_canvas
  end

  def submit_url
    case params[:component_id]
    when "get_verification_code" || "resend_sms"
      Rails.logger.info("Sending SMS")
      render json: Intercom::IdentityVerification.submit_code_canvas
    when "submit_verification_code"
      email = params[:customer][:email]
      verification_code = params[:input_values][:enter_verification_code]
      if Intercom::IdentityVerification.verify_submission(email: email, verification_code: verification_code)
        render json: Intercom::IdentityVerification.identity_verification_succeeded_canvas
      else
        render json: Intercom::IdentityVerification.identity_verification_failed_canvas
      end      
    else
      render json: Intercom::IdentityVerification.error_canvas
    end
  end
end
