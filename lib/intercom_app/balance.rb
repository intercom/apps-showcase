module IntercomApp
    class Balance
      def self.balance_component(email:)
        # We'd ideally use a service to find balance
        balance = Rand(email.length)
        json: {
          canvas: {
            content: {
              components: [
                {
                  "type": "text",
                  "text": "Your balance is #{balance}",
                  "style": "paragraph"
                }
              ],
            }
          }
        }
      end
    end
end
