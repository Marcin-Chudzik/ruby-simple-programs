# frozen_string_literal: true

require 'delegate'

class Person
  attr_reader :first_name, :last_name, :email

  def initialize(first_name, last_name, email)
    @first_name = first_name
    @last_name = last_name
    @email = email
  end
end

class PersonDecorator < SimpleDelegator
  def link_to_email
    "<a href=\"mailto:#{email}\">#{first_name} #{last_name}</a>"
  end
end

person = Person.new('Marcin', 'Chudzik', 'chmc2001@gmail.com')
puts PersonDecorator.new(person).link_to_email
