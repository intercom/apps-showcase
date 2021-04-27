class RecentOrdersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:initialize_url]
  # , :submit_url, :submit_sheet_url
  # after_action :allow_iframe, only: :submit_sheet_url

  def initialize_url
    Rails.logger.info("Params for initialize_url:#{params}")
    render json: {
      canvas: {
        content: {
          components: [
              {
                "type": "input",
                "id": "address",
                "label": "Address",
                "placeholder": "Enter address here...",
                "save_state": "unsaved"
              },
              {
                "type": "input",
                "id": "pincode",
                "label": "Pincode",
                "placeholder": "Enter pincode here...",
                "save_state": "unsaved"
              },
            { type: "button", 
            label: "Verify your details", 
            style: "primary", 
            id: "verification_form", 
            action: {type: "submit"} 
          },
          ], 
        },
      },
    }
  end
end
