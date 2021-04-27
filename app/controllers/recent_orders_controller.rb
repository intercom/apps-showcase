class RecentOrdersController < ApplicationController
  def initialize
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
