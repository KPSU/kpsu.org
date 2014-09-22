class App
    include ActiveModel::Validations
    validates_presence_of :email, :sender_name, :phone
    validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    validates_format_of :sender_name, :with => /[a-z]+ [a-z]+/i
    validates_format_of :phone, :with => /(1-)?[0-9]{3}-[0-9]{3}-[0-9]{4}/
    validates_format_of :reason, :previous_radio_exp, :previous_volunteer_exp, 
        :favorite_show, :show_ideas, :with => /([a-zA-Z]|\.|\?|!|)+/
    attr_accessor :id, :email, :sender_name, :phone, :is_student, :reason, :previous_radio_exp,
        :previous_volunteer_exp, :favorite_show, :show_ideas

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
            Notifier.app_notification(self).deliver!
            return true
        end
        return false
    end   
end
