module Intercom
    class Balance
      def self.balance_canvas(email:)
        # We'd ideally use a service to find balance
        # balance = Rand(email.length)
        {
          canvas: {
            content: {
              components: [
                {
                  "type": "text",
                  "text": "Your balance is #{Rand(10)}",
                  "style": "paragraph"
                }
              ],
            }
          }
        }
      end
    end
end
