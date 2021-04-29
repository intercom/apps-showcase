class IdentityVerificationController < ApplicationController
  def initialize_url
    render json: {
      canvas: {
        content: {
          components: [
            {
              "type": "text",
              "text": "*Identity Verification*",
              "style": "header"
            },
            {
              "type": "text",
              "text": "For your safety, we need to verify it's really you. Click the button to receive a verification code via SMS to 0774855417",
              "style": "paragraph"
            },
            { 
              type: "button", 
              label: "Get verification code", 
              style: "primary", 
              id: "get_verification_code", 
              action: {type: "submit"} 
            },
          ], 
        },
      },
    }
  end

  def submit_url
    case params[:component_id]
    when "get_verification_code" || "resend_sms"
      Rails.logger.info("Sending SMS")
      render json: {
        canvas: {
          content: {
            components: [
              {
                "type": "text",
                "text": "We sent your verification code to 0774855417. Please enter it here.",
                "style": "paragraph"
              },
              {
                "type": "input",
                "id": "enter_verification_code",
                "label": "Your verification code",
                "placeholder": "Enter your verification code"
              },
              { 
                type: "button", 
                label: "Submit code", 
                style: "primary", 
                id: "submit_verification_code", 
                action: {type: "submit"} 
              },
              { 
                type: "button", 
                label: "Resend SMS", 
                style: "secondary", 
                id: "resend_sms", 
                action: {type: "submit"} 
              },
            ], 
          },
        },
      }
    when "submit_code"
      render json: {
        canvas: {
          content: {
            components: [
              {
                "type": "text",
                "text": "*That's it!*",
                "style": "header"
              },
              {
                "type": "text",
                "text": "Your identity has been succesfully verified. We'll be in touch soon!",
                "style": "paragraph"
              },
            ], 
          },
        },
      }
      Rails.logger.info("Feedback submitted: #{params[:input_values]}")
      render json: {
        canvas: {
          content: {
            components: [
              {
                "type": "text",
                "text": "Thank you for your feedback. Your order has been canceled",
                "style": "header"
              },
            ], 
          },
        },
      }
    else
      render json: {
        canvas: {
          content: {
            components: [
              {
                "type": "text",
                "text": "Something went wrong",
                "style": "header"
              },
            ], 
          },
        },
      }
  end
end
