module Intercom
  class IdentityVerification
    def self.send_code_canvas
      {
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
              }
            ], 
          },
        },
      }
    end

    def self.verify_submission(email:, verification_code:)
      Rails.logger.info("Verifying submission for email: #{email}, verification_code: #{verification_code}")
      [true, false].sample
    end

    def self.submit_code_canvas
      {
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
    end

    def self.identity_verification_succeeded_canvas
      {
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
    end

    def self.identity_verification_failed_canvas
      {
        canvas: {
          content: {
            components: [
              {
                "type": "text",
                "text": "Unfortunately, we couldn't verify your identity.",
                "style": "paragraph"
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
    end
    def self.error_canvas
      {
        canvas: {
          content: {
            components: [
              {
                "type": "text",
                "text": "Something went wrong",
                "style": "error"
              },
            ], 
          },
        },
      }
    end
  end
end