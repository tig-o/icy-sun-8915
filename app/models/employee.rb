class Employee < ApplicationRecord
  belongs_to :department
  has_many :employee_tickets
  has_many :tickets, through: :employee_tickets

  def tickets_by_age
    tickets.order(age: :desc)
  end

  def oldest_ticket
    tickets.order(age: :desc).first.subject
  end
end