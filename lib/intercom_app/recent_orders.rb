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
      components += self.order_component(order: order)
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

    def self.order_component(items)
      components = [{
        "type": "text",
        "text": "*Order #: #{order["id"]}*",
        "style": "header"
      },
      {
        "type": "divider"
      }]
      components += items.map do |item|
        {
          "type": "text",
          "text": "*#{item["quantity"]} #{item["description"]}*",
          "style": "paragraph"
        }
      end
      components
    end

    def self.cancel_order_component(order_id:)
      # Here we would cancel the order
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

    def self.recent_orders_component
      order_file = File.read('./lib/data/orders.json')
      orders = JSON.parse(order_file)
      orders.drop(1) #Should actually remove the latest
      components = [
        {
          "type": "text",
          "text": "*Your recent orders*",
          "style": "header"
        }
      ]
      components += orders.map{|order| self.order_components(order: order)}.flatten
    
      # Should add space in between orders
      return {
        canvas: {
          content: {
            components: components
          },
        },
      }
    end
  end
# end
