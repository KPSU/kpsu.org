class DjApplication
    include ActiveModel::Validations

    validates_presence_of( :date, :first_name, :last_name, :phone_number, :email, :is_student,
        :reason, :past_radio_experience, :past_volunteer_experience, :favorite_kpsu_shows,
        :show_type)
    attr_accessor( :id, :date, :first_name, :last_name, :phone_number, :email, :is_student,
                  :reason, :past_radio_experience, :past_volunteer_experience, :favorite_kpsu_shows,
                  :show_type)

    def initialize(attributes = {})
        attributes.each do |key, value|
            self.send("#{key}=", value)
        end
        @attributes = attributes
    end

    def read_attribute_for_validation(key)
        @attributes[key]
    end

    def to_key
    end

    def save
        if self.valid?
            Notifier.new_application_notification(self).deliver!
            return true
        end
         return false
    end
end
