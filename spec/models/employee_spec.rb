require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe 'relationships' do
    it { should belong_to :department }
    it { should have_many :employee_tickets }
    it { should have_many(:tickets).through(:employee_tickets) }
  end

  describe 'model methods' do
    describe '#tickets_by_age' do
      it "sorts oldest to youngest" do
        department_1 = Department.create!(name: "Marketing", floor: "Sixth")
        department_2 = Department.create!(name: "IT", floor: "Basement")

        employee_1 = department_1.employees.create!(name: "Gunther", level: 2)
        employee_2 = department_1.employees.create!(name: "Selena", level: 5)
        employee_3 = department_2.employees.create!(name: "Tom", level: 7)
        employee_4 = department_2.employees.create!(name: "Jessi", level: 3)

        ticket_1 = Ticket.create!(subject: "Story board 2", age: 5)
        ticket_2 = Ticket.create!(subject: "Email partners", age: 1)
        ticket_3 = Ticket.create!(subject: "Plan Campaign 3", age: 10)
        ticket_4 = Ticket.create!(subject: "Plan Campaign 1", age: 7)

        EmployeeTicket.create!(employee_id: employee_1.id, ticket_id: ticket_1.id)
        EmployeeTicket.create!(employee_id: employee_1.id, ticket_id: ticket_2.id)
        EmployeeTicket.create!(employee_id: employee_1.id, ticket_id: ticket_3.id)
        EmployeeTicket.create!(employee_id: employee_2.id, ticket_id: ticket_4.id)

        expect(employee_1.tickets_by_age).to eq([ticket_3, ticket_1, ticket_2])
      end
    end

    describe '#oldest_ticket' do
      it "plucks the oldest ticket by age" do
        department_1 = Department.create!(name: "Marketing", floor: "Sixth")
        department_2 = Department.create!(name: "IT", floor: "Basement")

        employee_1 = department_1.employees.create!(name: "Gunther", level: 2)
        employee_2 = department_1.employees.create!(name: "Selena", level: 5)
        employee_3 = department_2.employees.create!(name: "Tom", level: 7)
        employee_4 = department_2.employees.create!(name: "Jessi", level: 3)

        ticket_1 = Ticket.create!(subject: "Story board 2", age: 5)
        ticket_2 = Ticket.create!(subject: "Email partners", age: 1)
        ticket_3 = Ticket.create!(subject: "Plan Campaign 3", age: 10)
        ticket_4 = Ticket.create!(subject: "Plan Campaign 1", age: 7)

        EmployeeTicket.create!(employee_id: employee_1.id, ticket_id: ticket_1.id)
        EmployeeTicket.create!(employee_id: employee_1.id, ticket_id: ticket_2.id)
        EmployeeTicket.create!(employee_id: employee_1.id, ticket_id: ticket_3.id)
        EmployeeTicket.create!(employee_id: employee_2.id, ticket_id: ticket_4.id)

        expect(employee_1.oldest_ticket).to eq(ticket_3.subject)
      end
    end
  end
end