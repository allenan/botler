module Butler
  class App
    module PhoneHelper
      def sanitize_phone(number)
        number.gsub(/[^\d]/, '').gsub(/^1/, '')
      end
    end

    helpers PhoneHelper
  end
end
