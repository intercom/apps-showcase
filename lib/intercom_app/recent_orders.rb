# module IntercomApp
  class RecentOrders
    def self.cancel_order_canvas(order:)
      components = [
        {
          "type": "text",
          "text": "*Cancel your order*",
          "style": "header"
        },
        {
          "type": "text",
          "text": "This is your latest order as of #{Time.now}",
          "style": "paragraph"
        }
      ]
      components += self.order_components(order: order)
      components += [
        {
          "type": "text",
          "text": "Do you want to cancel this one, or another?",
          "style": "paragraph"
        },
        { 
          type: "button", 
          label: "Cancel this order", 
          style: "primary", 
          id: "cancel_order_#{order["id"]}", 
          action: {type: "submit"} 
        },
        { 
          type: "button", 
          label: "Choose another", 
          style: "secondary", 
          id: "choose_another", 
          action: {type: "submit"} 
        }
      ]
      return {
        canvas: {
          content: {
            components: components
          },
        },
      }
    end

    def self.order_components(order:)
      components = [{
        "type": "text",
        "text": "*Order #: #{order["id"]}*",
        "style": "header"
      },
      {
        "type": "spacer",
        "size": "xs"
      }]
      components += order["items"].map do |item|
        {
          "type": "text",
          "text": "*#{item["quantity"]} #{item["description"]}*",
          "style": "paragraph"
        }
      end
      components
    end

    def self.cancel_order_canvas()
      {
        canvas: {
          content: {
            components: [
              {
                "type": "text",
                "text": "*Please help us out*",
                "style": "header"
              },
              {
                "type": "text",
                "text": "Why are you cancelling this order?",
                "style": "paragraph"
              },
              { 
                type: "button", 
                label: "Takes too long", 
                style: "secondary", 
                id: "reason_time", 
                action: {type: "submit"} 
              },
              { 
                type: "button", 
                label: "Mistake in my customer data", 
                style: "secondary", 
                id: "reason_data_mistake", 
                action: {type: "submit"} 
              },
              { 
                type: "button", 
                label: "Ordered incorrectly", 
                style: "secondary", 
                id: "reason_ordered_incorrectly", 
                action: {type: "submit"} 
              },
              { 
                type: "button", 
                label: "Purchase price is too high", 
                style: "secondary", 
                id: "reason_price", 
                action: {type: "submit"} 
              },
              { 
                type: "button", 
                label: "Don't want a credit/identity check", 
                style: "secondary", 
                id: "reason_credit_check", 
                action: {type: "submit"} 
              },
              { 
                type: "button", 
                label: "Changed my mind", 
                style: "secondary", 
                id: "reason_changed_mind", 
                action: {type: "submit"} 
              },
              { 
                type: "button", 
                label: "Forgot to use a voucher", 
                style: "secondary", 
                id: "reason_voucher", 
                action: {type: "submit"} 
              },
              { 
                type: "button", 
                label: "Other", 
                style: "secondary", 
                id: "reason_other", 
                action: {type: "submit"} 
              },
            ], 
          },
        },
      }
    end

    def self.recent_orders_canvas(orders:)
      components = [
        {
          "type": "text",
          "text": "*Your recent orders*",
          "style": "header"
        }
      ]
      #TODO: rename 
      order_components = orders.map.with_index do |order, index| 
        comp = self.order_components(order: order)
        comp << { "type": "divider" } unless index == orders.length - 1
        comp
      end
      components += order_components.flatten
      return {
        canvas: {
          content: {
            components: components
          },
        },
      }
    end

    def self.feedback_canvas
      {
        canvas: {
          content: {
            components: [
              {
                "type": "text",
                "text": "*Please help us out*",
                "style": "header"
              },
              {
                "type": "textarea",
                "id": "feedback",
                "label": "Any additional comments? Feel free to leave them here",
                "placeholder": "Leave your feedback..."
              },
              { 
                type: "button", 
                label: "Submit feedback", 
                style: "primary", 
                id: "submit_feedback", 
                action: {type: "submit"} 
              },
              { 
                type: "button", 
                label: "Skip", 
                style: "secondary", 
                id: "skip", 
                action: {type: "submit"} 
              }
            ], 
          },
        },
      }
    end

    def self.feedback_submitted_canvas
      {
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
    end

    def self.no_feedback_submitted_canvas
      {
        canvas: {
          content: {
            components: [
              {
                "type": "text",
                "text": "Your order has been canceled",
                "style": "header"
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
                "style": "header"
              },
            ], 
          },
        },
      }
    end
  end
# end
