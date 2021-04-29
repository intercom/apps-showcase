module IntercomApp
  class IdentityVerification
    def self.initial_component
        json: {
          canvas: {
            content: {
              components: [
                {
                  "type": "text",
                  "text": "*Identity Verification*",
                  "style": "header"
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

    def self.verify_submission(email:, code:)
      [true, false].sample
    end

    def self.verification_incomplete_component
    end
  end
end