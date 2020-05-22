class Employee < ApplicationRecord
    belongs_to :dog
    validate :validate_alias_and_title
    
    def to_s
        "#{self.first_name} #{self.last_name}"
    end

    def dog_id=(id)
        self.dog = Dog.find(id)
    end

    def validate_alias_and_title
        employee_aliases = Employee.where(alias: self.alias).select{|e| e.id != self.id}
        employee_titles = Employee.where(title: self.title).select{|e| e.id != self.id}

        binding.pry
        
        if !employee_aliases.empty?
            errors.add(self.alias, "That alias is already taken.")
        elsif !employee_titles.empty?
            errors.add(:title, "That title is already taken.")
        end
        
    end


end
